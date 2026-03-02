#!/usr/bin/env node

const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Error: NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be set in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false
  }
});

// Fixed UUIDs matching the seed data
const users = [
  {
    id: '00000000-0000-0000-0000-000000000001',
    email: 'onuki.h@soloptilink.com',
    password: 'SolOptiLink2025!',
    name: '小貫',
    role: 'admin'
  },
  {
    id: '00000000-0000-0000-0000-000000000002',
    email: 'higami@soloptilink.com',
    password: 'ChangeMe123!',
    name: '樋上',
    role: 'appointer'
  },
  {
    id: '00000000-0000-0000-0000-000000000003',
    email: 'takahashi@soloptilink.com',
    password: 'ChangeMe123!',
    name: '高橋',
    role: 'appointer'
  },
  {
    id: '00000000-0000-0000-0000-000000000004',
    email: 'nomura@soloptilink.com',
    password: 'ChangeMe123!',
    name: '野村',
    role: 'appointer'
  },
  {
    id: 'b313633e-4001-4c13-9a93-de2b0b1971a0',
    email: 'masahashi@soloptilink.com',
    password: 'ChangeMe123!',
    name: '正橋',
    role: 'appointer'
  },
  {
    id: '63a55be1-0fca-459f-8335-8c800019c678',
    email: 'inayoshi@soloptilink.com',
    password: 'ChangeMe123!',
    name: '稲吉',
    role: 'appointer'
  },
];

async function createUsers() {
  console.log('Creating users in Supabase Auth...\n');

  for (const user of users) {
    console.log(`Creating user: ${user.name} (${user.email})...`);

    try {
      // Note: Supabase Auth may not support custom UUIDs directly
      // This will create users and we'll need to map the generated IDs to our users table
      const { data, error } = await supabase.auth.admin.createUser({
        email: user.email,
        password: user.password,
        email_confirm: true,
        user_metadata: {
          name: user.name,
          role: user.role
        }
      });

      if (error) {
        console.error(`  ✗ Failed: ${error.message}`);
      } else {
        console.log(`  ✓ Created with ID: ${data.user.id}`);

        if (data.user.id !== user.id) {
          console.warn(`  ⚠ Warning: Generated ID ${data.user.id} doesn't match expected ${user.id}`);
          console.warn(`  → You need to update the users table and related foreign keys manually.`);
        }

        // Update users table with the actual auth user id
        const { error: updateError } = await supabase
          .from('users')
          .update({ id: data.user.id })
          .eq('email', user.email);

        if (updateError) {
          console.error(`  ✗ Failed to update users table: ${updateError.message}`);
        } else {
          console.log(`  ✓ Updated users table`);
        }
      }
    } catch (err) {
      console.error(`  ✗ Exception: ${err.message}`);
    }

    console.log('');
  }

  console.log('\nUser creation completed.');
  console.log('\nNext steps:');
  console.log('1. Verify users in Supabase Dashboard → Authentication → Users');
  console.log('2. If IDs don\'t match, you\'ll need to update foreign keys in deals and deal_followups tables');
  console.log('3. Re-enable FK constraints by running the SQL in 002_seed_data.sql (bottom section)');
}

createUsers().catch((err) => {
  console.error('Fatal error:', err);
  process.exit(1);
});
