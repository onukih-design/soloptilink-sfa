#!/usr/bin/env node

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const { randomUUID } = require('crypto');

// ============================================================
// Constants
// ============================================================

const EXCEL_PATH = '/Users/onukifutoshishuu/Downloads/AI商社 案件管理表.xlsx';
const OUTPUT_SQL_PATH = path.join(__dirname, '../supabase/migrations/002_seed_data.sql');

// Fixed UUIDs for users (to avoid auth.users dependency)
const USER_IDS = {
  '小貫': '00000000-0000-0000-0000-000000000001',
  '樋上': '00000000-0000-0000-0000-000000000002',
  '高橋': '00000000-0000-0000-0000-000000000003',
  '野村': '00000000-0000-0000-0000-000000000004',
  '竹内': '00000000-0000-0000-0000-000000000005',
};

// ============================================================
// Utility Functions
// ============================================================

function excelDateToJS(excelDate) {
  if (!excelDate || typeof excelDate !== 'number') return null;
  // Excel dates start at 1900-01-01, but JavaScript Date uses Unix epoch
  // Excel serial 1 = 1900-01-01, but Excel incorrectly treats 1900 as leap year
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  return date;
}

function formatDate(excelDate) {
  const date = excelDateToJS(excelDate);
  if (!date || isNaN(date.getTime())) return null;
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

function formatTime(excelTime) {
  if (!excelTime || typeof excelTime !== 'number') return null;
  const hours = Math.floor(excelTime * 24);
  const minutes = Math.round((excelTime * 24 - hours) * 60);
  return `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:00`;
}

function escapeSQL(str) {
  if (str === null || str === undefined) return 'NULL';
  if (typeof str === 'number') return str.toString();
  if (typeof str === 'boolean') return str ? 'true' : 'false';

  // Convert to string and escape
  const cleaned = String(str)
    .replace(/\n/g, ' ')
    .replace(/\r/g, '')
    .trim();

  if (cleaned === '') return 'NULL';

  // Escape single quotes by doubling them
  const escaped = cleaned.replace(/'/g, "''");
  return `'${escaped}'`;
}

function clean(value) {
  if (value === null || value === undefined) return null;
  if (typeof value === 'string') {
    const cleaned = value.replace(/\n/g, ' ').replace(/\r/g, '').trim();
    return cleaned === '' ? null : cleaned;
  }
  return value;
}

function removeSama(name) {
  if (!name) return name;
  return name.replace(/様$/, '').trim();
}

// ============================================================
// Main Processing
// ============================================================

function main() {
  console.log('Reading Excel file...');
  const workbook = XLSX.readFile(EXCEL_PATH);

  const dealSheetName = '当月案件管理表';
  const aiToolSheetName = 'AIツール　受注管理表';
  const dropdownSheetName = 'プルダウン';

  if (!workbook.Sheets[dealSheetName]) {
    throw new Error(`Sheet "${dealSheetName}" not found`);
  }
  if (!workbook.Sheets[aiToolSheetName]) {
    throw new Error(`Sheet "${aiToolSheetName}" not found`);
  }

  const dealSheet = workbook.Sheets[dealSheetName];
  const aiToolSheet = workbook.Sheets[aiToolSheetName];
  const dropdownSheet = workbook.Sheets[dropdownSheetName];

  // Convert to JSON
  const dealData = XLSX.utils.sheet_to_json(dealSheet, { header: 1, defval: null });
  const aiToolData = XLSX.utils.sheet_to_json(aiToolSheet, { header: 1, defval: null });
  const dropdownData = dropdownSheet ? XLSX.utils.sheet_to_json(dropdownSheet, { header: 1, defval: null }) : [];

  console.log(`Deal records found: ${dealData.length}`);
  console.log(`AI Tool records found: ${aiToolData.length}`);

  // Parse headers (row 1 is headers, data starts from row 2)
  const dealHeaders = dealData[1] || [];
  const aiToolHeaders = aiToolData[1] || [];

  // ============================================================
  // Extract unique data
  // ============================================================

  const users = new Map();
  const companies = new Map();
  const contacts = new Map();
  const lists = new Set();
  const deals = [];
  const dealFollowups = [];
  const aiToolOrders = [];

  // ============================================================
  // Process Deal Data
  // ============================================================

  for (let i = 2; i < dealData.length; i++) {
    const row = dealData[i];
    if (!row || row.length === 0) continue;

    const dealNumber = row[0];
    if (!dealNumber) continue; // Skip rows without deal number

    // Extract data from row (based on actual Excel structure from Row 1)
    const companyName = clean(row[1]); // 企業名
    const phone = clean(row[2]); // 固定番号
    const mobile = clean(row[3]); // 携帯電話
    const contactName = removeSama(clean(row[4])); // 先方氏名
    const email = clean(row[5]); // メールアドレス
    const url = clean(row[6]); // URL
    const address = clean(row[7]); // 住所
    const gender = clean(row[8]); // 性別
    const appointerName = clean(row[9]); // アポ獲得者
    const appoDate = row[10]; // アポ取得日
    const meetingDate = row[11]; // 商談日
    const meetingTime = row[12]; // 商談時間
    const appoType = clean(row[13]); // アポ種別
    const appoTarget = clean(row[14]); // アポ先
    const listName = clean(row[15]); // リスト
    const memo = clean(row[16]); // 備考
    const reminderStatus = clean(row[17]); // リマインド
    const closerName = clean(row[18]); // クローザー
    const meetingResult = clean(row[19]); // 商談可否
    const orderResult = clean(row[20]); // 受注可否

    // Followups based on Row 1 header structure:
    // 最新 (フォロー1): 21-27
    // フォロー2: 28-36
    // フォロー3: 37-43
    // フォロー4: 44-50
    // フォロー5: 51-57
    // フォロー6: 58-64

    // Determine yomi_status
    let yomiStatus = 'ネタ';
    if (orderResult === '受注') {
      yomiStatus = '受注';
    } else if (orderResult === '失注') {
      yomiStatus = '失注';
    } else {
      // Check latest followup status (フォロー5 → フォロー1)
      const followup5Status = clean(row[60]); // col 60 = フォロー6ステータス
      const followup4Status = clean(row[53]); // col 53 = フォロー5ステータス
      const followup3Status = clean(row[46]); // col 46 = フォロー4ステータス
      const followup2Status = clean(row[39]); // col 39 = フォロー3ステータス
      const followup1Status = clean(row[30]); // col 30 = フォロー2ステータス
      const followup0Status = clean(row[23]); // col 23 = 最新ステータス

      const latestStatus = followup5Status || followup4Status || followup3Status || followup2Status || followup1Status || followup0Status;

      if (latestStatus === 'A') yomiStatus = 'Aヨミ';
      else if (latestStatus === 'B') yomiStatus = 'Bヨミ';
      else if (latestStatus === 'C') yomiStatus = 'Cヨミ';
      else if (latestStatus === '没ネタ') yomiStatus = '没ネタ';
      else if (latestStatus === '失注') yomiStatus = '失注';
      else if (latestStatus === '消滅') yomiStatus = '消滅';
    }

    // Add users
    if (appointerName && !users.has(appointerName)) {
      users.set(appointerName, {
        id: USER_IDS[appointerName] || randomUUID(),
        name: appointerName,
        email: `${appointerName}@soloptilink.com`,
        role: 'appointer'
      });
    }

    if (closerName && !users.has(closerName)) {
      users.set(closerName, {
        id: USER_IDS[closerName] || randomUUID(),
        name: closerName,
        email: `${closerName}@soloptilink.com`,
        role: 'closer'
      });
    }

    // Add company
    let companyId;
    if (companyName) {
      if (companies.has(companyName)) {
        companyId = companies.get(companyName).id;
      } else {
        companyId = randomUUID();
        companies.set(companyName, {
          id: companyId,
          name: companyName,
          phone,
          mobile,
          address,
          url,
          notes: null
        });
      }
    }

    // Add contact
    let contactId = null;
    if (contactName && companyId) {
      const contactKey = `${companyId}:${contactName}`;
      if (contacts.has(contactKey)) {
        contactId = contacts.get(contactKey).id;
      } else {
        contactId = randomUUID();
        contacts.set(contactKey, {
          id: contactId,
          company_id: companyId,
          name: contactName,
          email
        });
      }
    }

    // Add list
    if (listName) {
      lists.add(listName);
    }

    // Add deal
    const dealId = randomUUID();
    deals.push({
      id: dealId,
      deal_number: dealNumber,
      company_id: companyId,
      contact_id: contactId,
      gender,
      appointer_id: appointerName ? users.get(appointerName)?.id : null,
      appo_date: formatDate(appoDate),
      meeting_date: formatDate(meetingDate),
      meeting_time: formatTime(meetingTime),
      appo_type: appoType,
      appo_target: appoTarget,
      list_id: listName, // will be replaced with actual list ID later
      memo,
      reminder_status: reminderStatus,
      closer_id: closerName ? users.get(closerName)?.id : null,
      meeting_result: meetingResult,
      order_result: orderResult,
      yomi_status: yomiStatus,
      loss_reason: null,
      next_action: null,
      next_action_date: null
    });

    // Add followups (based on actual Excel header structure from Row 1)
    const followupConfigs = [
      { num: 1, dateCol: 21, assigneeCol: 22, statusCol: 23, noteCol: 24, lossCol: 25, nextActionCol: 26, nextDateCol: 27, emailContentCol: null, emailAttachmentCol: null },
      { num: 2, dateCol: 28, assigneeCol: 29, statusCol: 30, noteCol: 31, lossCol: 34, nextActionCol: 35, nextDateCol: 36, emailContentCol: 32, emailAttachmentCol: 33 },
      { num: 3, dateCol: 37, assigneeCol: 38, statusCol: 39, noteCol: 40, lossCol: 41, nextActionCol: 42, nextDateCol: 43, emailContentCol: null, emailAttachmentCol: null },
      { num: 4, dateCol: 44, assigneeCol: 45, statusCol: 46, noteCol: 47, lossCol: 48, nextActionCol: 49, nextDateCol: 50, emailContentCol: null, emailAttachmentCol: null },
      { num: 5, dateCol: 51, assigneeCol: 52, statusCol: 53, noteCol: 54, lossCol: 55, nextActionCol: 56, nextDateCol: 57, emailContentCol: null, emailAttachmentCol: null },
    ];

    followupConfigs.forEach(config => {
      const followupDate = row[config.dateCol];
      const assigneeName = clean(row[config.assigneeCol]);
      const status = clean(row[config.statusCol]);
      const note = clean(row[config.noteCol]);
      const lossReason = clean(row[config.lossCol]);
      const nextAction = clean(row[config.nextActionCol]);
      const nextActionDate = row[config.nextDateCol];
      const emailContent = config.emailContentCol ? clean(row[config.emailContentCol]) : null;
      const emailAttachment = config.emailAttachmentCol ? clean(row[config.emailAttachmentCol]) : null;

      // Only add if there's a date or status
      if (followupDate || status) {
        // Add assignee to users if not exists
        if (assigneeName && !users.has(assigneeName)) {
          users.set(assigneeName, {
            id: USER_IDS[assigneeName] || randomUUID(),
            name: assigneeName,
            email: `${assigneeName}@soloptilink.com`,
            role: 'closer'
          });
        }

        dealFollowups.push({
          id: randomUUID(),
          deal_id: dealId,
          followup_number: config.num,
          followup_date: formatDate(followupDate),
          assignee_id: assigneeName ? users.get(assigneeName)?.id : null,
          status,
          note,
          email_content: emailContent,
          email_attachment: emailAttachment,
          loss_reason: lossReason,
          next_action: nextAction,
          next_action_date: formatDate(nextActionDate)
        });
      }
    });
  }

  // ============================================================
  // Process AI Tool Orders Data
  // ============================================================

  for (let i = 3; i < aiToolData.length; i++) {
    const row = aiToolData[i];
    if (!row || row.length === 0) continue;

    const companyName = clean(row[1]); // 企業名 (row 2 header shows col 1)
    if (!companyName) continue;

    // Find or create company
    let companyId;
    if (companies.has(companyName)) {
      companyId = companies.get(companyName).id;
    } else {
      companyId = randomUUID();
      companies.set(companyName, {
        id: companyId,
        name: companyName,
        phone: null,
        mobile: null,
        address: null,
        url: null,
        notes: null
      });
    }

    const listSource = clean(row[2]); // リスト
    const verbalAgreementDate = formatDate(row[3]); // 口頭合意日
    const status = clean(row[4]); // ステータス
    const cancellationMonth = formatDate(row[5]); // 解約月
    const initialPaymentDate = formatDate(row[6]); // 初期費用入金日
    const monthlyPaymentStart = formatDate(row[7]); // 月額入金開始日
    const initialFeeLightup = parseInt(row[10]) || 0; // 初期費用（ライトアップ）
    const initialFeeAiTeleapo = parseInt(row[11]) || 0; // 初期費用（AIテレアポ）

    const monthlyFees = {
      ai_teleapo: parseInt(row[12]) || 0,
      form_sales_ai: parseInt(row[13]) || 0,
      l_sync: parseInt(row[14]) || 0,
      list_gen_ai: parseInt(row[15]) || 0,
      president_copy_ai: parseInt(row[16]) || 0,
      card_follow_ai: parseInt(row[17]) || 0,
      ai_management: parseInt(row[18]) || 0,
      meo: parseInt(row[19]) || 0,
      recruitment_ai: parseInt(row[20]) || 0,
      hachidori_ai: parseInt(row[21]) || 0,
      ai_stepup: parseInt(row[22]) || 0,
    };

    const marginAmounts = {
      ai_teleapo_margin: parseInt(row[23]) || 0,
      form_sales_ai_margin: parseInt(row[24]) || 0,
      l_sync_margin: parseInt(row[25]) || 0,
      list_gen_ai_margin: parseInt(row[26]) || 0,
      president_copy_ai_margin: parseInt(row[27]) || 0,
      card_follow_ai_margin: parseInt(row[28]) || 0,
      ai_management_margin: parseInt(row[29]) || 0,
      meo_margin: parseInt(row[30]) || 0,
      recruitment_ai_margin: parseInt(row[31]) || 0,
      hachidori_ai_margin: parseInt(row[32]) || 0,
      ai_stepup_margin: parseInt(row[33]) || 0,
    };

    aiToolOrders.push({
      id: randomUUID(),
      company_id: companyId,
      list_source: listSource,
      verbal_agreement_date: verbalAgreementDate,
      status: status,
      cancellation_month: cancellationMonth,
      initial_payment_date: initialPaymentDate,
      monthly_payment_start: monthlyPaymentStart,
      initial_fee_lightup: initialFeeLightup,
      initial_fee_ai_teleapo: initialFeeAiTeleapo,
      monthly_fees: monthlyFees,
      margin_amounts: marginAmounts
    });
  }

  // ============================================================
  // Add admin user (小貫)
  // ============================================================
  if (!users.has('小貫')) {
    users.set('小貫', {
      id: USER_IDS['小貫'],
      name: '小貫',
      email: 'onuki.h@soloptilink.com',
      role: 'admin'
    });
  } else {
    users.get('小貫').email = 'onuki.h@soloptilink.com';
    users.get('小貫').role = 'admin';
  }

  // ============================================================
  // Create list ID mapping
  // ============================================================
  const listIdMap = new Map();
  Array.from(lists).forEach(listName => {
    listIdMap.set(listName, randomUUID());
  });

  // Replace list names in deals with list IDs
  deals.forEach(deal => {
    if (deal.list_id && listIdMap.has(deal.list_id)) {
      deal.list_id = listIdMap.get(deal.list_id);
    } else {
      deal.list_id = null;
    }
  });

  // ============================================================
  // Generate SQL
  // ============================================================

  console.log('\nGenerating SQL...');
  console.log(`Users: ${users.size}`);
  console.log(`Companies: ${companies.size}`);
  console.log(`Contacts: ${contacts.size}`);
  console.log(`Lists: ${lists.size}`);
  console.log(`Deals: ${deals.length}`);
  console.log(`Deal Followups: ${dealFollowups.length}`);
  console.log(`AI Tool Orders: ${aiToolOrders.length}`);

  let sql = `-- ============================================================
-- SolOptiLink SFA - Seed Data from Excel
-- Generated: ${new Date().toISOString()}
-- ============================================================

-- ============================================================
-- FK制約を一時無効化
-- ============================================================
ALTER TABLE deals DROP CONSTRAINT IF EXISTS deals_appointer_id_fkey;
ALTER TABLE deals DROP CONSTRAINT IF EXISTS deals_closer_id_fkey;
ALTER TABLE deal_followups DROP CONSTRAINT IF EXISTS deal_followups_assignee_id_fkey;
ALTER TABLE activity_logs DROP CONSTRAINT IF EXISTS activity_logs_user_id_fkey;
ALTER TABLE users DROP CONSTRAINT IF EXISTS users_id_fkey;

-- ============================================================
-- 1. Users
-- ============================================================
`;

  users.forEach(user => {
    sql += `INSERT INTO users (id, email, name, role, is_active) VALUES (\n`;
    sql += `  ${escapeSQL(user.id)}, ${escapeSQL(user.email)}, ${escapeSQL(user.name)}, ${escapeSQL(user.role)}, true\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 2. Lists\n`;
  sql += `-- ============================================================\n`;

  listIdMap.forEach((id, name) => {
    sql += `INSERT INTO lists (id, name, type, is_active) VALUES (\n`;
    sql += `  ${escapeSQL(id)}, ${escapeSQL(name)}, NULL, true\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 3. Companies\n`;
  sql += `-- ============================================================\n`;

  companies.forEach(company => {
    sql += `INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (\n`;
    sql += `  ${escapeSQL(company.id)}, ${escapeSQL(company.name)}, ${escapeSQL(company.phone)}, ${escapeSQL(company.mobile)}, ${escapeSQL(company.address)}, ${escapeSQL(company.url)}, ${escapeSQL(company.notes)}\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 4. Contacts\n`;
  sql += `-- ============================================================\n`;

  contacts.forEach(contact => {
    sql += `INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (\n`;
    sql += `  ${escapeSQL(contact.id)}, ${escapeSQL(contact.company_id)}, ${escapeSQL(contact.name)}, NULL, NULL, ${escapeSQL(contact.email)}, NULL\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 5. Deals\n`;
  sql += `-- ============================================================\n`;

  deals.forEach(deal => {
    sql += `INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (\n`;
    sql += `  ${escapeSQL(deal.id)}, ${escapeSQL(deal.deal_number)}, ${escapeSQL(deal.company_id)}, ${escapeSQL(deal.contact_id)}, ${escapeSQL(deal.gender)}, ${escapeSQL(deal.appointer_id)}, ${escapeSQL(deal.appo_date)}, ${escapeSQL(deal.meeting_date)}, ${escapeSQL(deal.meeting_time)}, ${escapeSQL(deal.appo_type)}, ${escapeSQL(deal.appo_target)}, ${escapeSQL(deal.list_id)}, ${escapeSQL(deal.memo)}, ${escapeSQL(deal.reminder_status)}, ${escapeSQL(deal.closer_id)}, ${escapeSQL(deal.meeting_result)}, ${escapeSQL(deal.order_result)}, ${escapeSQL(deal.yomi_status)}, ${escapeSQL(deal.loss_reason)}, ${escapeSQL(deal.next_action)}, ${escapeSQL(deal.next_action_date)}\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 6. Deal Followups\n`;
  sql += `-- ============================================================\n`;

  dealFollowups.forEach(followup => {
    sql += `INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (\n`;
    sql += `  ${escapeSQL(followup.id)}, ${escapeSQL(followup.deal_id)}, ${escapeSQL(followup.followup_number)}, ${escapeSQL(followup.followup_date)}, ${escapeSQL(followup.assignee_id)}, ${escapeSQL(followup.status)}, ${escapeSQL(followup.note)}, ${escapeSQL(followup.email_content)}, ${escapeSQL(followup.email_attachment)}, ${escapeSQL(followup.loss_reason)}, ${escapeSQL(followup.next_action)}, ${escapeSQL(followup.next_action_date)}\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- 7. AI Tool Orders\n`;
  sql += `-- ============================================================\n`;

  aiToolOrders.forEach(order => {
    const monthlyFeesJson = JSON.stringify(order.monthly_fees).replace(/'/g, "''");
    const marginAmountsJson = JSON.stringify(order.margin_amounts).replace(/'/g, "''");

    sql += `INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (\n`;
    sql += `  ${escapeSQL(order.id)}, ${escapeSQL(order.company_id)}, ${escapeSQL(order.list_source)}, ${escapeSQL(order.verbal_agreement_date)}, ${escapeSQL(order.status)}, ${escapeSQL(order.cancellation_month)}, ${escapeSQL(order.initial_payment_date)}, ${escapeSQL(order.monthly_payment_start)}, ${escapeSQL(order.initial_fee_lightup)}, ${escapeSQL(order.initial_fee_ai_teleapo)}, '${monthlyFeesJson}', '${marginAmountsJson}'\n`;
    sql += `);\n`;
  });

  sql += `\n-- ============================================================\n`;
  sql += `-- FK制約を再有効化（コメントアウト）\n`;
  sql += `-- 以下はauth.usersにユーザー作成後に手動で実行してください\n`;
  sql += `-- ============================================================\n`;
  sql += `-- ALTER TABLE users ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);\n`;
  sql += `-- ALTER TABLE deals ADD CONSTRAINT deals_appointer_id_fkey FOREIGN KEY (appointer_id) REFERENCES users(id);\n`;
  sql += `-- ALTER TABLE deals ADD CONSTRAINT deals_closer_id_fkey FOREIGN KEY (closer_id) REFERENCES users(id);\n`;
  sql += `-- ALTER TABLE deal_followups ADD CONSTRAINT deal_followups_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES users(id);\n`;
  sql += `-- ALTER TABLE activity_logs ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);\n`;

  // Write SQL file
  fs.writeFileSync(OUTPUT_SQL_PATH, sql, 'utf8');
  console.log(`\nSQL file generated successfully: ${OUTPUT_SQL_PATH}`);
  console.log('\nNext steps:');
  console.log('1. Review the generated SQL file');
  console.log('2. Apply migration: supabase db push');
  console.log('3. Create users in Supabase Auth with matching IDs');
  console.log('4. Re-enable FK constraints by running the commented SQL');
}

// ============================================================
// Execute
// ============================================================

try {
  main();
} catch (error) {
  console.error('Error:', error);
  process.exit(1);
}
