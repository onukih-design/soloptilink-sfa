#!/usr/bin/env node

const XLSX = require('xlsx');

const EXCEL_PATH = '/Users/onukifutoshishuu/Downloads/AI商社 案件管理表.xlsx';

const workbook = XLSX.readFile(EXCEL_PATH);

console.log('Available sheets:', workbook.SheetNames);
console.log('\n=== 当月案件管理表 ===');

const dealSheet = workbook.Sheets['当月案件管理表'];
const dealData = XLSX.utils.sheet_to_json(dealSheet, { header: 1, defval: null });

console.log('\nFirst 3 rows (headers and sample data):');
dealData.slice(0, 3).forEach((row, idx) => {
  console.log(`\nRow ${idx}:`);
  row.forEach((cell, colIdx) => {
    if (cell !== null && cell !== undefined && cell !== '') {
      console.log(`  [${colIdx}]: ${typeof cell === 'string' ? cell.substring(0, 50) : cell}`);
    }
  });
});

console.log('\n\n=== AIツール　受注管理表 ===');
const aiToolSheet = workbook.Sheets['AIツール　受注管理表'];
const aiToolData = XLSX.utils.sheet_to_json(aiToolSheet, { header: 1, defval: null });

console.log('\nFirst 3 rows:');
aiToolData.slice(0, 3).forEach((row, idx) => {
  console.log(`\nRow ${idx}:`);
  row.forEach((cell, colIdx) => {
    if (cell !== null && cell !== undefined && cell !== '') {
      console.log(`  [${colIdx}]: ${typeof cell === 'string' ? cell.substring(0, 50) : cell}`);
    }
  });
});
