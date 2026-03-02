-- ============================================================
-- SolOptiLink SFA - Seed Data from Excel
-- Generated: 2026-03-01T01:42:11.019Z
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
INSERT INTO users (id, email, name, role, is_active) VALUES (
  '00000000-0000-0000-0000-000000000003', '高橋@soloptilink.com', '高橋', 'appointer', true
);
INSERT INTO users (id, email, name, role, is_active) VALUES (
  '00000000-0000-0000-0000-000000000001', 'onuki.h@soloptilink.com', '小貫', 'admin', true
);
INSERT INTO users (id, email, name, role, is_active) VALUES (
  '00000000-0000-0000-0000-000000000004', '野村@soloptilink.com', '野村', 'appointer', true
);
INSERT INTO users (id, email, name, role, is_active) VALUES (
  '00000000-0000-0000-0000-000000000002', '樋上@soloptilink.com', '樋上', 'appointer', true
);
INSERT INTO users (id, email, name, role, is_active) VALUES (
  'b313633e-4001-4c13-9a93-de2b0b1971a0', '正橋@soloptilink.com', '正橋', 'appointer', true
);
INSERT INTO users (id, email, name, role, is_active) VALUES (
  '63a55be1-0fca-459f-8335-8c800019c678', '稲吉@soloptilink.com', '稲吉', 'appointer', true
);

-- ============================================================
-- 2. Lists
-- ============================================================
INSERT INTO lists (id, name, type, is_active) VALUES (
  '4a641191-8349-45d6-a7be-51577e35fe21', '営業リストNO.3', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '655a65c7-55d1-4a95-88cd-54a82a1fd951', '営業リストNO.2', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'b8f0b757-efca-4f3b-810f-c28153aa29d2', '情報通信リストNo.2', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'a3cf2bf9-35bf-43bd-8f8f-c14f554a1897', '情報通信リストNo.1', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '162b01d1-74f1-4020-a827-26ddc7d19ac7', '平田さん紹介', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'af0ef607-1e5f-4556-b618-0307eb98dc5f', '小貫リファラル', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズ', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '6ff5a92a-a498-4000-842d-b7a9e338fac8', 'クラウドワークス', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '3226c64a-c990-443b-8f8f-bba01b7f7ee7', '展示会', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'b3a27267-826b-4438-a8f9-9841ddacc3a2', 'Baseconnect 架電リスト', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '2fb53ab5-b677-4fab-969c-78048e30311a', '営業募集リストNO.1', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '17a41e52-2f2d-4646-ae4f-e57eac062028', '(オルガロ)野村さん紹介', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'e5569260-1dd8-44ee-9acf-4427754f638a', 'bizmaps 架電リスト', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'e8cc8cf4-9c74-49ae-bc5f-675b3eb5bc05', '(アクア)松本さん紹介', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'マイナビリスト', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'a8d27d08-989e-45c3-b90d-aa24a86ffe35', '松井さん紹介(ワンプロドュース)', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'aa846bed-657e-4f2c-9d5d-d837b9769a6d', 'LCM岡村さん', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  '2c6efee9-b5cc-46ad-9dc9-cf9685d95763', '冨岡さん紹介(オルガロ野村さん紹介)', NULL, true
);
INSERT INTO lists (id, name, type, is_active) VALUES (
  'b0cdab03-cde8-4066-8eb0-94f813d76f22', '秋元さん紹介(ビジネスタンク)', NULL, true
);

-- ============================================================
-- 3. Companies
-- ============================================================
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e28153bf-6eaa-4a90-898d-374203ab036b', '株式会社ゼロジャパン', '0429972000', '-', '埼玉県所沢市くすのき台３丁目１８番地５リングスビル５階', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b1a96d7c-3307-4413-b07f-aaf94c866f88', 'インピネス株式会社', '050-3695-0503', '090-7378-3081', '東京都渋谷区恵比寿西２丁目１３番１０号代官山アーバンライフ２０１号室', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '09fb2883-4892-441a-a67d-92c1fedac2e0', '株式会社キャム', '092-716-2131', NULL, '福岡県福岡市中央区大名2丁目6-28 九勧大名ビル5階', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd3c7a05c-68d3-4636-8f7d-9f111a1f83f0', 'エバーシステム株式会社', '052-684-7714', NULL, '愛知県名古屋市中区栄三丁目11番1号', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '273ce17c-8712-4f77-9ccf-caed2f5572aa', '株式会社mottodigita', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd5a742c1-308b-49c3-9ded-634ccedae37f', 'ハイブリッド経営サポート株式会社', '03-4572-0128', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fded8de6-138a-4ba3-bb6d-8849c84ced8e', '株式会社ミタン', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9c1a6d99-9e53-4f7d-90ae-3f43ee67409b', '株式会社アプクロ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dfced412-0dde-487b-84f0-fca9f29d4c58', '株式会社AO', NULL, NULL, '東京都渋谷区神南1-11-4 FPGリンクス神南 5F', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f92df853-9e9d-4988-b86a-6a06d505cc1a', 'JTC合同会社', NULL, NULL, '千葉県鎌ケ谷市初富８０２−９３ ホワイトパレスA棟', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '5cbd8d09-f7cb-4b3f-85c2-538f8b769b07', '株式会社エスアイエス·パートナーズ', NULL, NULL, '愛知県名古屋市名東区高社一丁目89番地 第二東昭ビル4階D', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '23a8a5f5-39ed-41b2-a48c-cb1f5c32d797', '株式会社ヘルスインテクト', '03-6717-2895', '070-3839-1981', '東京都港区港南2-15-1品川インターシティA棟28階', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '80a66e55-84ce-4ee2-8c1a-97b88028bf2a', '合同会社 RISOOO DESIGN', NULL, '080-3036-9433', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '20839b67-edef-4a3b-a466-01b0a0c3cc5f', '株式会社インクリット　太陽光リスト', NULL, '080-9722-9962', '兵庫県神戸市灘区水道筋５丁目２番１５号　アーバン王子公園２０３', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6770019b-ff0f-47cf-bdb3-7ee887aa200e', 'LIVE Doctor株式会社', NULL, NULL, '東京都中央区日本橋３丁目９－１', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3fc5a947-49fe-4362-9698-3c3898d068c1', '株式会社ケシオン', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f7952695-e177-4ec0-af58-5a275e77947f', '株式会社Shiiiro', '08034749691', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '69d3070a-4a46-46e3-8697-ba03543e2374', '(株)ジェイビルド', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '548afe59-8b2c-4a77-b1d1-41b9bfd01aa1', 'オイカゼ株式会社', NULL, '080-1729-7445', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '89913fcd-96d6-4149-845c-71e68f13f3fa', '株式会社LEG', NULL, '080-3464-8377', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6a2422a9-eafc-4743-a4d8-1b0d3e58309a', '株式会社SUBTEXT', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '814da5f4-0ca6-43b2-8e6b-787ae1067afe', '株式会社ミタシ', NULL, '0801252357', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fdf00d6d-492e-4f30-9d96-91b1cda5d85a', '合同会社MUSUBI FOUNDATION', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'cfdbe777-bfe7-4f76-b573-1c023f9b6b1c', 'Ｋ＆Ｓソリューションズ株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0eaf1b81-9e9c-4d6d-a6f2-b04f2181d895', '合同会社　八月', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c415da63-75f3-49e6-8089-8d4d8a01cda0', '京都商事', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '386985f2-6a44-4544-9c32-393e2e75a5ef', 'キカクラボ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '15e0d149-189e-44f5-9f49-ca2faf3a48c2', '株式会社moment', '054-908-9591', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a8307135-d901-4a3d-ae6f-ece5a49635f0', 'Lildaisy合同会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e443bd34-c1f6-47ff-a5ca-926f88f443b3', 'HaneruTo株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '74695e1f-7661-4ff1-a884-d7606fcb0e9b', '株式会社アウトバウンドマーケティング', '03-6820-9561', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ae726233-a0e9-4828-9086-fc6d2657da44', 'REVOLVER合同会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'bc69ac02-70e7-4e97-af44-235ba9b62694', '株式会社スリーグッド', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fa3e75cd-5cac-4b18-97aa-ff12fd2b617a', '株式会社シルバーウイン', '047-323-6171', '080-4479-0761', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dadcb276-cdd1-44a2-a176-580b8b702c01', '株式会社 Crisp Code [クリスプコード)', '050 6872 7635', '090 9989 8118', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8ceed504-9116-4476-8b43-91f9c48b4414', 'リードプロバイド', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6e9ccf4c-e200-4390-b43a-d882f91903ed', '株式会社リンクスロー', '050-1808-3303', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8922b7bb-dcd9-4717-83f0-99df7167c0c6', 'アズ株式会社', '03-5227-6211', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '588ef129-6056-44ca-a898-6cb2ccf7fc2b', '株式会社ＢＡＳＥＣＲＥＡＴＩＯＮ　ＪＡＰＡＮ', '03-6555-4599', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1a8466ae-81eb-49d2-a336-fd6817935038', '有限会社リンクアップスタッフ', '050-3635-5887', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0bb7d22a-a363-4be1-b95b-72e6c3ea6695', '合同会社　VAZ TWO LLC.', '090-8535-8345', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b4812e76-9eb3-4950-a1c9-0c794e1d8c71', 'デジタルゲイト株式会社', '03-6738-6666', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'be369f39-588d-46ad-9ddc-c0145492b687', '株式会社Farout', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'cfd7d762-80d8-4978-bad0-4cc5d8a3d319', 'スタッフマーケティング株式会社', '03-4330-3682', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '04bb4f4a-c51b-47e7-bc4a-b84293e8014c', '株式会社ValorizeAI', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ab0d95b2-ca5c-4e95-99be-3afb57d09ac8', '株式会社オークサービスソリューション', '03-3532-8501', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'cc549c61-4e03-46bd-b2ff-dd68364acb16', 'ビートレード・パートナーズ株式会社', '03-6627-2118', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd4bdc4b4-6ae8-46f6-8429-02a16cbfad96', '株式会社アイランド・ブレイン', '052-950-2320', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '32d0e247-1dad-4be7-a0b6-4f7dbef9d4df', '株式会社GLOXY', '03-6261-0824', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'df80682f-bf56-4398-a734-d98dacb7aaa5', '株式会社セールスクルー', '03-5458-7202', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7edbccb8-b5a4-4729-a9fd-a7914bf4e752', '株式会社プロセルトラクション', NULL, '080-3242-2232', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f8af44af-2d12-4528-9a25-434a3cceca3f', 'SHION合同会社', NULL, '090-6623-3373', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3dad9c6a-2f34-411b-85bc-9a4f48280ec2', 'キャリア・サポート株式会社', '096-233-3010', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1b91dfff-d8bf-49c4-9a3f-73785d97f1e9', 'ヒューマンシーン株式会社', '03-6811-2585', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0074e7f5-996e-4f88-8b20-855f2175dc2d', 'クラウドグレイス株式会社', '03-6380-0492', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9d78f5fa-6df9-4960-a422-287bf766e515', '株式会社アクロフロンティア', '03-4530-0001', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '54db912b-3096-455c-8d78-901d7cca8efa', '株式会社ジャストファイン', NULL, '080-7035-2686', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e587d2e7-0e6b-4d47-9b2b-a00211d2f297', 'コーキ株式会社', '03-6407-1212', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0e94f29d-de26-411d-af49-9881c76abfcf', '株式会社フィールドマーケティングシステムズ', '03-5643-9071', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9614ebb6-470e-4f4d-9958-8d9d8f5b7fe7', '株式会社PLUSLINK', '019-601-2964', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '52e21fe6-6004-4200-a750-408b0dae8359', '株式会社オルガロ', '03-6657-8575', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f77b1320-dec7-4345-8568-237e16a5c420', '株式会社ぱるる', '073-435-5866"', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'abcdc170-42bc-44ba-b5bf-5b953136261f', 'アーチ株式会社', '03-6847-5616', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '4bb991f0-0f29-45d6-80ba-390626497980', '株式会社ダイレクト・リンク', '03-6276-5332', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '329a0d00-ac37-4a9f-a348-e29dc74a7487', '株式会社インターコード（セブンコード）', '0120-927-305', '080-3278-7786', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f8ee3afb-ea69-4836-9665-15ae52972908', '株式会社ナビパートナーズ', '03-4579-0007', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '479e1b92-4c22-4fc4-b252-1116d7927314', '株式会社New Deck', NULL, '080-8398-3383', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7661bb47-c6eb-4689-9b6b-d448ac9a414f', '株式会社luxe', NULL, '090-4254-4348', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '73684d1b-a872-4710-b038-91b625fd87d5', '株式会社セカツク', '03-6869-8129', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3b521799-45e4-4b2f-87d3-81757d3f808f', '株式会社soraプロジェクト', '0120-252-764', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'bb93a1db-33c3-46dd-bf69-7fb1ff320ca2', '株式会社アイドマ・ホールディングス', '03-6455-7935', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2ab190c3-c72d-475a-ac7b-ab16bcdd6dd2', '株式会社プルーセル', '03-6281-9596', '080-1309-6972', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6889860f-4956-45de-8983-6e75493ed533', '関西ビジネスインフォメーション株式会社', '0120-548-033', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '92fe94d7-eacc-426b-8ed4-11c898aea788', '株式会社セグロス', '03-6823-3091', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '20e5a86d-f768-4395-ae62-8055a78c1b78', '株式会社Next Arc', '06-7668-6872', '080-4915-2462', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2df9a3dc-1fb1-4ede-99e0-40dea98ac764', 'モメンタムスタジオ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'eed3c4e4-715a-4172-9a24-e4207b3dfa3a', '株式会社ベルテック', '03-3235-9111', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b78a74e6-da90-4276-9c30-d7c839bd19ff', 'カイタク株式会社', '0050-3187-6440', '050-1782-5548', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '72432d0e-2231-4f65-8902-7fe11e146329', '株式会社RE RISE', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ab96240f-7409-423d-b6c2-bbc3426052e3', '株式会社ビオトープ', NULL, '090-5272-9205', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '25f6472e-eb78-4cb4-ba67-8d31069708a8', '株式会社マニフェスト', '03-6427-7637', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7767af12-63ce-4e06-a2f3-9ed14dfe4544', '株式会社ネオキャリア', NULL, '080-3560-2106', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '642e17c6-f484-4323-840e-f5bda332870d', 'ソーシャルソリューション株式会社', NULL, '090-9320-6840', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2bead48e-fe88-4b6b-8b25-ccf107a5064b', '株式会社ExtraBold', NULL, '080-5971-6520', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '108df061-8f6f-4b8b-bcc9-bfaf9ae85bb7', '株式会社営業ハック', '03-6689-2277', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '293b3173-a1b5-4cec-880a-d9fcf352ed80', '株式会社レイゼクス', '03-5545-5026', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fd0a1f9e-7068-426b-a33c-0450d68a4281', '株式会社エッジコネクション', '03-6825-5900', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '60ad7b6b-f4c0-4602-b8b5-64223f105608', '大阪営業代行株式会社', NULL, '080-7033-9856', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'eb814b26-1221-4b8d-a366-cad035615250', '株式会社クイヒラリ', NULL, '090-6961-8605', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dfe8773b-fa98-40dd-b71f-c198c29306ad', 'カクシングループ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0b019907-9c25-48f8-8dd4-a1c7879ba123', 'アイ・エヌ・ジー・ドットコム', '06-4706-3440', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2f04e3ea-201a-4638-91c6-2b7b70338576', '株式会社コンフィデンス', '03-5114-3071', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '088d9ab5-0584-4453-b7e1-349b13157556', 'ビーモーション株式会社', '03-5979-7100', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c8b55e1d-23a9-4e6e-9b40-28f8fd867fd5', '株式会社Univearth', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '778e7c70-b350-4330-921e-3d05519d6c00', 'ninjapan株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c69e2541-3d69-4bbc-8f71-b32030efdbb8', '株式会社Intense', NULL, '080-7224-3919', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a309100e-f6a6-4863-8038-a2e3f27860ae', 'インプレックスアンドカンパニー', '092-753-8830', '050-5497-7707 本社　03-6550-8012こっちに電話', NULL, 'https://www.imprexc.jp/business/salesrep/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '189ffda4-5029-45fc-b2f4-057e673ab4bd', '株式会社エルデロ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '45ad2dc7-cf01-40ef-b56c-7013cfd5e33f', 'ペンタスケアマネジメント株式会社', '09065321584', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fb23ab20-c724-4c59-9f79-94cc37a343c8', '株式会社VOLIC', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c420c14a-e199-4717-b626-652add7536b7', '株式会社 契', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '171ccf99-77f6-4cd8-a049-66279e3e2b75', '株式会社インテグリティ・プラス', '03-4455-3728', NULL, NULL, 'https://www.integrityplus.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9fb4ba49-49f4-4b26-bf32-282a797f33f2', '十方株式会社', '03-4221-4107', NULL, NULL, 'https://jippou.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '29debf76-11dc-4b43-9eae-de5d55d43d00', '株式会社Seneca', NULL, '080-4355-2410', NULL, 'コーポレートサイト： https://seneca.co.jp/ katakas：https://katakas.net/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3b3cb6c4-081f-47d1-862e-7377db7511e1', 'CyberConnect', NULL, NULL, NULL, 'http://cyber-connect.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '86a0b83b-920c-4b2e-a713-a1555f3d64cc', '株式会社Lians', NULL, '090-9342-5050', NULL, 'https://lians-sales.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '49fe0148-7c9e-4b31-8486-7457bdbd38f9', '株式会社AIKIシステム', NULL, '06-6648-8925', NULL, 'https://aikisystem.co.jp/link.php', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '48293833-c5a9-419a-85da-4b8aae66563f', '株式会社ブロードバンドコネクション', NULL, '080-6086-0313', NULL, 'https://bb-connection.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f8d8187f-8bea-49a5-bca2-40f769cd5b7d', 'AQUA∞', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd5e2f9e7-2e1a-487b-86e9-9decef79feb4', 'LCM株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '48e4311d-f89c-43fd-a539-d5843e5f0599', '株式会社グロウサポート', NULL, '080-4177-5158', NULL, 'https://www.grow-support.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3f0f9b18-6d87-4be8-84e3-505c48e9408f', '株式会社LEO', NULL, '080-9656-0722', NULL, 'https://star-labo.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7a517b28-5c84-4882-aa1a-2f686458a484', '株式会社アースリンク', '042-355-8025', '下記は高田さんのため、電話しても意味ない 080-6451-8048', NULL, 'https://www.earthlink.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '44c00561-a31b-499b-885b-caa89a31e001', '株式会社YTK', NULL, '06-7662-8687', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3c56a85a-4841-4810-af53-41d3e4a70088', '株式会社ネオクリエイト', '092-482-0702', NULL, NULL, 'http://neo-create.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9af5f51f-954e-4242-b330-72c12e788c84', '株式会社herstyle', '050-3528-8351', '050-3528-8351', NULL, 'https://herstyle.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '29ca7b2d-e354-4176-aed2-c643ba9d8338', 'SBモバイルサービス株式会社', NULL, '070-3130-3068', NULL, 'https://www.sbmobileservice.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6673e382-9192-4ba5-95f3-fff0077796b5', 'Stock Sun株式会', '050-1783-5918', NULL, NULL, 'https://stock-sun.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e04f60a1-ab76-40d1-ad89-b08a1e00c1be', '株式会社テレネット', '03-5210-7222', NULL, NULL, 'https://www.tele-net.co.jp/company/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '128ca6c2-97f5-4509-aa3b-83153664e7af', 'マナリード株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c706d29c-4fb3-4e1d-88c1-9338661f2d54', 'バリュエンスジャパン株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b4dee83f-9512-47d7-b955-82957fdd71b7', '株式会社ピースフラットシステム', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1514158c-61e8-4ca7-b72a-90f1a7e0c225', 'スポーツX株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b1afce4e-5840-4d49-88fd-b9389fe0f95d', 'ＭＩＱＴＯＲＡ株式会社', NULL, '090-2838-5455', NULL, 'https://miqtora.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c1af7970-c582-4238-98ab-dbd2ca2b6840', '株式会社フィールソン', NULL, '090-5357-9241', NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '566eefe1-bc17-4390-a897-420911a6355f', '株式会社Ｒｅａｌｒｉｓｅ', '03-6843-4310', '090-9241-1590', NULL, 'https://realrise-sales.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '53f1f6e8-7e9b-488f-ab55-2e03e75c908d', '株式会社Sales and Innovation Japan', '03-5422-6479', NULL, NULL, 's.tsukuda@salesandinnovation.co.jp', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6a7ee605-cf6f-4585-9acb-c1b1d308cedc', '株式会社D-Assist', NULL, '090-2003-8080', NULL, 'https://d-assist2025.com/#company', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '63395cb3-970a-4668-8263-872250a435c5', '合同会社日本ネット通信サービス', '03-6897-6170', NULL, NULL, 'https://jnc-service.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'da5dee56-61b4-42e3-886b-d9325987d9ff', 'Fulfill', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f3a033cb-f107-48e8-88d1-1ed334c6d247', 'ビジネスタンク', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd40c5164-1e62-4398-b518-7adc32d85157', 'カクトク株式会社', NULL, NULL, NULL, 'https://kakutoku.co.jp/corporate', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e54e5971-a6e5-4e97-bedc-c72215567397', '株式会社Ｒｅｓｅｎｓ', '053-589-5011', NULL, NULL, 'https://resens.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '30bdd6d0-a7b3-4cf9-a120-e5373030e7bf', '株式会社C&C', NULL, '080-9168-4800', NULL, 'https://www.cac-japan.co.jp/#our-business', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ba33d29a-ac87-48cb-8c4a-cba80ebe9a6b', '株式会社ロイヤルアライアンス', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ed7c261e-1702-4340-8874-491968c4bbea', 'セールスバディ', NULL, NULL, NULL, 'https://salesbuddy-inc.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '713b75bc-9794-44c8-9694-023345629854', '株式会社小田原社中', '0465-43-9467', NULL, NULL, 'https://odawara-shachu.jp/about', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ef3c4fb3-d63b-49f9-a36f-3b2cc3461bfc', '株式会社シーエス・エコ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '90b1c44d-3759-45a2-8753-bc27ef6206ad', '合同会社Altrunist', '050-5497-1147', NULL, NULL, 'https://altrunist.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '875e84ae-5263-488b-b3a8-e34d98558cb3', '株式会社TGVコミットメント', '070-1432-3361', NULL, NULL, 'https://www.tgvcommit.com/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c839d09a-d14f-4d99-b81e-0994c348e5f6', '株式会社エリシオ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c261fd0f-effe-4483-99d9-e2284934bd5b', '株式会社ＳｏｌＧｒｉｔ', '03-6684-2365', '090-8242-4137', NULL, 'https://solgrit.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '71b4d34e-8ae3-4dd6-b216-6f17a6f37911', '株式会社Her''s', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7ca76830-7fce-4422-9a14-da8c151e7ee7', '江﨑　博美', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '04fea7be-b951-4f48-a263-8d03937820df', '株式会社エモチカ', '045-274-0172', '080-1961-0503', NULL, 'https://emochika.jp/company/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1c166e6b-bb74-46d1-b90b-76930ef699ea', '株式会社Partner SENSE', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'b9a2a816-7849-4951-a873-2e28a5de73e2', '株式会社sopital', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e78a2fa9-0453-4699-86a2-f7b66fabd416', '株式会社レイズ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9a668991-3ae5-4a28-a78f-ab7ff34cb12f', 'STARSPARK', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'ca0fbc43-1634-401a-a43d-acf3a5f9c4a9', '東海ビジネスサービス', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dce81887-8f73-4523-8df0-bb9a2a6ce492', 'Achievers', '03-6824-6594', NULL, '東京都新宿区新宿1-36-2 新宿第七葉山ビル3F', 'https://achievers.team', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'cf91516e-6f17-407a-b57e-53ce21df3790', '情報システムコンサルティング株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '647c40b2-833d-43a9-b8c8-e92c82a6065e', 'エネセーブ株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd2411421-153f-4f6c-85b2-4946ab7a6ea9', '株式会社AIパートナーズ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'aa43c2e3-a647-440a-8e19-31fac25bc4ff', '株式会社Social,Quest', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd370fcf4-ad95-4143-b3d9-09215f88853c', '株式会社シュッチョーWifi', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '75581949-d765-4635-bb60-0f6adfa4e89d', '株式会社NovaPromotion', NULL, '090-4220-3932', NULL, 'https://novagroup2019.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '05a6a5a3-ebd9-4574-99fb-29bdd7f09dc5', '株式会社ワールドクラフト', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9d435765-f751-442d-8470-6e711fee6c42', '光明興業株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6a04eb32-9802-4c41-b74c-fa38c877edc7', '株式会社ステイドリーム', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a57d82c0-7203-47d4-bce2-052e4b1889ed', '株式会社コントロールテクノロジー', '05054348199', NULL, NULL, 'https://tech.controlgroup.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '57f29818-def9-46fd-8081-2860de4b6827', '税理士法人　川邑・中 合同会計事務所', '0734251251', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp242952/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2afdf017-d683-42d0-ad2b-ab3c93c95b37', '東海ニチユ株式会社', '0523524161', NULL, '愛知県', 'https://www.tokai-nichiyu.co.jp/page1', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f6ffc200-e0c7-414b-b94f-12350504bf82', '株式会社アルミック', '0582743240', NULL, '岐阜県', NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a0375b23-c9f6-4641-bb5b-5bef4b6d4855', 'HR Tech Management株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a1a0d541-0874-4b46-9449-1aa1b15998d5', '株式会社Peter Pan', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '456d3daa-b090-43fd-a07b-1cbe633893d2', 'SportsEntertainmet', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6d3461d4-95a5-4444-957a-581ee7b4c7f2', 'ワールドアイ株式会社', '03-6777-0027', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fb60b87e-0e55-47d7-a448-861ce29f2140', '錦エステート株式会社', '0223926311', NULL, '宮城県', 'https://hillside-mall.com/shopguide/estate.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '10404e0b-af70-4eac-bce8-37b2189ea9c2', '(株)トモエシステム', '0785761001', NULL, '兵庫県', 'murakami.hirokazu@tomoe-group.co.jp', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9a95002d-364e-464c-bb19-3d0def07f856', '合同会社スキルマネジメント', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '68e2ad80-528e-41f4-872b-b209889e67eb', '株式会社諸岡', '0297662111', NULL, '茨城県', 'https://job.mynavi.jp/27/pc/search/corp206157/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7de3f30c-6dc2-4612-aaaf-d2bdd79c111a', '株式会社Timers', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '65e3c52a-9fdc-42ab-9e7f-0bbc428fe79a', 'エシカルライフ株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f86e3799-516a-46cc-9455-17cdfa34ee7a', '株式会社remental', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'bf91a08e-bfce-401b-84a1-c195eec61bca', '株式会社ainak', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f3cc5b19-6876-4e91-b9de-f64799d08bbb', 'ツナムグデザイン', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '5ea0fb2a-cabb-4166-b891-9eceb14b86ba', '株式会社AEMI', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8aaf860d-9e8c-415d-9002-de582fba74c3', '株式会社アークリンク', '03-3494-8565', NULL, NULL, 'https://arklink.net/pageOne.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c55bd7e7-47c8-424b-b8cc-eeada3e6b4bd', '株式会社笠原建設', '025-566-3181', NULL, '新潟', 'https://job.mynavi.jp/27/pc/search/corp243244/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '465a3d78-f860-4f27-a7fd-736f3f31b458', 'データアナリティクスラボ株式会社', '03-6264-9941', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp259277/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'bf49d17e-5791-4eb2-9b59-52993dcabccc', '日東物産(株)', '0862925555', NULL, '岡山県', 'https://nitto-okayama.co.jp/', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f2c77f70-f8c1-4cfa-9e06-77830aa0b8ba', '(株)アルファテック', '0362688401', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp266763/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6c464925-9cc0-4467-b8e7-d0a5385af2ec', '株式会社東伸社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '02f13c2d-6fec-4374-a983-436e3d4d2b01', '(株)アスドリーム', '0299943335', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp277342/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'a3af25b7-8ed3-4568-850f-9bf241085970', '株式会社フォーバル', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dff62bfb-ad84-4178-bcf6-17f653c87fc2', '株式会社TRIBE', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '11a5774d-5aba-45c9-b781-dbdeda19f66a', '株式会社リバイブル', '0362069318', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp283414/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '70fb1848-dc77-47eb-94e1-0227db7017c8', '株式会社ホテル青森', '0177754141', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp282771/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'f929394a-b5dd-4be5-9e1d-e742a27f39a2', '(株)クレンシアコスメ', '0927175411', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp273542/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9a2dde32-a390-4c9f-96dd-b2fb9e230616', 'ハウス・トゥ・ハウス・ネットサービス(株)', '0359397288', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp87119/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c606acd1-2909-46ab-964a-552fcbdc9d9b', '合同会社ワンダー', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1104fe2e-6122-46c4-af12-15cf1e8ca8e9', '株式会社style', '090-5761-0011', NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'bd8d17c3-76b9-44f9-b34d-96297e68de0a', '㈱gifts', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '13a8afcb-e653-47a4-a547-1249c4e54228', 'R&C株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c029e507-ce1c-4ab0-9702-506893af5c0d', '株式会社CCH', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '128ee08d-8323-4ec2-b2bc-3d0a15d929f1', '株式会社P16', '0352890116', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp24012/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7d93e886-cf15-4225-8da4-aa7a08e73026', '合同会社　共豊', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '9b750c61-d77e-4b71-aee3-a12af5a582fd', 'オークス(株)', '0764417711', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp95715/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '4f4241ae-edae-4526-8bc9-8010c8240934', '株式会社グローバルプロデュース', '0357382117', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp203826/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c1c85b46-e4cb-402a-ba94-784049e4a309', '新日本溶業(株)', '0783060515', NULL, NULL, 'https://job.mynavi.jp/27/pc/search/corp97202/outline.html', NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '2fda0136-1194-419c-8f6a-b03be5123e61', '株式会社VISK', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd8994379-2e7e-40bc-9620-0ef6511a09c9', 'トップノート株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '53abb4cf-10ea-4f4e-9522-ecc74c59fec0', 'ベストオブミス埼玉', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1036c865-897d-4d79-a44f-e89fc85061d1', '株式会社MIG', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6b5dc3ec-5ba2-4db2-9e25-31bccacd671d', 'ウィリンクス株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dee2d857-6555-40fd-a0d1-fb3d9bea761b', '株式会社ぽかみたん', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '01f09321-40be-4961-9834-ab7a0cc82255', '株式会社ヴォーカス', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3033acea-96fa-47ae-a24c-54eceb44077e', '株式会社GTO', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8d60a5cb-4992-450a-9c40-4068376e99bb', '株式会社ミズテック', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '47f8f82b-f40b-442c-a1be-18f8fd86e6f6', '株式会社ライフビレッジ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8fdf7b68-1d72-4e71-967e-ef001fb15496', '一般社団法人HR Buddy研究所', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'cd99f8eb-36e4-4e4c-8ed8-7e4a3b80de83', '株式会社ライディ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'beb4ff53-fbea-4527-9f6a-6a3e9f4b4a8c', '株式会社PORT', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e8650ea6-0387-4a7b-9709-e836837a280f', 'apostrophe株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'e061b9f4-d2fd-400c-aac2-8746ecd7e282', 'otsuki_taro', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '0a05a09d-fbf2-452c-aec3-4d51f4f7e540', '株式会社未来ホーム', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6d8258dd-518c-4e3b-81ef-cb1103242e4d', '株式会社ゆいち問題解決', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'd1e8c5fc-9420-4099-9bac-0b61c9527860', '大森かずと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '5dc8b1bc-d891-4b04-ba7b-85da8cada77c', '森澤薬品', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '082df1ac-7150-4d78-baa1-56212a54c170', '株式会社unedition', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '5d2ce498-8ea8-467e-be64-177d71377475', '株式会社Think Up', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'aa344e71-b2bb-4433-9237-b1021e9a57eb', 'HIROTSUバイオサイエンス', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'af72c62f-147b-4648-8c13-00b53c1b73e4', 'ラディアンス', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '15551ef6-0526-4122-9363-dd2281b8ca64', '株式会社Gloria', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '5850258e-a938-4727-95f0-6f7721e9429a', '医療法人三幸会 小澤診療所', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'dc84c46e-f008-44b3-b2ea-85a5e95107c2', 'グロースリング株式会社', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '7089cba4-7d58-4f72-a0c6-439887ed441c', '医療法人社団星晶会', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'c50b7a1d-5bd4-410c-8eae-0090fc25273e', '株式会社maman', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '90522b13-7ac3-4e46-ac79-9a8b5d832c26', '株式会社アスター', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '3d06d475-c1e6-45a7-b041-a882dad05862', '藤原眼科', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '6c2dccf4-c09d-4e8b-913e-6e8854b8aab3', '株式会社レークイースト', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '1c0f2583-f7da-4ae1-a8d8-2b050a8c9fa8', '訪問看護ステーション　さくらんぼ', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '99093944-deb5-4c1f-81ba-3460e394ae36', 'グループホーム　ふれ愛', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  '8a431a7b-f875-4c5d-b82e-9109d90a8eaf', '株式会社 メディカルオフィス・創健', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO companies (id, name, phone, mobile, address, url, notes) VALUES (
  'fabfbbeb-558a-450e-a5a4-35ef1cf323a9', '社会福祉法人手取会　大門園', NULL, NULL, NULL, NULL, NULL
);

-- ============================================================
-- 4. Contacts
-- ============================================================
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '12d2c929-d76b-416d-ae9e-95365d9d2187', 'e28153bf-6eaa-4a90-898d-374203ab036b', '大内', NULL, NULL, 'i-oouti@wonder-price.net', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7a3d4948-b6fb-41f0-b553-d7d8ea2ff220', 'b1a96d7c-3307-4413-b07f-aaf94c866f88', '瀬戸', NULL, NULL, 'seto@inppiness.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5911a2ee-039a-404c-a40b-77211721cb34', '09fb2883-4892-441a-a67d-92c1fedac2e0', '下川', NULL, NULL, 'k-shimokawa@cam-net.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5b7d05ba-6dc9-4181-9a7c-193596c46c5a', 'd3c7a05c-68d3-4636-8f7d-9f111a1f83f0', '和田', NULL, NULL, 'wada@eversystem.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'aa1e0263-4315-4e7f-aee1-5ed1aec84c97', '273ce17c-8712-4f77-9ccf-caed2f5572aa', 'ライス', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1441acc6-7bc7-4329-a731-85d1f5f63519', 'd5a742c1-308b-49c3-9ded-634ccedae37f', '小野田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ec229ca2-6285-4e22-892f-549657fcb386', 'fded8de6-138a-4ba3-bb6d-8849c84ced8e', '成田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'df5b14b6-95dc-4c0f-99dc-eff3e0928f8f', '9c1a6d99-9e53-4f7d-90ae-3f43ee67409b', '佐藤さん：他上司2名', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '500a79a1-3b92-4ef1-829d-76075fb85819', 'dfced412-0dde-487b-84f0-fca9f29d4c58', '吉川 悠太', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ab5c38ae-4f6f-47eb-8ea5-1194ed9ba3c2', 'f92df853-9e9d-4988-b86a-6a06d505cc1a', '生口', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '66617e93-2342-4c1a-8dff-4f2d6c2dab9d', '5cbd8d09-f7cb-4b3f-85c2-538f8b769b07', '秋田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '79ae70f6-b026-4950-859f-beec2c60b31c', '23a8a5f5-39ed-41b2-a48c-cb1f5c32d797', '村田', NULL, NULL, 'murata@healthintect.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '14800714-04b8-448e-b349-8fa89fa0a648', '80a66e55-84ce-4ee2-8c1a-97b88028bf2a', '浅野', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3a0b0586-fe8a-438d-86ba-1a76ef4e8391', '20839b67-edef-4a3b-a466-01b0a0c3cc5f', '久保田', NULL, NULL, 'kubota@inclit.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '44e79f5a-cc1c-46e1-9959-b7836e515358', '6770019b-ff0f-47cf-bdb3-7ee887aa200e', '小暮雄一郎', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd3ffb3d3-84c5-4dbb-8751-861364e632b8', '3fc5a947-49fe-4362-9698-3c3898d068c1', '石井', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '895644c8-99cb-446c-b759-e40c833c08c8', 'f7952695-e177-4ec0-af58-5a275e77947f', 'チョウソギョン', NULL, NULL, 'sukyeong@shiiiro.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f8b6720a-2597-49e9-88d2-d90edc90abf4', '69d3070a-4a46-46e3-8697-ba03543e2374', '浜水　純', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7c8936c4-331b-4c10-8baa-c19fed7a93b6', '548afe59-8b2c-4a77-b1d1-41b9bfd01aa1', '大村さん', NULL, NULL, 'yukiomura1121@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd0f6d1f6-7bfc-4b78-a0c3-6e465771c925', '89913fcd-96d6-4149-845c-71e68f13f3fa', '大熊さん', NULL, NULL, 'k.okuma@le-gr.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '76e004d2-6b41-40e3-80b6-2405657aed3e', '814da5f4-0ca6-43b2-8e6b-787ae1067afe', '成田祥太', NULL, NULL, 'shota.n@mitashi.info', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e6923ab5-fa94-4876-b2ea-21d5e9f529cd', 'fdf00d6d-492e-4f30-9d96-91b1cda5d85a', '和田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '713b9867-3253-4e1e-bc39-717eeba1ba3d', 'cfdbe777-bfe7-4f76-b573-1c023f9b6b1c', '栗本', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '71f782a4-f6f9-4b9e-830e-6ab8dc6b3ad1', '0eaf1b81-9e9c-4d6d-a6f2-b04f2181d895', '深田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6067cb20-8a1f-4ae7-b559-bf75866dcac6', 'c415da63-75f3-49e6-8089-8d4d8a01cda0', '内村', NULL, NULL, 'kyotoshoji2025@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd580aa6f-f2ba-42f0-89f7-92b988cab969', '386985f2-6a44-4544-9c32-393e2e75a5ef', 'やまさき', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '25699791-0d8a-4091-b606-03d802d412dd', '15e0d149-189e-44f5-9f49-ca2faf3a48c2', '本田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd08470e3-fc76-4d04-94f3-5339142cff09', 'a8307135-d901-4a3d-ae6f-ece5a49635f0', '南川みどり', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'bf50c52a-69bc-4a5d-bd03-c2c0f25ace75', '74695e1f-7661-4ff1-a884-d7606fcb0e9b', '野本', NULL, NULL, 'y-nomoto@o-b-m.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2c267c6d-f16d-4b50-b501-e390720219ca', 'ae726233-a0e9-4828-9086-fc6d2657da44', '浅岡', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1adb43e7-ca86-43e9-abca-2961c7d9ae92', 'bc69ac02-70e7-4e97-af44-235ba9b62694', '田中', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6eda228c-a5f0-4979-8c9e-08d249446689', 'fa3e75cd-5cac-4b18-97aa-ff12fd2b617a', '後藤 伸行', NULL, NULL, 'ngotou@silverwin.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f8cc6ae1-a217-48ac-a783-28792eb5037b', 'dadcb276-cdd1-44a2-a176-580b8b702c01', '小谷爽', NULL, NULL, 's.kotani@crispcode.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3ed378cb-934f-4dce-be0e-da2a2e122058', '8ceed504-9116-4476-8b43-91f9c48b4414', '徳留正也', NULL, NULL, 'leadprovide.bpo@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1f6b7247-415a-4879-beb9-a99d14af50a6', '6e9ccf4c-e200-4390-b43a-d882f91903ed', '保坂', NULL, NULL, 'info@linkthrow.tokyo', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '86d95a8e-95bf-455a-9263-8db3acfa0b71', '8922b7bb-dcd9-4717-83f0-99df7167c0c6', '大橋', NULL, NULL, 'minoruominoruo@asz-group.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e89ecc4c-3a23-4b9b-b757-b99821931f75', '588ef129-6056-44ca-a898-6cb2ccf7fc2b', '加藤', NULL, NULL, 'info@base-creation.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '584b7c34-49cf-4e27-b3fb-55c66fde95ea', '1a8466ae-81eb-49d2-a336-fd6817935038', '竹野恵介', NULL, NULL, 'link@linkup-jp.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cd261b4c-fc7b-45ff-bd76-ac016272ada5', '0bb7d22a-a363-4be1-b95b-72e6c3ea6695', '松田', NULL, NULL, 'info@vaztwollc.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c29c3e5f-865f-494b-af19-563292dbd79f', 'b4812e76-9eb3-4950-a1c9-0c794e1d8c71', '堀内', NULL, NULL, 'yhoriuchi@digitalgate.ne', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3bcb0f00-73b2-43ea-bdab-0e1f5532a375', 'be369f39-588d-46ad-9ddc-c0145492b687', '井上', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '73c41cd8-34ff-40ba-8a43-dec41a9e54fb', 'cfd7d762-80d8-4978-bad0-4cc5d8a3d319', '斎藤', NULL, NULL, 'ryo.saitoh@staff-mk.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '66703471-c283-43c3-8d7f-3da1319ddbee', '04bb4f4a-c51b-47e7-bc4a-b84293e8014c', '落合様　鈴木', NULL, NULL, 'koki.ochiai@valorize-ai.com  soya.suzuki@valorize-ai.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '207442ea-0bf2-4fb7-b8c9-b355dd8fb5bf', 'ab0d95b2-ca5c-4e95-99be-3afb57d09ac8', '荒木様、山田', NULL, NULL, 'm-araki@aucservice.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '918a5da7-b587-42bd-8563-52b015a0ac2d', 'cc549c61-4e03-46bd-b2ff-dd68364acb16', '佐藤', NULL, NULL, 's_matsuki@btdp.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6bc47145-fd51-44df-b082-57e39860127e', 'd4bdc4b4-6ae8-46f6-8429-02a16cbfad96', '西本', NULL, NULL, 'y.nishimoto@islandbrain.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1cc858a3-c379-4ba9-8be7-4823c5f641bb', '32d0e247-1dad-4be7-a0b6-4f7dbef9d4df', '山根', NULL, NULL, 'info@gloxys.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7f7c5d88-b949-49dc-a1d4-190fa815fac0', 'df80682f-bf56-4398-a734-d98dacb7aaa5', '中村翔大', NULL, NULL, 'nakamura.st.sc@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b8cfa351-10e5-4c1f-b153-2ecca11c1ecf', '7edbccb8-b5a4-4729-a9fd-a7914bf4e752', '木村', NULL, NULL, 'm.kimura@prosell-traction.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3fd5929c-57cf-482c-9aad-c1f450598f89', 'f8af44af-2d12-4528-9a25-434a3cceca3f', '武曾', NULL, NULL, 'muso@shion-inc.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'dacd4624-f5bf-4ef2-8f1a-f4a7dd52b76c', '3dad9c6a-2f34-411b-85bc-9a4f48280ec2', '前迫', NULL, NULL, 't.maesako@hikarinomori.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '94c4445a-bbc5-40ad-b75a-f58d6f328434', '1b91dfff-d8bf-49c4-9a3f-73785d97f1e9', '田原', NULL, NULL, 'tahara@human-scene.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '298a8725-7280-41e1-9e07-914f85ef31be', '0074e7f5-996e-4f88-8b20-855f2175dc2d', '小林', NULL, NULL, 'a.kobayashi@cloudgrace.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '80655667-c842-494c-9cf8-ce2d0f1c922d', '9d78f5fa-6df9-4960-a422-287bf766e515', '黒田', NULL, NULL, 'hokuto.kuroda@acro-net.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'a1d790c0-a4e8-4d4c-b624-94e89b19aaed', '54db912b-3096-455c-8d78-901d7cca8efa', '田村', NULL, NULL, 'tamura@justfine.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1bce6ebc-a4f4-4b83-a53b-ea9ddc340134', 'e587d2e7-0e6b-4d47-9b2b-a00211d2f297', '岡本', NULL, NULL, 'okamoto@kooki.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '16a62e4b-59c9-406d-a6d4-24ed8cc06ecc', '0e94f29d-de26-411d-af49-9881c76abfcf', '三部', NULL, NULL, 't.sanbe@fmsnet.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1d92ae33-4e20-471c-975b-eae654c5634b', '9614ebb6-470e-4f4d-9958-8d9d8f5b7fe7', '伊藤', NULL, NULL, 'y-itou@i-tluslink.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'bfd2a469-7202-4048-8241-befaf324d05c', '52e21fe6-6004-4200-a750-408b0dae8359', '野村', NULL, NULL, 'g_nomura@orgallo.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '984af6a1-9884-48b5-a524-94d5de4a34b7', 'f77b1320-dec7-4345-8568-237e16a5c420', '岡田', NULL, NULL, 'okada@palulu.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e4a7b5b4-9577-4d48-ba1b-8919f5f6a733', 'abcdc170-42bc-44ba-b5bf-5b953136261f', '大木', NULL, NULL, 'ohki@ar-ch.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '880d5412-b71c-4d2a-9a29-75b840f5b626', '4bb991f0-0f29-45d6-80ba-390626497980', '西村', NULL, NULL, 'minamim@direct-link.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c2da1417-4638-4820-bfc0-06c8c41f7f9e', '329a0d00-ac37-4a9f-a348-e29dc74a7487', '浜野', NULL, NULL, 'hamano@7chord.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e2519ff0-e7db-43e0-961c-e4abbe5a2bfe', 'f8ee3afb-ea69-4836-9665-15ae52972908', '稲田', NULL, NULL, 'inada@navi-p.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'fd8c5054-e8c7-47e9-95f5-f7f1be8bb67f', '479e1b92-4c22-4fc4-b252-1116d7927314', '平尾', NULL, NULL, 'ryuto.hirao@newdeck.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'fda07fb5-0cf3-46ee-851f-ee6ebe92fce5', '7661bb47-c6eb-4689-9b6b-d448ac9a414f', '石川', NULL, NULL, 'luxeinc.info@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2ef82757-3994-494d-ab2d-bc5cc8063984', '73684d1b-a872-4710-b038-91b625fd87d5', '平本', NULL, NULL, 'takafumih@sekatsuku.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '54a35de2-44bb-4d5a-bf64-196c0fa0d19d', '3b521799-45e4-4b2f-87d3-81757d3f808f', '中村', NULL, NULL, 'kakutani.y@sora1.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '99fed154-b1bd-403c-9178-72fa8e1c2126', 'bb93a1db-33c3-46dd-bf69-7fb1ff320ca2', '塩釜', NULL, NULL, 'shiogama@aidma-hd.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '918dbca1-ed90-40ee-a9e9-02c1090f7779', '2ab190c3-c72d-475a-ac7b-ab16bcdd6dd2', '小平', NULL, NULL, 't_kodaira@libcon.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '54d14955-5bfc-4f47-835d-aef894ca958c', '6889860f-4956-45de-8983-6e75493ed533', '山名', NULL, NULL, 'a-yamana@kbinfo.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '19b21760-fddd-41e3-91fe-7518e6466377', '92fe94d7-eacc-426b-8ed4-11c898aea788', '松井', NULL, NULL, 'r.matsui@segros.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6f0ec6c7-af11-4a95-adc9-709fd5a36a62', '20e5a86d-f768-4395-ae62-8055a78c1b78', '前田', NULL, NULL, 'ryota-nakamura@actpro.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'acd5d64b-be6a-44c7-a4ec-39d3f0b844d9', '2df9a3dc-1fb1-4ede-99e0-40dea98ac764', '小柳さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '011aa93a-aa12-4e71-8491-9a8d23e345b4', 'eed3c4e4-715a-4172-9a24-e4207b3dfa3a', '小池', NULL, NULL, 'y_koike@belltech.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4e24bda3-10d9-4fa6-a8e5-b4b657b14dbd', 'b78a74e6-da90-4276-9c30-d7c839bd19ff', '山野', NULL, NULL, 'r.yamano@kaitak-sales.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f8007f41-0272-4b77-8857-5daedfec8308', 'ab96240f-7409-423d-b6c2-bbc3426052e3', '石原', NULL, NULL, 'info@biotope-consulting.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '384fec56-cb05-4361-8c24-1d82d828c8cc', '25f6472e-eb78-4cb4-ba67-8d31069708a8', '篠塚', NULL, NULL, 'm-shinozuka@manifest.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b2463ceb-54e0-401c-833d-9e1219148d75', '7767af12-63ce-4e06-a2f3-9ed14dfe4544', '松山', NULL, NULL, 'momo.matsuyama@neo-career.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'baffffa7-6277-43e7-9f12-73c4e871acb7', '642e17c6-f484-4323-840e-f5bda332870d', '福田', NULL, NULL, 'contact@socialsolution.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6695d7e5-058b-40af-9b3b-d5f93bdcde28', '2bead48e-fe88-4b6b-8b25-ccf107a5064b', '村井', NULL, NULL, 'h_murai@extbold.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'eadf6c18-b057-40b0-a9f5-fd5040f9b566', '108df061-8f6f-4b8b-bcc9-bfaf9ae85bb7', '笹田', NULL, NULL, 'hsasada@eigyou-hack.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd68e6ece-cc6e-4273-b410-f9295d434480', '293b3173-a1b5-4cec-880a-d9fcf352ed80', '原', NULL, NULL, 'oshiyama@reizx.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'edb55e7d-04db-4873-a1f1-65097099ebd2', 'fd0a1f9e-7068-426b-a33c-0450d68a4281', '村井', NULL, NULL, '<murai.fumitake@edge-connection.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '92b61765-d8e7-4f1b-a0df-115b0e74c8ac', '60ad7b6b-f4c0-4602-b8b5-64223f105608', '渡辺', NULL, NULL, 'eigyodaikou2@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b8793ad9-e32f-4105-a1a2-a12b57684ac1', 'eb814b26-1221-4b8d-a366-cad035615250', '高橋', NULL, NULL, 'h-takahashi@quihilari.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd14aab20-92e3-473e-adfe-7721edb41b80', '0b019907-9c25-48f8-8dd4-a1c7879ba123', '宮永', NULL, NULL, 'miyanaga@ingjp.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd05c2e3b-6a6a-4a81-ab4c-9f9f55ba8aad', '2f04e3ea-201a-4638-91c6-2b7b70338576', '花園', NULL, NULL, 's-hanazono@confidence.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4d6f5c66-1d1a-4485-8285-752a43bc3fd2', '088d9ab5-0584-4453-b7e1-349b13157556', '大黒様、飯田', NULL, NULL, 't.iida@bemotion.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '201c337e-d1ec-4eb5-bfd8-c908697eea15', '778e7c70-b350-4330-921e-3d05519d6c00', '尾西', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f3e96684-0dc1-4a1d-b023-e120e503695a', 'c69e2541-3d69-4bbc-8f71-b32030efdbb8', '石川', NULL, NULL, 'm.ishikawa@intense-jpn.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '57b7faef-812f-4daf-b9ca-d76b009de67e', 'a309100e-f6a6-4863-8038-a2e3f27860ae', '久保井', NULL, NULL, 'kishihara-fum@imprexc.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '872ff165-5b39-4450-8892-8f81aafdff6a', '45ad2dc7-cf01-40ef-b56c-7013cfd5e33f', '鈴木五月', NULL, NULL, 'suzu@pentascare.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5b4a56fa-c45a-46a2-9ff5-019fd043c9e1', 'fb23ab20-c724-4c59-9f79-94cc37a343c8', '深堀さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1b9daad6-7e73-494e-96eb-51fae3b1aaac', 'c420c14a-e199-4717-b626-652add7536b7', '野本さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b2698588-7380-4547-99d5-221cb1ceb475', '171ccf99-77f6-4cd8-a049-66279e3e2b75', '齋藤', NULL, NULL, 'saito@integrityplus.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2ef45007-f954-4c60-849b-f2b94b955ad1', '9fb4ba49-49f4-4b26-bf32-282a797f33f2', '伊藤様 本田', NULL, NULL, 'y.ito@jippou.co.jp r.honda@jippou.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'a69dc9e0-f6fa-40f8-8712-1114dbb5fe60', '29debf76-11dc-4b43-9eae-de5d55d43d00', '藤野', NULL, NULL, 'keishi-fujino@seneca.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '0a18cc18-c548-4ddf-9c5a-128508505521', '3b3cb6c4-081f-47d1-862e-7377db7511e1', '永田', NULL, NULL, 'info@cyber-connect.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '9cfeb27d-5bea-4d26-9f70-e7e1c36869af', '86a0b83b-920c-4b2e-a713-a1555f3d64cc', '安田', NULL, NULL, 'shun.yasuda@lians-sales.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '93bf299f-906b-491a-8acc-30336e96dc92', '49fe0148-7c9e-4b31-8486-7457bdbd38f9', '大西', NULL, NULL, 'support@aikisystem.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5ce0bf0a-9ad1-405f-904a-c4fb3f80169c', '48293833-c5a9-419a-85da-4b8aae66563f', '金谷', NULL, NULL, 's_kanaya@bb-connection.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '456d6849-1237-4582-a766-fad5234f577d', 'f8d8187f-8bea-49a5-bca2-40f769cd5b7d', '松本さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'faf88dcb-6ce8-4f98-959a-6b7549b721fa', 'd5e2f9e7-2e1a-487b-86e9-9decef79feb4', '岡村さんx(弟)', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7220fa84-2f6b-4575-956b-d90e9b86d3e3', '48e4311d-f89c-43fd-a539-d5843e5f0599', '高田', NULL, NULL, 's-takada@grow-support.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4918e599-b4e0-4eb2-b557-0518b0219eed', '3f0f9b18-6d87-4be8-84e3-505c48e9408f', '杉浦', NULL, NULL, 'sugiura@l-e-o.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7887ce1b-3f3d-4c02-952d-2a8fb495f782', '7a517b28-5c84-4882-aa1a-2f686458a484', '滝本様　谷川', NULL, NULL, 'emiri_t@earthlink.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '782b067e-e934-43c8-9376-0d1d59de3b85', '44c00561-a31b-499b-885b-caa89a31e001', '山川 元芳', NULL, NULL, 'yamakawa@ytk-group.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '308c6d91-df62-4dbf-a1d4-42938ce02e48', '3c56a85a-4841-4810-af53-41d3e4a70088', '釘宮', NULL, NULL, 'kugimiya@neocreate-coltd.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1a6a9203-56a1-44d6-9e43-f1323862a7b7', '9af5f51f-954e-4242-b330-72c12e788c84', '大岩', NULL, NULL, 'info@hersell.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2a5ef72a-bc1a-4850-a75e-b49e407eba3f', '29ca7b2d-e354-4176-aed2-c643ba9d8338', '松浦・宮城・原田', NULL, NULL, 'shimpei.harada01@g.softbank.co.jp kuniaki.matsuura@g.softbank.co.jp taiki.miyagi02@g.softbank.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '32d5e6ed-4738-4fc9-8c18-f729d6b024a7', '6673e382-9192-4ba5-95f3-fff0077796b5', '末光', NULL, NULL, 'karitoru@stock-sun.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '0c72841e-75fb-4b3a-9705-5f5f18aefaee', 'e04f60a1-ab76-40d1-ad89-b08a1e00c1be', '森田', NULL, NULL, 'k-morita@tele-net.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '84504b1c-6377-4a0b-83e5-4d17c9d84efb', '128ca6c2-97f5-4509-aa3b-83153664e7af', '宮下', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e68530ea-d5b4-46d7-a3ab-b882e8e787bc', '1514158c-61e8-4ca7-b72a-90f1a7e0c225', '高橋純一', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4278f7d3-c61c-449c-ade4-3cfc9d9c2c1f', 'b1afce4e-5840-4d49-88fd-b9389fe0f95d', '亀塚', NULL, NULL, 'kkamezuka@miqtora.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5ed80320-3b10-43c7-9f0e-319c7d9ef6af', 'c1af7970-c582-4238-98ab-dbd2ca2b6840', '佐藤', NULL, NULL, 'sato.k@r7feelson.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f5f089c1-d5d6-476e-9aaa-61d07d80baa3', '566eefe1-bc17-4390-a897-420911a6355f', '野上', NULL, NULL, 'nogami@realrise-sales.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '77fb2158-9833-41b9-aeef-e5cd1554a2e6', '53f1f6e8-7e9b-488f-ab55-2e03e75c908d', '蓮實', NULL, NULL, 'k.hasumi@salesandinnovation.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '982d6f9f-3403-49ba-90d3-1a48ee1b099d', '6a7ee605-cf6f-4585-9acb-c1b1d308cedc', '宇野', NULL, NULL, 'info@d-assist2025.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '9bb07076-6e28-47c0-a619-f2575d017019', '63395cb3-970a-4668-8263-872250a435c5', '井川', NULL, NULL, 'ikawa@jnc-service.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'dc6828d5-5a8a-461b-b065-b0727acae01d', 'f3a033cb-f107-48e8-88d1-1ed334c6d247', '秋元さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b4c8631e-aca5-4e2d-8b82-2810808db36b', 'd40c5164-1e62-4398-b518-7adc32d85157', '新冨あずさ様（シントミアズサ）', NULL, NULL, 'sales.group@kakutoku.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'bde31958-5f66-4c52-a4eb-2d2da166a8ac', 'e54e5971-a6e5-4e97-bedc-c72215567397', '池谷', NULL, NULL, 'daichi-ikegaya@resens.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3c9d2a93-5e46-4d6f-8285-3ad06376a20d', '30bdd6d0-a7b3-4cf9-a120-e5373030e7bf', '中武', NULL, NULL, 's-nakatake@c-connection.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3573445e-f480-468a-8f23-ebf0d4699053', 'ed7c261e-1702-4340-8874-491968c4bbea', '佐々井', NULL, NULL, 'kenta.sasai@salesbuddy-inc.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'af384902-ac11-4125-955a-e64c0c3bd9cd', '713b75bc-9794-44c8-9694-023345629854', '問合せ中', NULL, NULL, 'info.odawara.shachu@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '0582d6f0-5a76-4c73-9b23-9a0610a7f413', 'ef3c4fb3-d63b-49f9-a36f-3b2cc3461bfc', '峯松成充', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c899596a-bcd1-4c4e-8fe2-5ef884262218', '90b1c44d-3759-45a2-8753-bc27ef6206ad', '佐久間　立宇', NULL, NULL, 'info@altrunist.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '83ac44f0-9f0e-4356-a211-d249be3d9ab6', '875e84ae-5263-488b-b3a8-e34d98558cb3', '小滝　和也（コタキ　カズヤ）', NULL, NULL, 'kkotaki.arc@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e1e50dab-7150-4f7a-b4f4-a0f556d04e4a', 'c839d09a-d14f-4d99-b81e-0994c348e5f6', '松野さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '87ab2ff3-8804-4f30-ae71-36e2e8040dd4', 'c261fd0f-effe-4483-99d9-e2284934bd5b', '園山', NULL, NULL, 't-sonoyama@solgrit.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '08601caf-7118-49e2-ac3a-a28517e576ec', '71b4d34e-8ae3-4dd6-b216-6f17a6f37911', '落合', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2173da47-0af9-49a7-8a49-0948165b10b1', '7ca76830-7fce-4422-9a14-da8c151e7ee7', '江﨑　博美', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ceed3bb8-2a18-4de8-a764-ce4fd514d34c', '04fea7be-b951-4f48-a263-8d03937820df', '佐藤 聖太', NULL, NULL, 'sato@emochika.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '138976d7-7e3a-45d7-8885-e2c0476e37b8', '1c166e6b-bb74-46d1-b90b-76930ef699ea', '和田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd9a392f8-2a18-41f4-a1d9-f6d675a390ce', 'b9a2a816-7849-4951-a873-2e28a5de73e2', '伊藤', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '668bd3ae-6e37-4bae-934e-34f061e3be8a', 'e78a2fa9-0453-4699-86a2-f7b66fabd416', '藤岡', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e3671aa8-9a0d-4668-999e-ce39c16ea211', '9a668991-3ae5-4a28-a78f-ab7ff34cb12f', '吉成ゆいさん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ae8adda3-1c51-47f6-ad56-3911ff3d55c3', 'ca0fbc43-1634-401a-a43d-acf3a5f9c4a9', '難波', NULL, NULL, 'nobutoshi.namba@tokai-bs.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3f4e3437-7bc7-46d9-8bea-39e8592fa014', 'dce81887-8f73-4523-8df0-bb9a2a6ce492', '岩崎', NULL, NULL, 'o.iwasaki@achievers.team', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '44d94451-6801-4c60-bf45-7d9d07763d84', 'cf91516e-6f17-407a-b57e-53ce21df3790', '難波', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '73a5bbba-1c1b-4040-b4b7-2e0f9cb151d7', '647c40b2-833d-43a9-b8c8-e92c82a6065e', '清塚達士', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '8fb5e9a9-bb98-490c-be04-9411ea4af446', 'd2411421-153f-4f6c-85b2-4946ab7a6ea9', '近藤', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c2f0adc8-af10-41a8-be20-5d0cbbd387aa', 'aa43c2e3-a647-440a-8e19-31fac25bc4ff', '久野', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '76ae0e46-5fae-4ef0-938f-3b201768255f', 'd370fcf4-ad95-4143-b3d9-09215f88853c', '古川', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cd9ee689-6ac7-42ef-9976-5434ee43c26c', '75581949-d765-4635-bb60-0f6adfa4e89d', '伊藤', NULL, NULL, 'itou@novagroup802.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5b5fc9dd-410d-4ebc-97f5-47f98b6773b6', '05a6a5a3-ebd9-4574-99fb-29bdd7f09dc5', '大和田', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c5215202-8a52-4d30-9eac-a49a3e0c5a4f', '9d435765-f751-442d-8470-6e711fee6c42', '段', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ee07da5c-d4ab-452b-9da9-540047919a0a', '6a04eb32-9802-4c41-b74c-fa38c877edc7', '浅賀啓太', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5932002c-a8c9-4c02-83bf-2aa94ddbe866', 'a57d82c0-7203-47d4-bce2-052e4b1889ed', '堀内', NULL, NULL, 'career8@controlgroup.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'a9f79931-0ed1-42aa-9580-78f7816ae0a5', '57f29818-def9-46fd-8081-2860de4b6827', '岩本', NULL, NULL, 'm.kawamura30@tkcnf.or.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b05221b6-96fc-4a68-8871-46dc3f54206c', '2afdf017-d683-42d0-ad2b-ab3c93c95b37', '鋤柄様　(すきがら)', NULL, NULL, 'kanri@tokai-nichiyu.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '6750cfc8-d699-46a9-a163-b0553f1e749f', 'f6ffc200-e0c7-414b-b94f-12350504bf82', '渡辺', NULL, NULL, 'watanabe-y@almic.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '21f67ec0-b02c-468b-af9a-edacddc5395c', 'a0375b23-c9f6-4641-bb5b-5bef4b6d4855', '長谷部', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'db7c39bb-6012-4e73-8c43-544a309a337c', 'a1a0d541-0874-4b46-9449-1aa1b15998d5', '笠井基生', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3867d480-61f8-4179-9c8f-b9724880efdc', '456d3daa-b090-43fd-a07b-1cbe633893d2', '八津尾', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '484db7fa-974f-49ba-ba9a-dc6edfb09a54', '6d3461d4-95a5-4444-957a-581ee7b4c7f2', '木戸秀典', NULL, NULL, 'kido@worldi.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c69f5fe6-7b45-44da-875f-cfc82280afbd', 'fb60b87e-0e55-47d7-a448-861ce29f2140', '石川', NULL, NULL, 'ta-ishikawa@nishiki-estate.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'bdcb1f05-35f9-40d2-973c-a41fd2a50c64', '10404e0b-af70-4eac-bce8-37b2189ea9c2', '村上', NULL, NULL, 'murakami.hirokazu@tomoe-group.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'be1f4456-25e1-45b0-a22e-08c662d32ea8', '9a95002d-364e-464c-bb19-3d0def07f856', '掛端', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f2bf63aa-17bd-49d0-9f21-80bee88543e4', '68e2ad80-528e-41f4-872b-b209889e67eb', '富山', NULL, NULL, 'h.tomiyama@morooka.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'aeb64c26-4c93-4bd4-9d41-a1bb03ad069b', '7de3f30c-6dc2-4612-aaaf-d2bdd79c111a', '田和', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '03a579c4-328b-489c-a369-2988c2ea90ba', '65e3c52a-9fdc-42ab-9e7f-0bbc428fe79a', '縄野 政彰', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '2525f8aa-3137-46ff-8de6-5f2eea10a727', 'f86e3799-516a-46cc-9455-17cdfa34ee7a', '佐藤利音', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '65d00623-34b8-4786-b577-9a3e48202e15', 'bf91a08e-bfce-401b-84a1-c195eec61bca', '五十嵐洋介さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '0ddb2a9d-ee75-49a0-918a-fb8c2e76e4b9', 'f3cc5b19-6876-4e91-b9de-f64799d08bbb', '鈴木伸聡さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4826674d-5a1e-42eb-a86a-8490e9bc2236', '5ea0fb2a-cabb-4166-b891-9eceb14b86ba', '古井戸レアンドロ', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '550826af-46f6-4cca-bf2d-188e2da47182', '8aaf860d-9e8c-415d-9002-de582fba74c3', '花野雅彦', NULL, NULL, 'm.hanano@arklink.net', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5b1c03ab-9699-43ca-af33-d98009d97f30', 'c55bd7e7-47c8-424b-b8cc-eeada3e6b4bd', '渡辺', NULL, NULL, 'swatanabe@kasacon.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'bbc0e9b6-d529-4078-86d6-683fdf54e312', '465a3d78-f860-4f27-a7fd-736f3f31b458', '高田', NULL, NULL, 'saiyo@dalab.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '086c7900-3bba-4c9c-9e10-0708248b3d82', 'bf49d17e-5791-4eb2-9b59-52993dcabccc', 'カワハラ', NULL, NULL, 'y.kawahara@nitto-okayama.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c9d5f391-26af-4020-904e-69d21c2692c9', 'f2c77f70-f8c1-4cfa-9e06-77830aa0b8ba', '熊谷', NULL, NULL, 'yuka_kumagai@alphatec-co.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '1854d842-c88d-442e-ad6e-25b689b0e96c', '6c464925-9cc0-4467-b8e7-d0a5385af2ec', '鈴木', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '676bf5b5-45f1-4b77-b05c-8164b0946f3a', '02f13c2d-6fec-4374-a983-436e3d4d2b01', 'オオタ', NULL, NULL, 'ota@sopia.or.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5a70538d-8edb-4fc9-a240-3b14aa134b5d', 'a3af25b7-8ed3-4568-850f-9bf241085970', '佐野', NULL, NULL, 'k-sano@forval.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c10f6ca5-13ce-4883-9f62-974f1f5cde3a', 'dff62bfb-ad84-4178-bcf6-17f653c87fc2', '高井翔平', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e10e943f-fd44-45e4-a317-c08f3fc0a86c', '11a5774d-5aba-45c9-b781-dbdeda19f66a', '窪田', NULL, NULL, 'k-kubota@rebible.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '43807068-03a4-4492-8114-29b5ac256ebb', '70fb1848-dc77-47eb-94e1-0227db7017c8', '舟山', NULL, NULL, 'm-funayama@hotelaomori.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'e544c28d-97f0-41c3-9594-1da0fb43b567', 'f929394a-b5dd-4be5-9e1d-e742a27f39a2', '平田', NULL, NULL, 'recruit@creencia.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '95cf0e7e-f0aa-4deb-be55-7e39c6e9278d', '9a2dde32-a390-4c9f-96dd-b2fb9e230616', '庄山', NULL, NULL, 'shoyama@housetohouse.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '00f561d2-a24c-4ae8-8c9a-4cc96761a3f4', 'c606acd1-2909-46ab-964a-552fcbdc9d9b', '樫井和雄', NULL, NULL, 'kazuo.kashii@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '379aab1b-f4d2-46b8-aa89-e443cd753d9b', '1104fe2e-6122-46c4-af12-15cf1e8ca8e9', '宮野さん', NULL, NULL, 'miyano@styleinc.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3136f286-788c-4180-8376-f0a64ec83cd1', 'bd8d17c3-76b9-44f9-b34d-96297e68de0a', '佐藤雄大', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '245c7f03-90e0-4e44-8005-d8a695ff56b1', '13a8afcb-e653-47a4-a547-1249c4e54228', '藤方さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cfa10620-0c3f-4fe2-8dbe-bb3b1e2f970c', 'c029e507-ce1c-4ab0-9702-506893af5c0d', '高鍬 仁一', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7e97e6c7-115b-49ab-a69c-be2ca6aeb0af', '128ee08d-8323-4ec2-b2bc-3d0a15d929f1', '行方（ナミカタ）', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '25dff735-e065-4fe4-86f6-463404278697', '7d93e886-cf15-4225-8da4-aa7a08e73026', '竹中　恒一', NULL, NULL, 'takenaka@kyoho-jp.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '47f7fa27-837b-4b00-882e-83d211da8ba1', '9b750c61-d77e-4b71-aee3-a12af5a582fd', '道下', NULL, NULL, 'michishita@oarks.co.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '4e9ac435-7381-480c-9ad7-8e842e18fb66', '4f4241ae-edae-4526-8bc9-8010c8240934', '重田', NULL, NULL, 'shigeta@global-produce.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '84b2c088-8154-4ac7-99f2-a2fbbe8c8f3c', 'c1c85b46-e4cb-402a-ba94-784049e4a309', '松本', NULL, NULL, 'yuya.matsumoto@snyg.jp', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '832e9652-dbbb-4b31-89bd-4000fff4f813', '2fda0136-1194-419c-8f6a-b03be5123e61', '笹川', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'c9602625-02c9-490f-b7bd-ba3996b88dfd', 'd8994379-2e7e-40bc-9620-0ef6511a09c9', '早野', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'ba8ebe2c-3f17-4b39-b182-748a183801e7', '53abb4cf-10ea-4f4e-9522-ecc74c59fec0', '富岡龍也', NULL, NULL, 'best.of.miss-saitama@add-group.biz', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '0ce4cd44-3089-412c-bdec-beb50ca5788e', '1036c865-897d-4d79-a44f-e89fc85061d1', '岩上', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'd4df84c5-a69a-4e2a-af81-b1b4ddc2fbda', '6b5dc3ec-5ba2-4db2-9e25-31bccacd671d', '信組由貴実', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cd0528a9-a9b8-4e3e-97ab-1861dd7a6ddf', 'dee2d857-6555-40fd-a0d1-fb3d9bea761b', '甘糟穣二', NULL, NULL, 'amakasu@pokamitan.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '34b65e21-8509-4cc1-a26a-0e310284accd', '01f09321-40be-4961-9834-ab7a0cc82255', '川岸', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '7d874a4d-9f06-4c9f-af29-9df0285274c1', '3033acea-96fa-47ae-a24c-54eceb44077e', '塚本基樹', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5c379bb3-5060-419d-b307-96ff6f2d628e', '8d60a5cb-4992-450a-9c40-4068376e99bb', '小林 慎太郎', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '5d5eb0c4-c8fa-4abf-b95e-dd0e2e381783', '47f8f82b-f40b-442c-a1be-18f8fd86e6f6', '池尾俊哉', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '61e34f00-5662-45e4-b486-5637c806806a', '8fdf7b68-1d72-4e71-967e-ef001fb15496', '佐藤優介', NULL, NULL, 'yusuke.sunny.sato@gmail.com', NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '8e7b4897-bc95-4010-bed2-9f91b58891d0', 'cd99f8eb-36e4-4e4c-8ed8-7e4a3b80de83', '重松 祥大', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cead4ca5-5b45-4d1a-b71f-ef1ff99acc1e', 'beb4ff53-fbea-4527-9f6a-6a3e9f4b4a8c', '三橋さん', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f8c9c2a4-949e-41d2-b0da-f50258295691', 'e8650ea6-0387-4a7b-9709-e836837a280f', 'カンザキレオ', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'f6dfcdfb-fcba-450a-bb0b-9f01b99ed98d', 'e061b9f4-d2fd-400c-aac2-8746ecd7e282', 'Yuki Seike', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '53a5e4f8-655a-4836-8c15-be137c024361', '0a05a09d-fbf2-452c-aec3-4d51f4f7e540', '宮崎', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b54f3eaf-3f6b-41ae-850d-8174db56d663', '6d8258dd-518c-4e3b-81ef-cb1103242e4d', '畑中', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'a89bd62a-06c7-4c52-a660-9a11549dc847', 'd1e8c5fc-9420-4099-9bac-0b61c9527860', '大森かずと', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '350494ba-0333-42a5-bf16-cc359bb5b3ea', '5dc8b1bc-d891-4b04-ba7b-85da8cada77c', '西山賢太郎', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'cae7a2fb-0af7-414b-89a6-ee5d9549a27f', '082df1ac-7150-4d78-baa1-56212a54c170', '中野慎也', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  'b1e9b260-44b2-414a-bba5-8ccdf6661d3b', '5d2ce498-8ea8-467e-be64-177d71377475', '高嶋 克成', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '3c56c042-8a79-489f-9151-22491042de76', 'aa344e71-b2bb-4433-9237-b1021e9a57eb', '紺野', NULL, NULL, NULL, NULL
);
INSERT INTO contacts (id, company_id, name, position, department, email, phone) VALUES (
  '98ce8a6d-c990-4a07-a142-169df6ba0078', 'af72c62f-147b-4648-8c13-00b53c1b73e4', '安河内恵美', NULL, NULL, 'emiyasukouchi@gmail.com', NULL
);

-- ============================================================
-- 5. Deals
-- ============================================================
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2d7f881d-104d-4d64-8fd9-fc77b8bb0fcd', 1, 'e28153bf-6eaa-4a90-898d-374203ab036b', '12d2c929-d76b-416d-ae9e-95365d9d2187', '男', '00000000-0000-0000-0000-000000000003', '2025-11-27', '2025-12-04', '10:30:00', '確定アポ', '担当者', '4a641191-8349-45d6-a7be-51577e35fe21', 'ダイバーシティオークションの運営の部分では可能性あると。 古物商関連', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'dd33cecc-9288-4379-8579-5dabeb45d1dd', 2, 'b1a96d7c-3307-4413-b07f-aaf94c866f88', '7a3d4948-b6fb-41f0-b553-d7d8ea2ff220', '男', '00000000-0000-0000-0000-000000000004', '2025-11-28', '2025-12-03', '14:30:00', '確定アポ', '担当者', '655a65c7-55d1-4a95-88cd-54a82a1fd951', 'アドアフィリエイトの会社 ほしいアポは人材、金融系 店舗が多いところのパーソナル、ピラティス 担当役職：リーダー アポ提供額希望：1万～1万5千円', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Bヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b7107c59-e4da-4f20-a410-f70fe3333ef2', 3, '09fb2883-4892-441a-a67d-92c1fedac2e0', '5911a2ee-039a-404c-a40b-77211721cb34', '男', '00000000-0000-0000-0000-000000000002', '2025-12-02', '2025-12-10', '10:30:00', '確定アポ', '責任者', 'b8f0b757-efca-4f3b-810f-c28153aa29d2', 'おそらく取締役 既に固定の営業代行依頼していて話聞くだけになると 成果報酬の仕組みもわかっている と言われたのでテレサポの話を少ししたが必要ないなとのこと とりあえず話きくだけならOKだと 営業代行の話はめっちゃ聞いてると', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fe061661-2643-43e9-9c40-568b9f0f38cb', 4, 'd3c7a05c-68d3-4636-8f7d-9f111a1f83f0', '5b7d05ba-6dc9-4181-9a7c-193596c46c5a', '男', '00000000-0000-0000-0000-000000000003', '2025-12-02', '2025-12-05', '13:30:00', '確定アポ', '社長', 'a3cf2bf9-35bf-43bd-8f8f-c14f554a1897', 'ほぼ個人で動いている会社らしく、案件対応の量にも限りがあるためニーズは薄い。 ただ、小さい規模の案件をとる観点でお使いいただけるかもと話してアポ取得。 wada@eversystem.co.jp 和田', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0bd0187b-975b-4177-8edd-0102be922214', 5, '273ce17c-8712-4f77-9ccf-caed2f5572aa', 'aa1e0263-4315-4e7f-aee1-5ed1aec84c97', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-03', '2025-12-22', '15:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'AI教育やAI LINEエージェントなどAI事業を行っている株式会社mottodigitalのライスさんをお繋ぎします。', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0596ac84-557e-4151-8225-ba5c7679a42b', 6, 'd5a742c1-308b-49c3-9ded-634ccedae37f', '1441acc6-7bc7-4329-a731-85d1f5f63519', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-03', '2025-12-08', NULL, NULL, NULL, NULL, '補助金申請を行っている　小野田さんをお繋ぎします。', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '059f5e37-0cf0-4377-91c3-e6f3ccd79cb8', 7, 'fded8de6-138a-4ba3-bb6d-8849c84ced8e', 'ec229ca2-6285-4e22-892f-549657fcb386', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-03', '2025-12-03', NULL, NULL, NULL, NULL, 'web集客支援をやっている株式会社ミタンの成田さんをお繋ぎします。', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 8, '9c1a6d99-9e53-4f7d-90ae-3f43ee67409b', 'df5b14b6-95dc-4c0f-99dc-eff3e0928f8f', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-08', '13:30:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', '飲食商材を探している中で、AIテレアポの話を聞くことに', NULL, NULL, '商談可', '受注', '受注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b56a5776-53e9-48b3-83d9-f63963f63776', 9, 'dfced412-0dde-487b-84f0-fca9f29d4c58', '500a79a1-3b92-4ef1-829d-76075fb85819', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-09', '12:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'WEB制作 https://aoco.jp/profile/', NULL, NULL, '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a751609b-a838-4f03-8b89-29094d7f28ad', 10, 'f92df853-9e9d-4988-b86a-6a06d505cc1a', 'ab5c38ae-4f6f-47eb-8ea5-1194ed9ba3c2', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-08', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'https://jp.linkedin.com/in/%E6%94%BF%E6%A8%B9-%E7%94%9F%E5%8F%A3-3803a410a 製造業からのリードをお願いしたい', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0e097a66-eb1e-4b7b-ac17-6f20fa1f3756', 11, '5cbd8d09-f7cb-4b3f-85c2-538f8b769b07', '66617e93-2342-4c1a-8dff-4f2d6c2dab9d', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-08', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'https://sis-pts.com/about/ パソコンを企業様に新品の半額以下で提供している株式会社エスアイエス·パートナーズの秋田さんをお繋ぎします', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1733bab6-fd1d-49f1-bb85-b385221f3f7a', 12, '23a8a5f5-39ed-41b2-a48c-cb1f5c32d797', '79ae70f6-b026-4950-859f-beec2c60b31c', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-14', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', '50人以上の企業様に産業医導入をサポートしている株ヘルスインテクトの村田さんをお繋ぎします。 https://healthintect.co.jp/company/', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c30f62e0-b2b9-41ce-9d96-e91d4ab384f5', 13, '80a66e55-84ce-4ee2-8c1a-97b88028bf2a', '14800714-04b8-448e-b349-8fa89fa0a648', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-10', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'ブランディング支援を行っている合同会社 RISOOO DESIGNの浅野さんをお繋ぎします。 https://risooo-design.website/#service', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 14, '20839b67-edef-4a3b-a466-01b0a0c3cc5f', '3a0b0586-fe8a-438d-86ba-1a76ef4e8391', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-14', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', '補助金、助成金を月額1万円でサポートしている株式会社インクリットの久保田さんをお繋ぎします。 https://inclit.jp/2', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '受注', '受注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7ddeb095-d5d8-4229-afba-afea74390100', 15, '6770019b-ff0f-47cf-bdb3-7ee887aa200e', '44e79f5a-cc1c-46e1-9959-b7836e515358', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-08', '2025-12-08', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'https://livedoctor.jp/ 研修事業を行っている LIVE Doctor株式会社 小久保さんをお繋ぎします。', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'edda3d78-a647-4a2a-8925-9ac37f6c62e6', 16, '3fc5a947-49fe-4362-9698-3c3898d068c1', 'd3ffb3d3-84c5-4dbb-8751-861364e632b8', NULL, '00000000-0000-0000-0000-000000000001', NULL, '2025-12-08', NULL, NULL, '責任者', NULL, 'https://www.kesion.co.jp/ 取締役', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3f3b6e1c-9691-4c54-8cca-721d62115ef2', 17, 'f7952695-e177-4ec0-af58-5a275e77947f', '895644c8-99cb-446c-b759-e40c833c08c8', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-11', '2025-12-12', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '33cbe75f-a240-44bc-9426-c1fc67489b9e', 18, '69d3070a-4a46-46e3-8697-ba03543e2374', 'f8b6720a-2597-49e9-88d2-d90edc90abf4', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-12', '2025-12-12', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, '没ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f821b6c1-3d94-4295-9070-5dd275e387fe', 19, '548afe59-8b2c-4a77-b1d1-41b9bfd01aa1', '7c8936c4-331b-4c10-8baa-c19fed7a93b6', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-12', '2025-12-14', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2129cf2b-a468-4c15-b8ec-4a86c6c68aeb', 20, '89913fcd-96d6-4149-845c-71e68f13f3fa', 'd0f6d1f6-7bfc-4b78-a0c3-6e465771c925', NULL, '00000000-0000-0000-0000-000000000001', NULL, '2025-12-15', NULL, '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '81581676-9732-4846-9f7f-e2c0436fc004', 21, '6a2422a9-eafc-4743-a4d8-1b0d3e58309a', NULL, NULL, '00000000-0000-0000-0000-000000000001', '2025-12-12', '2025-12-15', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e29cae96-b861-4fd7-a960-23dfba5cd5d9', 22, '814da5f4-0ca6-43b2-8e6b-787ae1067afe', '76e004d2-6b41-40e3-80b6-2405657aed3e', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-12', '2025-12-15', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7adb4fe8-1d9d-4b44-9496-eabc89a4097e', 23, 'fdf00d6d-492e-4f30-9d96-91b1cda5d85a', 'e6923ab5-fa94-4876-b2ea-21d5e9f529cd', NULL, '00000000-0000-0000-0000-000000000001', '2025-12-18', '2025-12-18', NULL, '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'deb6adf7-f9ea-4dde-b9e9-e58d2564b24d', 24, 'cfdbe777-bfe7-4f76-b573-1c023f9b6b1c', '713b9867-3253-4e1e-bc39-717eeba1ba3d', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-19', '12:00:00', '確定アポ', '社長', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8948c2b0-1d0b-44e7-9b2c-45945b059c1d', 25, '0eaf1b81-9e9c-4d6d-a6f2-b04f2181d895', '71f782a4-f6f9-4b9e-830e-6ab8dc6b3ad1', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-19', '15:30:00', '確定アポ', '担当者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c4cfc72e-084d-4b0f-856d-296b3e923beb', 26, 'c415da63-75f3-49e6-8089-8d4d8a01cda0', '6067cb20-8a1f-4ae7-b559-bf75866dcac6', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-19', '14:00:00', '確定アポ', '担当者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'https://meet.google.com/cse-ekaj-eki', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd887d053-c0b6-4f85-88bb-13863bef4b6a', 27, '386985f2-6a44-4544-9c32-393e2e75a5ef', 'd580aa6f-f2ba-42f0-89f7-92b988cab969', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-19', '17:00:00', '確定アポ', '担当者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '02dcc27e-5a74-42c6-9216-851319f1ebfe', 28, '15e0d149-189e-44f5-9f49-ca2faf3a48c2', '25699791-0d8a-4091-b606-03d802d412dd', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-19', '2025-12-20', '10:00:00', '確定アポ', '担当者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'Googleミートで商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 29, 'a8307135-d901-4a3d-ae6f-ece5a49635f0', 'd08470e3-fc76-4d04-94f3-5339142cff09', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-19', '2025-12-21', '14:00:00', '確定アポ', '担当者', '6ff5a92a-a498-4000-842d-b7a9e338fac8', 'Zoomで商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 30, 'e443bd34-c1f6-47ff-a5ca-926f88f443b3', NULL, NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-22', '13:00:00', '確定アポ', '社長', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '116975e3-3771-4bb8-9923-6b58c93a2275', 31, '74695e1f-7661-4ff1-a884-d7606fcb0e9b', 'bf50c52a-69bc-4a5d-bd03-c2c0f25ace75', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-22', '15:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '17dc6b9c-1fbb-465a-b8f8-f2c13ca650c6', 32, 'ae726233-a0e9-4828-9086-fc6d2657da44', '2c267c6d-f16d-4b50-b501-e390720219ca', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-19', '2025-12-23', '10:00:00', '確定アポ', '担当者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'Googleミートで商談', NULL, '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'de54776b-5d21-4447-99a2-5a54413da0c7', 33, 'bc69ac02-70e7-4e97-af44-235ba9b62694', '1adb43e7-ca86-43e9-abca-2961c7d9ae92', NULL, '00000000-0000-0000-0000-000000000002', '2025-12-18', '2025-12-23', '11:00:00', '確定アポ', '社長', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bb1fd094-25b4-4e79-b334-730b85c5bbce', 34, 'fa3e75cd-5cac-4b18-97aa-ff12fd2b617a', '6eda228c-a5f0-4979-8c9e-08d249446689', '男', '00000000-0000-0000-0000-000000000003', '2025-12-18', '2025-12-25', '15:00:00', '確定アポ', '責任者', '3226c64a-c990-443b-8f8f-bba01b7f7ee7', 'リスケ 法人向けのタブレット端末を扱っている会社 新規は積極的に動いている状況', NULL, '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e8c833ba-6512-4959-9608-749bf8827a3e', 35, 'dadcb276-cdd1-44a2-a176-580b8b702c01', 'f8cc6ae1-a217-48ac-a783-28792eb5037b', '男', '00000000-0000-0000-0000-000000000003', '2025-12-18', '2025-12-22', '17:00:00', '確定アポ', '社長', '3226c64a-c990-443b-8f8f-bba01b7f7ee7', '隣のブースで逆営業していたところ、 結構強引に呼び止められて話をした。 先方は代理店を募集しているとのこと。 うちとしては自社のサービスを使ってほしいという趣旨は話をしたうえで、 入り口は違えど新規獲得に対するベクトルは同じなのであれば、 オンラインで話しましょうでアポとり', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '81bba897-128d-4521-a035-c5344804ca34', 36, '8ceed504-9116-4476-8b43-91f9c48b4414', '3ed378cb-934f-4dce-be0e-da2a2e122058', '男', '00000000-0000-0000-0000-000000000002', '2025-12-19', '2025-12-30', '12:00:00', '確定アポ', NULL, '59287d53-aa37-44a0-afe8-da83b5b62722', 'ズームで商談', NULL, '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8813cd54-e8d3-40f9-ae9f-255663b2d7cd', 37, '6e9ccf4c-e200-4390-b43a-d882f91903ed', '1f6b7247-415a-4879-beb9-a99d14af50a6', '男', '00000000-0000-0000-0000-000000000004', '2025-12-19', '2025-12-23', '14:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '732be7d8-f1a6-4d44-bf5a-cbb1bd9a58d5', 38, '8922b7bb-dcd9-4717-83f0-99df7167c0c6', '86d95a8e-95bf-455a-9263-8db3acfa0b71', '男', '00000000-0000-0000-0000-000000000004', '2025-12-19', '2025-12-23', '16:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b4d10e87-d777-49d6-969c-790a21a07811', 39, '588ef129-6056-44ca-a898-6cb2ccf7fc2b', 'e89ecc4c-3a23-4b9b-b757-b99821931f75', NULL, '00000000-0000-0000-0000-000000000004', '2025-12-19', '2026-01-08', '16:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談 営業代行に依頼した', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e76b76f6-5108-40d7-8323-cfe879b7aa7d', 40, '1a8466ae-81eb-49d2-a336-fd6817935038', '584b7c34-49cf-4e27-b3fb-55c66fde95ea', '男', '00000000-0000-0000-0000-000000000002', '2025-12-19', '2026-01-06', '13:00:00', '確定アポ', '社長', '59287d53-aa37-44a0-afe8-da83b5b62722', 'ランサーズシステムで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3533252d-29f0-4baf-9167-ee5ae2026d7d', 41, '0bb7d22a-a363-4be1-b95b-72e6c3ea6695', 'cd261b4c-fc7b-45ff-bd76-ac016272ada5', '男', '00000000-0000-0000-0000-000000000004', '2025-12-19', '2025-12-22', '10:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '269b919d-74f1-42e5-a947-cb2434986752', 42, 'b4812e76-9eb3-4950-a1c9-0c794e1d8c71', 'c29c3e5f-865f-494b-af19-563292dbd79f', '男', '00000000-0000-0000-0000-000000000004', '2025-12-19', '2025-12-22', '16:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOMで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, '没ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e2a6f247-f7a5-47db-9ddb-196f28ad83d9', 43, 'be369f39-588d-46ad-9ddc-c0145492b687', '3bcb0f00-73b2-43ea-bdab-0e1f5532a375', '男', '00000000-0000-0000-0000-000000000001', '2025-12-20', '2025-12-20', '13:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6dd4db2d-fb77-4e8c-8293-83ffc9669de3', 44, 'cfd7d762-80d8-4978-bad0-4cc5d8a3d319', '73c41cd8-34ff-40ba-8a43-dec41a9e54fb', NULL, 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-22', '2026-01-08', '14:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'https://us06web.zoom.us/j/81119460125?pwd=bQApwbZYJdkCtZtdKnw25Q2m3ELMKa.1 ミーティングID：811 1946 0125', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b661c2a7-483e-4319-9471-29dc22039748', 45, '04bb4f4a-c51b-47e7-bc4a-b84293e8014c', '66703471-c283-43c3-8d7f-3da1319ddbee', '男', '00000000-0000-0000-0000-000000000002', '2025-12-22', '2026-01-06', '15:00:00', '確定アポ', '責任者', '59287d53-aa37-44a0-afe8-da83b5b62722', 'カレンダーのGoogleミートで商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8950f2b3-9bb4-47bb-b38d-50adea492c37', 46, 'ab0d95b2-ca5c-4e95-99be-3afb57d09ac8', '207442ea-0bf2-4fb7-b8c9-b355dd8fb5bf', '男', '00000000-0000-0000-0000-000000000004', '2025-12-22', '2025-12-24', '15:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '443ca225-6fd7-42bc-8951-19e637046a6d', 47, 'cc549c61-4e03-46bd-b2ff-dd68364acb16', '918a5da7-b587-42bd-8563-52b015a0ac2d', '男', '00000000-0000-0000-0000-000000000004', '2025-12-22', '2026-01-08', '11:30:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOM商談　テレマーケティングに依頼した', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd7e6751b-fb43-4831-af78-6499e535b924', 48, 'd4bdc4b4-6ae8-46f6-8429-02a16cbfad96', '6bc47145-fd51-44df-b082-57e39860127e', NULL, '00000000-0000-0000-0000-000000000004', '2025-12-22', '2025-12-24', '10:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd9f4952a-f57b-45ff-beec-5b00a6554ed5', 49, '32d0e247-1dad-4be7-a0b6-4f7dbef9d4df', '1cc858a3-c379-4ba9-8be7-4823c5f641bb', '男', '00000000-0000-0000-0000-000000000004', '2025-12-22', '2025-12-25', '11:30:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7aa50ca9-64da-4f44-bbc9-25d5ae31359f', 50, 'df80682f-bf56-4398-a734-d98dacb7aaa5', '7f7c5d88-b949-49dc-a1d4-190fa815fac0', '男', '00000000-0000-0000-0000-000000000003', '2025-12-23', '2025-12-24', '14:00:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '先方指定URL https://us06web.zoom.us/j/89645178135?pwd=5ImwdfaUXvWbCNUcIYzhXaZf4USK45.1  ミーティングID： 896 4517 8135  パスワード： 936010', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c077da73-8cf0-4545-8764-9e4cc26a3be1', 51, '7edbccb8-b5a4-4729-a9fd-a7914bf4e752', 'b8cfa351-10e5-4c1f-b153-2ecca11c1ecf', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-23', '2025-12-26', '12:00:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b6922e5b-30ae-4793-b635-c728dd2a5313', 52, 'f8af44af-2d12-4528-9a25-434a3cceca3f', '3fd5929c-57cf-482c-9aad-c1f450598f89', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-23', '2025-12-26', '16:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '71acced8-a237-4dd7-b695-0a9c473b351f', 53, '3dad9c6a-2f34-411b-85bc-9a4f48280ec2', 'dacd4624-f5bf-4ef2-8f1a-f4a7dd52b76c', '男', '00000000-0000-0000-0000-000000000003', '2025-12-23', '2025-12-29', NULL, '確定アポ', '責任者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9b3686b6-868f-4716-914b-ba9af615f5e1', 54, '1b91dfff-d8bf-49c4-9a3f-73785d97f1e9', '94c4445a-bbc5-40ad-b75a-f58d6f328434', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-23', '2026-01-06', '11:00:00', '確定アポ', '責任者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c248e9e9-d7c3-4249-a0e6-4bd233042262', 55, '0074e7f5-996e-4f88-8b20-855f2175dc2d', '298a8725-7280-41e1-9e07-914f85ef31be', '男', '00000000-0000-0000-0000-000000000003', '2025-12-23', '2025-12-24', '17:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM面談 営業代行自体は現状やってはいないが、対応は内容次第で可能とのこと。', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bba4fc7f-c5b2-4f10-933d-b43c33012735', 56, '9d78f5fa-6df9-4960-a422-287bf766e515', '80655667-c842-494c-9cf8-ce2d0f1c922d', '男', '00000000-0000-0000-0000-000000000003', '2025-12-23', '2025-12-24', '12:00:00', '確定アポ', '責任者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談 執行役員', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, '没ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7e134af5-e971-4dfe-86e6-11e2ee8df2d2', 57, '54db912b-3096-455c-8d78-901d7cca8efa', 'a1d790c0-a4e8-4d4c-b624-94e89b19aaed', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-23', '2026-01-07', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4b215bd9-f08e-4dc4-9c0a-bc9597fdb08f', 58, 'e587d2e7-0e6b-4d47-9b2b-a00211d2f297', '1bce6ebc-a4f4-4b83-a53b-ea9ddc340134', '男', '00000000-0000-0000-0000-000000000004', '2025-12-23', '2026-01-09', '11:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談　テレアポ代行に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '05bbb46d-671b-4a84-ae4f-89b0334b15e8', 59, '0e94f29d-de26-411d-af49-9881c76abfcf', '16a62e4b-59c9-406d-a6d4-24ed8cc06ecc', '男', '00000000-0000-0000-0000-000000000003', '2025-12-23', '2026-01-05', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a7feda11-ee3c-461c-a1fd-8af7a293468b', 60, '9614ebb6-470e-4f4d-9958-8d9d8f5b7fe7', '1d92ae33-4e20-471c-975b-eae654c5634b', '男', '00000000-0000-0000-0000-000000000004', '2025-12-24', '2026-01-05', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '299a8b70-9a48-4bdb-a62f-78ca542a02ad', 61, '52e21fe6-6004-4200-a750-408b0dae8359', 'bfd2a469-7202-4048-8241-befaf324d05c', '男', '00000000-0000-0000-0000-000000000004', '2025-12-24', '2026-01-08', '10:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業支援に依頼', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aa58afba-21e6-48ee-a24f-7611570df392', 62, 'f77b1320-dec7-4345-8568-237e16a5c420', '984af6a1-9884-48b5-a524-94d5de4a34b7', '男', '00000000-0000-0000-0000-000000000004', '2025-12-25', '2026-01-14', '14:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談　アウトバンド依頼', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '732cc931-e72d-446a-8c72-45b16e2fbebc', 63, 'abcdc170-42bc-44ba-b5bf-5b953136261f', 'e4a7b5b4-9577-4d48-ba1b-8919f5f6a733', '男', '00000000-0000-0000-0000-000000000003', '2025-12-25', '2026-01-08', '16:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '65d58446-e7bc-4564-bc8a-dc8a9b01a789', 64, '4bb991f0-0f29-45d6-80ba-390626497980', '880d5412-b71c-4d2a-9a29-75b840f5b626', '男', '00000000-0000-0000-0000-000000000003', '2025-12-25', '2026-01-14', '09:30:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '先方指定URL 秘書の南さんのアドレスを通してやり取りしたいと。 ※南さん、仕事できるタイプではないため社長の連絡先聞き出した方がいいです。', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b71c9747-1201-421e-99ce-34fdddc7d56c', 65, '329a0d00-ac37-4a9f-a348-e29dc74a7487', 'c2da1417-4638-4820-bfc0-06c8c41f7f9e', '男', '00000000-0000-0000-0000-000000000004', '2025-12-25', '2026-01-13', '16:00:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談営業代行に依頼', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, '没ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6bcf144b-c8f6-45c6-9a0d-7efdac0cb406', 66, 'f8ee3afb-ea69-4836-9665-15ae52972908', 'e2519ff0-e7db-43e0-961c-e4abbe5a2bfe', '女', '00000000-0000-0000-0000-000000000004', '2025-12-25', '2026-01-05', '12:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7c63c08f-2d75-4e07-8cb9-27a51a17b0b6', 67, '479e1b92-4c22-4fc4-b252-1116d7927314', 'fd8c5054-e8c7-47e9-95f5-f7f1be8bb67f', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-26', '2026-01-05', '16:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談', NULL, '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '660d01f3-1871-4b97-b157-5932556eb1b3', 68, '7661bb47-c6eb-4689-9b6b-d448ac9a414f', 'fda07fb5-0cf3-46ee-851f-ee6ebe92fce5', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2025-12-26', '2026-01-08', '11:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '93a9a58c-c95c-44a7-a3d8-0e6117174628', 69, '73684d1b-a872-4710-b038-91b625fd87d5', '2ef82757-3994-494d-ab2d-bc5cc8063984', '男', '00000000-0000-0000-0000-000000000003', '2025-12-26', '2026-01-09', NULL, '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5b2bdf8f-1896-4149-88a0-097d007b1d67', 70, 'd4bdc4b4-6ae8-46f6-8429-02a16cbfad96', '6bc47145-fd51-44df-b082-57e39860127e', '女', '00000000-0000-0000-0000-000000000003', '2025-12-26', '2026-01-09', '09:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd6c87b8b-6705-4667-872b-6f9d48aa563e', 71, '3b521799-45e4-4b2f-87d3-81757d3f808f', '54a35de2-44bb-4d5a-bf64-196c0fa0d19d', '男', '00000000-0000-0000-0000-000000000004', '2025-12-26', '2026-01-09', '17:00:00', '確定アポ', NULL, '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談 https://us02web.zoom.us/j/5683839162', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '11d7370f-adaa-4ea9-b434-bd3e416b8a32', 72, 'bb93a1db-33c3-46dd-bf69-7fb1ff320ca2', '99fed154-b1bd-403c-9178-72fa8e1c2126', '男', '00000000-0000-0000-0000-000000000003', '2025-12-26', '2026-01-05', '17:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '先方指定URL', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3ffb34d6-5584-46c6-be6b-9c3d78a6113b', 73, '2ab190c3-c72d-475a-ac7b-ab16bcdd6dd2', '918dbca1-ed90-40ee-a9e9-02c1090f7779', '男', '00000000-0000-0000-0000-000000000003', '2025-12-26', '2026-01-07', '09:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd5907947-bfb1-4977-bc64-fded73501887', 74, '6889860f-4956-45de-8983-6e75493ed533', '54d14955-5bfc-4f47-835d-aef894ca958c', '女', '00000000-0000-0000-0000-000000000004', '2025-12-26', '2026-01-13', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談　コンタクトセンターに依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4e08c677-7873-495d-b05d-eeda60cb7a21', 75, '92fe94d7-eacc-426b-8ed4-11c898aea788', '19b21760-fddd-41e3-91fe-7518e6466377', '男', '00000000-0000-0000-0000-000000000004', '2025-12-26', '2026-01-13', '15:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談アポイント獲得支援', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '559dba91-ab79-48d9-920b-b06ccbdb1a62', 76, '20e5a86d-f768-4395-ae62-8055a78c1b78', '6f0ec6c7-af11-4a95-adc9-709fd5a36a62', NULL, '00000000-0000-0000-0000-000000000004', '2025-12-26', '2026-01-13', '16:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM商談　コンタクトセンターに依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c48e8000-7c55-4643-85f6-a05fd0c129e2', 77, '2df9a3dc-1fb1-4ede-99e0-40dea98ac764', 'acd5d64b-be6a-44c7-a4ec-39d3f0b844d9', '男', '00000000-0000-0000-0000-000000000001', '2025-12-29', '2025-12-29', '11:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b22a02fd-767d-4e8d-8206-d76c608b1f32', 78, 'eed3c4e4-715a-4172-9a24-e4207b3dfa3a', '011aa93a-aa12-4e71-8491-9a8d23e345b4', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-05', '2026-01-15', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '530227bd-de19-4544-b688-9fa64d353473', 79, 'b78a74e6-da90-4276-9c30-d7c839bd19ff', '4e24bda3-10d9-4fa6-a8e5-b4b657b14dbd', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-05', '2026-01-16', '16:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3aeba8df-a127-4cf0-a6bc-2b180eb6b282', 80, '72432d0e-2231-4f65-8902-7fe11e146329', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-05', '2026-01-05', NULL, '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1b089a8e-1c09-4d41-9c8d-1dbd700bbd9d', 81, 'ab96240f-7409-423d-b6c2-bbc3426052e3', 'f8007f41-0272-4b77-8857-5daedfec8308', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-05', '2026-01-09', '14:30:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom   代表の方がとても話しやすい人心良くアポも取ってくれた', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '00ea8828-3ecc-49ae-aa3b-7a5d52c70899', 82, '25f6472e-eb78-4cb4-ba67-8d31069708a8', '384fec56-cb05-4361-8c24-1d82d828c8cc', '女', '00000000-0000-0000-0000-000000000004', '2026-01-05', '2026-01-13', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'ZOOM 先方が取り扱ったことがない商材といっていた', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ab3c07e1-f3ff-40a3-bb1b-44badec8dbbc', 83, '7767af12-63ce-4e06-a2f3-9ed14dfe4544', 'b2463ceb-54e0-401c-833d-9e1219148d75', NULL, '00000000-0000-0000-0000-000000000002', '2026-01-05', '2026-01-09', '13:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '先方指定のGoogleミート', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '40ef11d3-3d54-41f8-8f90-4c783dea0cd5', 84, '642e17c6-f484-4323-840e-f5bda332870d', 'baffffa7-6277-43e7-9f12-73c4e871acb7', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-05', '2026-01-09', '10:00:00', '確定アポ', '社長', '59287d53-aa37-44a0-afe8-da83b5b62722', 'zoom https://socialsolution.jp/', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f7ea5181-758a-4c8f-a2dc-379f8b666bc5', 85, '2bead48e-fe88-4b6b-8b25-ccf107a5064b', '6695d7e5-058b-40af-9b3b-d5f93bdcde28', '女', '00000000-0000-0000-0000-000000000004', '2025-12-18', '2026-01-06', '11:30:00', '確定アポ', '担当者', '3226c64a-c990-443b-8f8f-bba01b7f7ee7', '新規開拓で困っている', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9d259f8c-dc45-4e0f-8023-8961c1f1c3ec', 86, '108df061-8f6f-4b8b-bcc9-bfaf9ae85bb7', 'eadf6c18-b057-40b0-a9f5-fd5040f9b566', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-06', '2026-01-15', '12:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談', NULL, '00000000-0000-0000-0000-000000000001', '消滅', NULL, '消滅', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0005cfea-869e-4222-b097-32ad489e5ad2', 87, '293b3173-a1b5-4cec-880a-d9fcf352ed80', 'd68e6ece-cc6e-4273-b410-f9295d434480', NULL, '00000000-0000-0000-0000-000000000004', '2026-01-06', '2026-01-09', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業支援', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '023aa5a7-76bc-4730-a1ad-5e9bd43b61be', 88, 'fd0a1f9e-7068-426b-a33c-0450d68a4281', 'edb55e7d-04db-4873-a1f1-65097099ebd2', '男', '00000000-0000-0000-0000-000000000004', '2026-01-06', '2026-01-13', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業支援', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b9f55d83-2b60-4477-903d-de045d72d7c0', 89, '60ad7b6b-f4c0-4602-b8b5-64223f105608', '92b61765-d8e7-4f1b-a0df-115b0e74c8ac', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-06', '2026-01-10', '10:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bcb25048-f130-40a2-8aa0-1e2d30686970', 90, 'eb814b26-1221-4b8d-a366-cad035615250', 'b8793ad9-e32f-4105-a1a2-a12b57684ac1', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-07', '2026-01-11', '11:30:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom営業代行はまだ新規で行っている快くアポも取れた', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '26005779-2f93-48a3-97ff-5cfc6a67af05', 91, 'dfe8773b-fa98-40dd-b71f-c198c29306ad', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-07', '2026-01-07', '10:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '35843818-1bf1-4ca4-8074-b8f5fdee42a0', 92, '0b019907-9c25-48f8-8dd4-a1c7879ba123', 'd14aab20-92e3-473e-adfe-7721edb41b80', '男', '00000000-0000-0000-0000-000000000004', '2026-01-07', '2026-01-08', '17:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業支援テレマーケティングに依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5dc932f2-a4c4-4cbc-b1fd-6dcb2cc29b1c', 93, '2f04e3ea-201a-4638-91c6-2b7b70338576', 'd05c2e3b-6a6a-4a81-ab4c-9f9f55ba8aad', '男', '00000000-0000-0000-0000-000000000004', '2026-01-07', '2026-01-13', '10:00:00', '確定アポ', '担当者', 'b3a27267-826b-4438-a8f9-9841ddacc3a2', 'インサイドセールスアウトソーシング事業のテレアポ代行に依頼 https://baseconnect.in/companies/2fdd796d-ecd4-4b9d-af87-3ee31e572ae3', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'cf1db981-5633-4bb0-b3f7-d748799f7963', 94, '088d9ab5-0584-4453-b7e1-349b13157556', '4d6f5c66-1d1a-4485-8285-752a43bc3fd2', '男', '00000000-0000-0000-0000-000000000004', '2026-01-07', '2026-01-15', '17:00:00', '確定アポ', '担当者', 'b3a27267-826b-4438-a8f9-9841ddacc3a2', '営業支援に依頼 https://baseconnect.in/companies/95997c7c-e333-4daf-902f-6329534d9fa9', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8f55303e-a14a-4340-9a4d-1ec50747cff2', 95, 'c8b55e1d-23a9-4e6e-9b40-28f8fd867fd5', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-07', '2026-01-08', '17:00:00', '確定アポ', '担当者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, '没ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ad86d716-0e43-442b-b865-b3e3d0027a26', 96, '778e7c70-b350-4330-921e-3d05519d6c00', '201c337e-d1ec-4eb5-bfd8-c908697eea15', '男', '00000000-0000-0000-0000-000000000001', '2026-01-09', '2026-01-09', '09:30:00', '確定アポ', '責任者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0c446d2b-8a24-48ab-be97-d4d550e9ec1a', 97, 'c69e2541-3d69-4bbc-8f71-b32030efdbb8', 'f3e96684-0dc1-4a1d-b023-e120e503695a', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-09', '2026-01-15', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談テレアポの営業代行を行ってほしいと依頼した', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a9e970ea-d966-4b05-8c71-814515521720', 98, 'a309100e-f6a6-4863-8038-a2e3f27860ae', '57b7faef-812f-4daf-b9ca-d76b009de67e', NULL, '00000000-0000-0000-0000-000000000004', '2026-01-08', '2026-01-16', '17:00:00', '確定アポ', '責任者', 'b3a27267-826b-4438-a8f9-9841ddacc3a2', 'SALES レップに依頼（営業代行）', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '72577c4c-f884-4231-8d30-935cd730ae39', 99, '189ffda4-5029-45fc-b2f4-057e673ab4bd', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, '2026-01-10', NULL, '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 100, '45ad2dc7-cf01-40ef-b56c-7013cfd5e33f', '872ff165-5b39-4450-8892-8f81aafdff6a', '女', '00000000-0000-0000-0000-000000000001', '2026-01-11', '2026-01-11', '09:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ab7045d8-d837-408a-8bcc-6a3f19582b93', 101, 'fb23ab20-c724-4c59-9f79-94cc37a343c8', '5b4a56fa-c45a-46a2-9ff5-019fd043c9e1', '男', '00000000-0000-0000-0000-000000000001', '2026-01-12', '2026-01-12', '10:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f868a6ce-15c8-4b36-bc1d-52b0aed9307f', 102, 'c420c14a-e199-4717-b626-652add7536b7', '1b9daad6-7e73-494e-96eb-51fae3b1aaac', '男', '00000000-0000-0000-0000-000000000001', '2026-01-12', '2026-01-12', '18:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7c93aa3b-e78b-4f48-8a48-b8f1759a9741', 103, '171ccf99-77f6-4cd8-a049-66279e3e2b75', 'b2698588-7380-4547-99d5-221cb1ceb475', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-13', '2026-01-15', '10:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'zoom商談営業代行の依頼と伝えた。', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f2a96302-83d9-4ce2-851c-f102a37f840f', 104, '9fb4ba49-49f4-4b26-bf32-282a797f33f2', '2ef45007-f954-4c60-849b-f2b94b955ad1', '男', '00000000-0000-0000-0000-000000000004', '2026-01-13', '2026-01-16', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポとして依頼中', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '01286b99-5c07-46e6-a3c6-5ca7c60a95ef', 105, '29debf76-11dc-4b43-9eae-de5d55d43d00', 'a69dc9e0-f6fa-40f8-8712-1114dbb5fe60', '男', '00000000-0000-0000-0000-000000000004', '2026-01-13', '2026-01-16', '15:00:00', '確定アポ', '担当者', 'b3a27267-826b-4438-a8f9-9841ddacc3a2', 'テレアポとして依頼中', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '27534f75-6491-48ea-8c57-87f489d56a7d', 106, '3b3cb6c4-081f-47d1-862e-7377db7511e1', '0a18cc18-c548-4ddf-9c5a-128508505521', '男', '00000000-0000-0000-0000-000000000004', '2026-01-14', '2026-01-20', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼。', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fb8e19ac-26ff-4c60-b9d2-dbc28785d11a', 107, '86a0b83b-920c-4b2e-a713-a1555f3d64cc', '9cfeb27d-5bea-4d26-9f70-e7e1c36869af', '男', '00000000-0000-0000-0000-000000000004', '2026-01-14', '2026-01-20', '16:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼。', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '85b8f582-3eb2-4321-956f-82b49a8d8719', 108, '49fe0148-7c9e-4b31-8486-7457bdbd38f9', '93bf299f-906b-491a-8acc-30336e96dc92', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-14', '2026-01-20', '11:30:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポの営業代行としての依頼　テレアポの実績があまりないらしくそれでも代行大丈夫かといわれた。なので、今後テレアポに力を入れる予定があれば導入もしやすいと思う。', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c635f076-4599-40ae-89e1-71f2297bb3ee', 109, '48293833-c5a9-419a-85da-4b8aae66563f', '5ce0bf0a-9ad1-405f-904a-c4fb3f80169c', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-14', '2026-01-20', '10:30:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼。', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eb390cd1-9d32-4981-b445-70776e756601', 110, 'f8d8187f-8bea-49a5-bca2-40f769cd5b7d', '456d6849-1237-4582-a766-fad5234f577d', NULL, '00000000-0000-0000-0000-000000000001', NULL, '2026-01-14', NULL, NULL, NULL, NULL, NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '158320b7-b8c5-4049-8431-6a53e3340865', 111, 'd5e2f9e7-2e1a-487b-86e9-9decef79feb4', 'faf88dcb-6ce8-4f98-959a-6b7549b721fa', NULL, '00000000-0000-0000-0000-000000000001', NULL, '2026-01-14', NULL, NULL, NULL, NULL, NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '61394ced-2bcd-4fcd-b32e-9a7f99675c80', 112, '48e4311d-f89c-43fd-a539-d5843e5f0599', '7220fa84-2f6b-4575-956b-d90e9b86d3e3', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-14', '2026-01-20', '15:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '156617b4-11af-48b0-a1a8-ea257a5fa7ae', 113, '3f0f9b18-6d87-4be8-84e3-505c48e9408f', '4918e599-b4e0-4eb2-b557-0518b0219eed', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-15', '2026-01-20', '16:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3e804e4d-ca31-4ffb-8119-753195d80d48', 114, '7a517b28-5c84-4882-aa1a-2f686458a484', '7887ce1b-3f3d-4c02-952d-2a8fb495f782', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-15', '2026-01-19', '11:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行として依頼 電話口は受付の高田様 メールは高田様あてに送る。 当日は滝本様と谷川様が出席', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'cb116054-51d0-4304-8810-b958eae85b90', 115, '44c00561-a31b-499b-885b-caa89a31e001', '782b067e-e934-43c8-9376-0d1d59de3b85', '男', '00000000-0000-0000-0000-000000000001', '2026-01-15', '2026-01-15', '10:00:00', '確定アポ', '社長', '2fb53ab5-b677-4fab-969c-78048e30311a', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0343c25d-a8fe-4395-a20b-58d4731de036', 116, '3c56a85a-4841-4810-af53-41d3e4a70088', '308c6d91-df62-4dbf-a1d4-42938ce02e48', '男', '00000000-0000-0000-0000-000000000004', '2026-01-15', '2026-01-21', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポ代行に依頼', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5d27bba1-5da5-4d1f-90bd-feaaff2812d6', 117, '9af5f51f-954e-4242-b330-72c12e788c84', '1a6a9203-56a1-44d6-9e43-f1323862a7b7', '女', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-15', '2026-01-21', '10:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '営業代行としての依頼', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1cc728b4-df6c-43f2-adbb-1ae742ff18f3', 118, '29ca7b2d-e354-4176-aed2-c643ba9d8338', '2a5ef72a-bc1a-4850-a75e-b49e407eba3f', '男', '00000000-0000-0000-0000-000000000004', '2026-01-16', '2026-01-22', '16:00:00', '確定アポ', '担当者', 'b3a27267-826b-4438-a8f9-9841ddacc3a2', 'テレアポ業務に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '71d8355c-5120-4d32-802b-d9a6931a9eb5', 119, '6673e382-9192-4ba5-95f3-fff0077796b5', '32d5e6ed-4738-4fc9-8c18-f729d6b024a7', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-16', '2026-01-22', '11:30:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポ代行として依頼', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fd7de116-551c-49d0-ae71-a587ddc29bf6', 120, 'e04f60a1-ab76-40d1-ad89-b08a1e00c1be', '0c72841e-75fb-4b3a-9705-5f5f18aefaee', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-16', '2026-01-26', '17:00:00', '確定アポ', '責任者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポとして依頼 相手は成果報酬は単価次第と言っていた。 アポ取りだけでもいいのかなども気になっていた。', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fff83ff8-f1ee-46cf-b8f4-53adbb4b2eeb', 121, '128ca6c2-97f5-4509-aa3b-83153664e7af', '84504b1c-6377-4a0b-83e5-4d17c9d84efb', '男', '00000000-0000-0000-0000-000000000001', '2026-01-16', '2026-01-16', '14:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fca90ea1-3831-46d9-ac86-d9034a2e6fed', 122, 'c706d29c-4fb3-4e1d-88c1-9338661f2d54', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-16', '2026-01-16', '14:30:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a35143fd-368c-425c-9cdd-7528d69de593', 123, 'b4dee83f-9512-47d7-b955-82957fdd71b7', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-16', '2026-01-16', '15:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '398dbfee-8993-47d3-a89c-36b6d831562d', 124, '1514158c-61e8-4ca7-b72a-90f1a7e0c225', 'e68530ea-d5b4-46d7-a3ab-b882e8e787bc', '男', '00000000-0000-0000-0000-000000000001', '2026-01-17', '2026-01-17', '13:00:00', '確定アポ', '社長', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '687ffa82-e90d-451a-b259-a275f8b02244', 125, 'b1afce4e-5840-4d49-88fd-b9389fe0f95d', '4278f7d3-c61c-449c-ade4-3cfc9d9c2c1f', '男', '00000000-0000-0000-0000-000000000004', '2026-01-19', '2026-01-22', '14:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業支援に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a2a68839-68e6-451a-a834-903ac1e3d734', 126, 'c1af7970-c582-4238-98ab-dbd2ca2b6840', '5ed80320-3b10-43c7-9f0e-319c7d9ef6af', '男', '00000000-0000-0000-0000-000000000004', '2026-01-19', '2026-01-21', '10:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行に依頼', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '033730d5-1035-43a5-8e25-cba5c129d34a', 127, '566eefe1-bc17-4390-a897-420911a6355f', 'f5f089c1-d5d6-476e-9aaa-61d07d80baa3', '男', '00000000-0000-0000-0000-000000000004', '2026-01-19', '2026-01-23', '16:00:00', '確定アポ', '担当者', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業支援に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ca4975b0-464c-4e22-8ab9-8aa92d5d56ab', 128, '53f1f6e8-7e9b-488f-ab55-2e03e75c908d', '77fb2158-9833-41b9-aeef-e5cd1554a2e6', '女', '00000000-0000-0000-0000-000000000004', '2026-01-19', '2026-01-23', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', 'テレアポ代行に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '75ee345f-8fd0-4332-b5e8-d63512a41756', 129, '6a7ee605-cf6f-4585-9acb-c1b1d308cedc', '982d6f9f-3403-49ba-90d3-1a48ee1b099d', '男', '00000000-0000-0000-0000-000000000004', '2026-01-19', '2026-01-23', '15:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5caa33d1-615d-451c-bbaf-620a88eb4271', 130, '63395cb3-970a-4668-8263-872250a435c5', '9bb07076-6e28-47c0-a619-f2575d017019', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-01-19', '2026-01-26', '14:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行として依頼', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c9b7b7c0-fa51-45fb-aedd-3677cd487e08', 131, 'da5dee56-61b4-42e3-886b-d9325987d9ff', NULL, '男', '00000000-0000-0000-0000-000000000001', '2026-01-19', '2026-01-19', '10:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0ec47f76-f9af-48a7-9f4c-64e9fa66a63f', 132, 'f3a033cb-f107-48e8-88d1-1ed334c6d247', 'dc6828d5-5a8a-461b-b065-b0727acae01d', NULL, '00000000-0000-0000-0000-000000000001', NULL, '2026-01-19', NULL, NULL, NULL, '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd66f34b0-adce-407e-b933-51f2a0be7ee4', 133, 'd40c5164-1e62-4398-b518-7adc32d85157', 'b4c8631e-aca5-4e2d-8b82-2810808db36b', '女', '63a55be1-0fca-459f-8335-8c800019c678', '2026-01-19', '2026-01-22', '15:00:00', '確定アポ', '担当者', NULL, '営業代行として依頼', NULL, '00000000-0000-0000-0000-000000000002', '消滅', NULL, '消滅', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c53e1742-cf7c-4420-a8d8-49e3501d2bde', 134, 'e54e5971-a6e5-4e97-bedc-c72215567397', 'bde31958-5f66-4c52-a4eb-2d2da166a8ac', '男', '00000000-0000-0000-0000-000000000004', '2026-01-20', '2026-01-23', '11:00:00', '確定アポ', '担当者', 'e5569260-1dd8-44ee-9acf-4427754f638a', 'テレアポとして依頼 金額面、依頼開始日など検討中と伝えた。商談の時は弊社側が提案する形で話したいと伝えた', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '166946c2-f594-4133-b2ce-09f3134d7560', 135, '30bdd6d0-a7b3-4cf9-a120-e5373030e7bf', '3c9d2a93-5e46-4d6f-8285-3ad06376a20d', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-20', '2026-01-26', '15:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', 'テレアポの営業代行として依頼 当日は、代表の中武様と担当の岩崎様が出席', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '91c5fce8-af14-41f1-893a-78176e22973d', 136, 'ba33d29a-ac87-48cb-8c4a-cba80ebe9a6b', NULL, '男', '00000000-0000-0000-0000-000000000001', NULL, '2026-01-20', NULL, NULL, NULL, '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8536cdff-d298-46a4-9e4f-c6dd83878b6a', 137, 'ed7c261e-1702-4340-8874-491968c4bbea', '3573445e-f480-468a-8f23-ebf0d4699053', '男', '00000000-0000-0000-0000-000000000004', '2026-01-20', '2026-01-23', '10:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業支援として依頼', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fd2c5b5d-3e34-425c-8db9-920a2127784b', 138, '713b75bc-9794-44c8-9694-023345629854', 'af384902-ac11-4125-955a-e64c0c3bd9cd', NULL, '00000000-0000-0000-0000-000000000004', '2026-01-21', '2026-01-22', '15:00:00', '確定アポ', NULL, 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業奉仕に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e1eb6322-66b1-437a-aa3f-4945318f01b8', 139, 'ef3c4fb3-d63b-49f9-a36f-3b2cc3461bfc', '0582d6f0-5a76-4c73-9b23-9a0610a7f413', NULL, '00000000-0000-0000-0000-000000000001', '2026-01-21', '2026-01-21', '09:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '66b97efe-28d2-47b6-9d7f-8e3b9878812f', 140, '90b1c44d-3759-45a2-8753-bc27ef6206ad', 'c899596a-bcd1-4c4e-8fe2-5ef884262218', '男', '00000000-0000-0000-0000-000000000004', '2026-01-22', '2026-01-23', '17:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行に依頼。商談URLは、連絡待ち', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '220385f5-0dce-4cc9-915b-32b90ae261c4', 141, '875e84ae-5263-488b-b3a8-e34d98558cb3', '83ac44f0-9f0e-4356-a211-d249be3d9ab6', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-01-22', '2026-01-27', '14:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行として依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ef6b7555-ef89-433c-b159-09ad802876b8', 142, 'c839d09a-d14f-4d99-b81e-0994c348e5f6', 'e1e50dab-7150-4f7a-b4f4-a0f556d04e4a', '男', '00000000-0000-0000-0000-000000000001', '2026-01-22', '2026-01-22', '13:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9cd20791-276a-402c-bfa5-9bd73822a0f0', 143, 'c261fd0f-effe-4483-99d9-e2284934bd5b', '87ab2ff3-8804-4f30-ae71-36e2e8040dd4', '男', '00000000-0000-0000-0000-000000000004', '2026-01-22', '2026-01-27', '11:00:00', '確定アポ', '社長', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行アウトソーシングに依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c05b26b5-22b2-4b97-a0be-435bc4f893c3', 144, '71b4d34e-8ae3-4dd6-b216-6f17a6f37911', '08601caf-7118-49e2-ac3a-a28517e576ec', '男', '00000000-0000-0000-0000-000000000001', '2026-01-22', '2026-01-22', '12:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8e843d6f-687d-493e-aada-39012b716603', 145, '7ca76830-7fce-4422-9a14-da8c151e7ee7', '2173da47-0af9-49a7-8a49-0948165b10b1', '男', '00000000-0000-0000-0000-000000000001', '2026-01-22', '2026-01-22', '11:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b4979004-7539-431a-bbdb-a23bc9342ccd', 146, '04fea7be-b951-4f48-a263-8d03937820df', 'ceed3bb8-2a18-4de8-a764-ce4fd514d34c', '男', '00000000-0000-0000-0000-000000000004', '2026-01-22', '2026-01-27', '15:00:00', '確定アポ', '担当者', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行に依頼', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '57a8b144-edf1-4656-b91f-9828909f5f4d', 147, '1c166e6b-bb74-46d1-b90b-76930ef699ea', '138976d7-7e3a-45d7-8885-e2c0476e37b8', '男', '00000000-0000-0000-0000-000000000001', '2026-01-23', '2026-01-23', '12:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '942f2098-9c1e-4f1e-8beb-bf2e3b735609', 148, 'b9a2a816-7849-4951-a873-2e28a5de73e2', 'd9a392f8-2a18-41f4-a1d9-f6d675a390ce', '男', '00000000-0000-0000-0000-000000000001', '2026-01-23', '2026-01-23', '12:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'efd867f2-5870-41de-a07c-fe7b6426cf58', 149, 'e78a2fa9-0453-4699-86a2-f7b66fabd416', '668bd3ae-6e37-4bae-934e-34f061e3be8a', '男', '00000000-0000-0000-0000-000000000001', '2026-01-24', '2026-01-24', '12:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a32f35d8-7240-4ffe-8fe3-f3138afbc369', 150, '9a668991-3ae5-4a28-a78f-ab7ff34cb12f', 'e3671aa8-9a0d-4668-999e-ce39c16ea211', '女', '00000000-0000-0000-0000-000000000001', '2026-01-24', '2026-01-24', '10:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1e0a6ee8-dfda-4839-944e-45bfcc03be2f', 151, 'ca0fbc43-1634-401a-a43d-acf3a5f9c4a9', 'ae8adda3-1c51-47f6-ad56-3911ff3d55c3', '男', '00000000-0000-0000-0000-000000000001', '2026-01-26', '2026-01-26', '11:30:00', '確定アポ', '責任者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '841d5fef-47a6-45be-8fd7-5107b2c830a4', 152, 'dce81887-8f73-4523-8df0-bb9a2a6ce492', '3f4e3437-7bc7-46d9-8bea-39e8592fa014', '男', '00000000-0000-0000-0000-000000000002', '2026-01-23', '2026-01-26', '11:00:00', '確定アポ', '社長', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', NULL, NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4411209e-83cd-4210-a7b9-3b657b8909e9', 153, 'cf91516e-6f17-407a-b57e-53ce21df3790', '44d94451-6801-4c60-bf45-7d9d07763d84', '男', '00000000-0000-0000-0000-000000000001', '2026-01-26', '2026-01-26', '12:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '380d5f3f-ac07-48f0-9453-7c036cb53920', 154, '647c40b2-833d-43a9-b8c8-e92c82a6065e', '73a5bbba-1c1b-4040-b4b7-2e0f9cb151d7', '男', '00000000-0000-0000-0000-000000000001', '2026-01-26', '2026-01-26', '09:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '673fd53d-bb4b-4949-9e4a-d895d2e6c46f', 155, 'd2411421-153f-4f6c-85b2-4946ab7a6ea9', '8fb5e9a9-bb98-490c-be04-9411ea4af446', '男', '00000000-0000-0000-0000-000000000001', '2026-01-27', '2026-01-27', '10:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c4e1c135-5658-4078-bf69-693f3a80eb73', 156, 'aa43c2e3-a647-440a-8e19-31fac25bc4ff', 'c2f0adc8-af10-41a8-be20-5d0cbbd387aa', '男', '00000000-0000-0000-0000-000000000001', '2026-01-28', '2026-01-28', '10:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '77e2bbec-2805-4282-b98e-c58355e5a2cd', 157, 'd370fcf4-ad95-4143-b3d9-09215f88853c', '76ae0e46-5fae-4ef0-938f-3b201768255f', '男', '00000000-0000-0000-0000-000000000001', '2026-01-28', '2026-01-28', '09:30:00', '確定アポ', '社長', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2d2890a1-5fbd-4b3c-b17c-623f843ac1d6', 158, '75581949-d765-4635-bb60-0f6adfa4e89d', 'cd9ee689-6ac7-42ef-9976-5434ee43c26c', '男', 'b313633e-4001-4c13-9a93-de2b0b1971a0', '2026-01-28', '2026-02-05', '14:00:00', '確定アポ', '担当者', 'e5569260-1dd8-44ee-9acf-4427754f638a', '営業代行として依頼', NULL, NULL, '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6f1ab8ed-10c1-4c00-8d4e-86305cbf688d', 159, '05a6a5a3-ebd9-4574-99fb-29bdd7f09dc5', '5b5fc9dd-410d-4ebc-97f5-47f98b6773b6', '男', '00000000-0000-0000-0000-000000000001', '2026-01-29', '2026-01-29', '09:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4a024c8b-b4d4-4b29-992b-2375abced66f', 160, '9d435765-f751-442d-8470-6e711fee6c42', 'c5215202-8a52-4d30-9eac-a49a3e0c5a4f', '男', '00000000-0000-0000-0000-000000000001', '2026-01-29', '2026-01-29', '10:00:00', '確定アポ', '社長', 'e8cc8cf4-9c74-49ae-bc5f-675b3eb5bc05', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '41d414f6-fa18-43da-8e73-a84040ad0bcd', 161, '6a04eb32-9802-4c41-b74c-fa38c877edc7', 'ee07da5c-d4ab-452b-9da9-540047919a0a', '男', '00000000-0000-0000-0000-000000000001', '2026-01-29', '2026-01-29', '09:30:00', '確定アポ', '社長', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'cca6deda-13f9-4321-8d00-45f4bd4486e3', 162, 'a57d82c0-7203-47d4-bce2-052e4b1889ed', '5932002c-a8c9-4c02-83bf-2aa94ddbe866', '女', '00000000-0000-0000-0000-000000000002', '2026-01-30', '2026-02-05', '15:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6a8a0994-5c2e-481c-b26e-91592e1fdbda', 163, '57f29818-def9-46fd-8081-2860de4b6827', 'a9f79931-0ed1-42aa-9580-78f7816ae0a5', '男', '00000000-0000-0000-0000-000000000002', '2026-01-30', '2026-02-02', '17:30:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 採用担当　すんなり取れた', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '59197a3d-1ad2-4c56-b65c-e19d99fbf94e', 164, '2afdf017-d683-42d0-ad2b-ab3c93c95b37', 'b05221b6-96fc-4a68-8871-46dc3f54206c', '男', '00000000-0000-0000-0000-000000000002', '2026-02-02', '2026-02-06', '14:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 サーカス契約中　https://service.circus-group.jp/circus/foragent/  手数料27％と伝えると　めっちゃ安いねと 愛知県も可能かと→可能と伝えた', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '63caafbd-68ca-4bf5-9c76-9e9e7048fdf1', 165, 'f6ffc200-e0c7-414b-b94f-12350504bf82', '6750cfc8-d699-46a9-a163-b0553f1e749f', '男', '00000000-0000-0000-0000-000000000002', '2026-02-02', '2026-02-03', '14:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 手数料伝え済み', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '448a5ae0-f175-4de6-8f15-ba23b8121670', 166, 'a0375b23-c9f6-4641-bb5b-5bef4b6d4855', '21f67ec0-b02c-468b-af9a-edacddc5395c', '男', '00000000-0000-0000-0000-000000000001', '2026-02-02', '2026-02-02', '09:00:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '62e88798-4435-43b2-9c64-4d077dfa3ab7', 167, 'a1a0d541-0874-4b46-9449-1aa1b15998d5', 'db7c39bb-6012-4e73-8c43-544a309a337c', '男', '00000000-0000-0000-0000-000000000001', '2026-02-02', '2026-02-02', '09:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f96634b2-b031-4731-b77c-40feb6df8310', 168, '456d3daa-b090-43fd-a07b-1cbe633893d2', '3867d480-61f8-4179-9c8f-b9724880efdc', '男', '00000000-0000-0000-0000-000000000001', '2026-02-02', '2026-02-02', '09:00:00', '確定アポ', '社長', 'e8cc8cf4-9c74-49ae-bc5f-675b3eb5bc05', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6829d74e-19e5-4b69-923c-d01fc226fa65', 169, '6d3461d4-95a5-4444-957a-581ee7b4c7f2', '484db7fa-974f-49ba-ba9a-dc6edfb09a54', '男', '00000000-0000-0000-0000-000000000002', '2026-02-03', '2026-02-05', '10:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', 'ワールドアイ株式会社の木戸と申します。 2/5（木）10：00～で予約しました。  「ニーズバンク」というビジネスマッチングサービスを開始しましたが、 登録者募集に課題があり、そのご相談になります。 https://needs-bank.com/  継続率100％とは、素晴らしいですね！ 当日は、よろしくお願い致します！', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8ed5d527-ae96-4d06-8d9b-695b507c682e', 170, 'fb60b87e-0e55-47d7-a448-861ce29f2140', 'c69f5fe6-7b45-44da-875f-cfc82280afbd', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-04', '2026-02-05', '17:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 １日３人の紹介は申し込み希望の人が３名なのか、ただマッチした人を３名紹介するのか気にされています', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '659c13be-207e-42a6-bfbd-97e828e3f29d', 171, '10404e0b-af70-4eac-bce8-37b2189ea9c2', 'bdcb1f05-35f9-40d2-973c-a41fd2a50c64', '男', '00000000-0000-0000-0000-000000000004', '2026-02-04', '2026-02-06', '13:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', '13：10から開始 ハチドリエージェントで獲得', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '451d8873-21cb-454d-9ee6-2fe015008e03', 172, '9a95002d-364e-464c-bb19-3d0def07f856', 'be1f4456-25e1-45b0-a22e-08c662d32ea8', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '13:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Bヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bae70fcc-0076-496f-adb0-141517815cef', 173, '68e2ad80-528e-41f4-872b-b209889e67eb', 'f2bf63aa-17bd-49d0-9f21-80bee88543e4', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-04', '2026-02-06', '16:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 手数料伝え済み、業界平均の後に27%ですと伝えるとかなり好反応でした', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '14f3b01e-a962-4b1b-89f9-eff8d44e8fb4', 174, '7de3f30c-6dc2-4612-aaaf-d2bdd79c111a', 'aeb64c26-4c93-4bd4-9d41-a1bb03ad069b', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '91abddbc-a61d-410e-8033-ecd3c810bd73', 175, '65e3c52a-9fdc-42ab-9e7f-0bbc428fe79a', '03a579c4-328b-489c-a369-2988c2ea90ba', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '35c7ca8e-0b4e-4842-8f5c-0cd29933b3dd', 176, 'f86e3799-516a-46cc-9455-17cdfa34ee7a', '2525f8aa-3137-46ff-8de6-5f2eea10a727', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6de4a2c7-6d71-49a6-88e9-b0e607a757c3', 177, 'bf91a08e-bfce-401b-84a1-c195eec61bca', '65d00623-34b8-4786-b577-9a3e48202e15', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0b32a1b1-15c8-4d32-be58-8ba01eacbd01', 178, 'f3cc5b19-6876-4e91-b9de-f64799d08bbb', '0ddb2a9d-ee75-49a0-918a-fb8c2e76e4b9', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2d285d5d-3ea0-404c-b14e-c37510f57475', 179, '5ea0fb2a-cabb-4166-b891-9eceb14b86ba', '4826674d-5a1e-42eb-a86a-8490e9bc2236', '男', '00000000-0000-0000-0000-000000000001', '2026-02-04', '2026-02-04', '16:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'cc459cbe-7248-4173-835a-fc0e4dfa8b0d', 180, '8aaf860d-9e8c-415d-9002-de582fba74c3', '550826af-46f6-4cca-bf2d-188e2da47182', '男', '00000000-0000-0000-0000-000000000002', '2026-02-06', '2026-02-06', '10:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b2a34612-8de8-45a8-a20b-44e6b8caba51', 181, 'c55bd7e7-47c8-424b-b8cc-eeada3e6b4bd', '5b1c03ab-9699-43ca-af33-d98009d97f30', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-06', '2026-02-10', '10:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・首都圏に募集ができるのはわかるが、新潟にも紹介できるのか ・また建設の技術者を募集しており、３人/日の紹介ができないと思われております ・時間があまりない為、手短に話してほしいとの事です。 ・紹介手数料お伝え済み', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd085cbff-9ac4-4e9d-b482-cd5bb690a0bd', 182, '465a3d78-f860-4f27-a7fd-736f3f31b458', 'bbc0e9b6-d529-4078-86d6-683fdf54e312', '女', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-06', '2026-02-09', '16:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・どの職種に対応しているか気になっている ・紹介手数料と3人保証している旨はお伝え済み', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '819e3142-6e4b-4a96-b25e-64c4ecc66e6f', 183, 'bf49d17e-5791-4eb2-9b59-52993dcabccc', '086c7900-3bba-4c9c-9e10-0708248b3d82', '男', '00000000-0000-0000-0000-000000000004', '2026-02-06', '2026-02-09', NULL, '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', NULL, NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '91bea770-96b7-40c4-a72d-ed6440baff2f', 184, 'f2c77f70-f8c1-4cfa-9e06-77830aa0b8ba', 'c9d5f391-26af-4020-904e-69d21c2692c9', '女', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-06', '2026-02-16', '14:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・地方の求人希望（新潟と岐阜？）だった気がします', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '84869aed-f615-4d60-98e1-8943f65bef72', 185, '6c464925-9cc0-4467-b8e7-d0a5385af2ec', '1854d842-c88d-442e-ad6e-25b689b0e96c', '男', '00000000-0000-0000-0000-000000000001', '2026-02-06', '2026-02-06', '17:00:00', '確定アポ', '責任者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ccb211ad-ea1e-407e-a10a-63a250dc8028', 186, '02f13c2d-6fec-4374-a983-436e3d4d2b01', '676bf5b5-45f1-4b77-b05c-8164b0946f3a', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-06', '2026-02-09', '16:00:00', '確定アポ', '社長', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・そっちでスカウトしてくれないならやらないと言われました 　┗御社のニーズに合っているかは実際お話しした方がわかると思うのでピックアップまでこちらでしてだれと面談するかは企業様側で選んでもらってる旨伝えてます。 ・また実績も気にされていたので、採用単価が25%下がっている話しています', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3aab2e0a-edcd-4968-8db2-f1378bbb8cd9', 187, 'a3af25b7-8ed3-4568-850f-9bf241085970', '5a70538d-8edb-4fc9-a240-3b14aa134b5d', '男', '00000000-0000-0000-0000-000000000001', '2026-02-07', '2026-02-07', '10:30:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7bf02f02-09d7-46e6-8818-7cbf1266a231', 188, 'dff62bfb-ad84-4178-bcf6-17f653c87fc2', 'c10f6ca5-13ce-4883-9f62-974f1f5cde3a', '男', '00000000-0000-0000-0000-000000000001', '2026-02-07', '2026-02-07', '10:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e009504b-0ae6-4c96-8ce6-e6c203e31ae1', 189, '11a5774d-5aba-45c9-b781-dbdeda19f66a', 'e10e943f-fd44-45e4-a317-c08f3fc0a86c', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-09', '2026-02-16', '11:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・紹介手数料お伝え済み', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4caaf043-9272-416d-a109-d70f9ec11d5f', 190, '70fb1848-dc77-47eb-94e1-0227db7017c8', '43807068-03a4-4492-8114-29b5ac256ebb', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-09', '2026-02-17', '11:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・地方の方にも紹介できる旨伝えアポ獲得しました', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4ba7d3db-4a86-4ff3-a2af-aa4345776eaa', 191, 'f929394a-b5dd-4be5-9e1d-e742a27f39a2', 'e544c28d-97f0-41c3-9594-1da0fb43b567', '男', '00000000-0000-0000-0000-000000000004', '2026-02-09', '2026-02-26', '11:30:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '627ba0f4-7298-4793-8dfa-afcb04818951', 192, '9a2dde32-a390-4c9f-96dd-b2fb9e230616', '95cf0e7e-f0aa-4deb-be55-7e39c6e9278d', '女', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-09', '2026-02-13', '16:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・紹介手数料お伝え済み ・新卒もないのかと興味持たれてます ・時間に関しては余裕なく40分程度との事でした', NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '28de453b-fc65-43ca-a66a-bd9bc9f1dd0b', 193, 'c606acd1-2909-46ab-964a-552fcbdc9d9b', '00f561d2-a24c-4ae8-8c9a-4cc96761a3f4', '男', '00000000-0000-0000-0000-000000000002', '2026-02-10', '2026-02-10', '11:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a6d3e525-21c8-4b69-9bf4-a88a10fdaf7e', 194, '1104fe2e-6122-46c4-af12-15cf1e8ca8e9', '379aab1b-f4d2-46b8-aa89-e443cd753d9b', '男', '00000000-0000-0000-0000-000000000001', '2026-02-10', '2026-02-10', '11:00:00', '確定アポ', '社長', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4094ae98-3a4b-4b95-966d-9adca1877a70', 195, 'bd8d17c3-76b9-44f9-b34d-96297e68de0a', '3136f286-788c-4180-8376-f0a64ec83cd1', '男', '00000000-0000-0000-0000-000000000001', '2026-02-10', '2026-02-10', '11:00:00', '確定アポ', '社長', 'a8d27d08-989e-45c3-b90d-aa24a86ffe35', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b8b23ca7-7a44-4732-950f-abb0660da7a8', 196, '13a8afcb-e653-47a4-a547-1249c4e54228', '245c7f03-90e0-4e44-8005-d8a695ff56b1', '男', '00000000-0000-0000-0000-000000000001', '2026-02-10', '2026-02-10', '11:00:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b16e02ea-032d-4e1f-97ca-46aa9672e64f', 197, 'c029e507-ce1c-4ab0-9702-506893af5c0d', 'cfa10620-0c3f-4fe2-8dbe-bb3b1e2f970c', '男', '00000000-0000-0000-0000-000000000001', '2026-02-10', '2026-02-10', '11:00:00', '確定アポ', '責任者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c73e8e3f-d603-443e-9de0-926f8ee09281', 198, '128ee08d-8323-4ec2-b2bc-3d0a15d929f1', '7e97e6c7-115b-49ab-a69c-be2ca6aeb0af', NULL, '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-12', '2026-03-09', '15:00:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得 ・紹介手数料お伝え済み ・最短48時間で1日3名保証', NULL, NULL, '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a6362311-e882-4444-8380-e795cf8015bc', 199, '7d93e886-cf15-4225-8da4-aa7a08e73026', '25dff735-e065-4fe4-86f6-463404278697', '男', '00000000-0000-0000-0000-000000000002', '2026-02-12', '2026-02-12', '15:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bc2f679f-65dd-4e99-8670-508d275e3707', 200, '9b750c61-d77e-4b71-aee3-a12af5a582fd', '47f7fa27-837b-4b00-882e-83d211da8ba1', '男', '00000000-0000-0000-0000-000000000004', '2026-02-12', '2026-02-19', '15:30:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得。 費用は伝え済み。またAIを使ったものだとも説明済み', NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '29a0ca40-21c0-42d9-9e40-88998d02b133', 201, '4f4241ae-edae-4526-8bc9-8010c8240934', '4e9ac435-7381-480c-9ad7-8e842e18fb66', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-12', '2026-02-16', '14:30:00', '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'ハチドリエージェントで獲得。 費用は伝え済み。またAIを使ったものだとも説明済みk ダイレクトエージェントってことですか？と質問されたのでAIが希望ジャンルにあわせて御社に提案するので恐らくそうかとと濁してます。認識間違えてたらクライアントと僕に教えてほしいです。', NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f2372ebf-64e1-4114-ae6a-e3eb14dc2b9e', 202, 'c1c85b46-e4cb-402a-ba94-784049e4a309', '84b2c088-8154-4ac7-99f2-a2fbbe8c8f3c', '男', '00000000-0000-0000-0000-000000000004', '2026-02-12', '2026-02-16', NULL, '確定アポ', '担当者', '0d8e5e43-659e-496a-9f9a-1949ad95b3f5', 'リスケ中 ハチドリエージェントで獲得 費用27％は行けそうな金額といっていた', NULL, '00000000-0000-0000-0000-000000000002', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4dab2948-cd1c-4bfb-9829-89cb3079db27', 203, '2fda0136-1194-419c-8f6a-b03be5123e61', '832e9652-dbbb-4b31-89bd-4000fff4f813', '男', '00000000-0000-0000-0000-000000000004', '2026-02-12', '2026-02-12', '12:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '01add2b6-dac6-4efd-bfcb-4493d5ed583d', 204, 'd8994379-2e7e-40bc-9620-0ef6511a09c9', 'c9602625-02c9-490f-b7bd-ba3996b88dfd', '男', '00000000-0000-0000-0000-000000000001', '2026-02-13', '2026-02-13', '10:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e3eee156-32ac-4b26-9187-b92907a0d719', 205, '53abb4cf-10ea-4f4e-9522-ecc74c59fec0', 'ba8ebe2c-3f17-4b39-b182-748a183801e7', '男', '00000000-0000-0000-0000-000000000001', '2026-02-13', '2026-02-13', '10:30:00', '確定アポ', '社長', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5721b8ce-eddc-4dc8-847e-073df2773d53', 206, '1036c865-897d-4d79-a44f-e89fc85061d1', '0ce4cd44-3089-412c-bdec-beb50ca5788e', '男', '00000000-0000-0000-0000-000000000001', '2026-02-13', '2026-02-13', '10:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6c33e1db-ee4e-4785-b66a-2412174f15f1', 207, '6b5dc3ec-5ba2-4db2-9e25-31bccacd671d', 'd4df84c5-a69a-4e2a-af81-b1b4ddc2fbda', '女', '00000000-0000-0000-0000-000000000001', '2026-02-14', '2026-02-14', '11:00:00', '確定アポ', '責任者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '09bd42c1-04fc-4cd9-815d-d10e8f1be5d2', 208, 'dee2d857-6555-40fd-a0d1-fb3d9bea761b', 'cd0528a9-a9b8-4e3e-97ab-1861dd7a6ddf', '男', '00000000-0000-0000-0000-000000000002', '2026-02-16', '2026-02-16', '15:00:00', '確定アポ', '社長', NULL, NULL, NULL, '00000000-0000-0000-0000-000000000002', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd67618fc-8e96-4629-ad34-e35d3eba699f', 209, '01f09321-40be-4961-9834-ab7a0cc82255', '34b65e21-8509-4cc1-a26a-0e310284accd', '男', '00000000-0000-0000-0000-000000000001', '2026-02-16', '2026-02-16', '15:00:00', '確定アポ', '担当者', 'aa846bed-657e-4f2c-9d5d-d837b9769a6d', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '263f6809-8cc4-40f8-b319-d68d96762e77', 210, '3033acea-96fa-47ae-a24c-54eceb44077e', '7d874a4d-9f06-4c9f-af29-9df0285274c1', '男', '00000000-0000-0000-0000-000000000001', '2026-02-16', '2026-02-16', '15:00:00', '確定アポ', '担当者', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '414a5198-e933-4aa0-bba6-7d5124dc873b', 211, '8d60a5cb-4992-450a-9c40-4068376e99bb', '5c379bb3-5060-419d-b307-96ff6f2d628e', '男', '00000000-0000-0000-0000-000000000001', '2026-02-16', '2026-02-16', '15:00:00', '確定アポ', '社長', '2c6efee9-b5cc-46ad-9dc9-cf9685d95763', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '37efffb5-d987-4b9a-a489-0f64b631cdcc', 212, '47f8f82b-f40b-442c-a1be-18f8fd86e6f6', '5d5eb0c4-c8fa-4abf-b95e-dd0e2e381783', '男', '00000000-0000-0000-0000-000000000001', '2026-02-16', '2026-02-16', '15:00:00', '確定アポ', '担当者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2d3c0498-524a-4842-98a0-86a51ad737a3', 213, '8fdf7b68-1d72-4e71-967e-ef001fb15496', '61e34f00-5662-45e4-b486-5637c806806a', '男', '00000000-0000-0000-0000-000000000004', '2026-02-18', '2026-02-25', '16:30:00', '確定アポ', '担当者', '6ff5a92a-a498-4000-842d-b7a9e338fac8', 'https://crowdworks.jp/public/jobs/12928479 【 概要 】 HR Buddy研究所は、大学の研究者をはじめとする人事・組織領域の専門家の一般社団法人です。 https://hr-buddy.co/  今回HR Buddy研究所では、インサイドセールス（在宅テレアポ）を募集いたします。 企業の人事部門の担当者にお電話し、無料相談会（オンライン） の商談設定と、簡単な事前ヒアリング項目の回収までをお願いします。 トークスクリプト・FAQ・サービス説明資料は当方で用意します。【 依頼内容 】 当方が提供する企業リストに架電いただきます。  事前ヒアリング項目の回収（例） ・現状の組織課題（例：採用の業務負荷が大きい、エンゲージメントが低い、退職率が高い、など）  無料相談会（オンライン）の商談設定（候補日調整） ・架電結果の記録（スプレッドシート等に入力） ・折り返し対応・簡易フォロー（テンプレ支給）こちらから電話番号リスト、記録シート、トークスクリプトを共有します 1回あたり1〜2時間などでも可能です。  【 重視する点・経験 】 B2Bテレアポ／インサイドセールス経験がある方 丁寧なヒアリング、情報の整理、ログ入力ができる方  【 応募方法 】 応募時に以下をご提示ください。 ・簡単な自己紹介 ・テレアポ実績（商材/架電先/アポ率など分かる範囲で） ・稼働可能な曜日・時間帯 ・希望単価（コール単価・成果報酬の案／組み合わせ提案も可）ご質問がありましたら気軽にお問い合わせください。 ご応募をお待ちしております！  下記の内容でアプローチしそのまま打ち合わせの流れになった 【会社概要】 株式会社SoloptiLinkは「営業の最適解を、すべての業界に」をミッションに、AI×人材を融合した営業支援・営業代行事業を展開しております。  テレマーケティング、インサイドセールス、営業戦略設計までを一気通貫で支援し、継続的な売上創出体制の構築を得意としております。  【対応条件／料金体系】  ・架電単価：1コール70円 ・月間5万件規模の継続架電体制構築可能  ※上記以外の追加費用は一切いただきません。 ※費用対効果が合わない場合は、契約見直しも柔軟に対応いたします。  【稼働開始スケジュール】  ・契約後 最短2週間で稼働開始可能 リスト設計、スクリプト調整、テスト架電を経て本稼働へ移行いたします。  【対応領域】  ■ BtoB営業支援 ・法人向けサービス新規開拓 ・アポイント創出／商談設定 ・インサイドセールス代行  ■ BtoC営業支援 ・個人向け商材販売促進 ・イベント／催事送客 ・反響追客架電  商材特性に応じたトーク設計・ターゲティングが可能です。  【導入・取引実績】  ・株式会社フォーバル ・株式会社ライトアップ ・日本エコシステム株式会社 ・シャープ株式会社 ・長州産業株式会社 ・他1000社以上との取引実績  【営業支援成果】  ・人件費 1/8 削減 ・開始2ヶ月でアポ数400％達成 ・10ヶ月で売上1億円以上創出  【運用実績】  ・月間5万コールの対応実績あり 継続案件において、大規模母集団への安定的な架電運用を実施しております。  【運用品質・管理体制】  ・全架電録音対応 ・通話ログ共有可能 ・日次／週次／月次レポート提出 ・KPI（通話数・接続率・アポ率）可視化  運用状況を透明化し、改善提案まで一体で実施いたします。  【当社の強み】  ① 継続運用前提の営業体制構築 単発支援ではなく、KPI設計を行い長期成果を創出。  ② 大量架電×品質担保 量と質を両立した営業活動が可能。  ③ トークスクリプト最適化 ABテストにより反応率を継続改善。  ④ コンサルティング連動 ターゲット戦略・販売導線設計まで伴走。  これまでの営業支援実績とコンサルティングノウハウを活かし、貴社の売上拡大に向けた継続的な営業基盤構築に貢献いたします。  詳細な体制・実績については添付資料をもとにご説明可能です。 ぜひ一度お打ち合わせの機会をいただけますと幸いです。  何卒よろしくお願い申し上げます。', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '03fed703-3a68-461e-baa4-389764f6b8af', 214, 'cd99f8eb-36e4-4e4c-8ed8-7e4a3b80de83', '8e7b4897-bc95-4010-bed2-9f91b58891d0', '男', '00000000-0000-0000-0000-000000000004', '2026-02-18', '2026-02-24', '19:00:00', '確定アポ', '担当者', '6ff5a92a-a498-4000-842d-b7a9e338fac8', 'https://crowdworks.jp/public/jobs/12832873 【 概要 】 太陽光発電・蓄電池導入のアポイント獲得に向けて、テレアポを実施していただきます。   【期待していること（業務内容）】 ・テレアポ ・お客様の課題を引き出し、興味を喚起するトーク展開 ・商談につながるリード創出 ・トーク内容や成果を定量化・報告・改善  【 期間 】 即稼動可能   【 報酬体系 】 40,000円/1アポイント ※契約金額（税込）からシステム利用料を差し引いた金額が、ワーカーさまの受取金額となります。 ※スキル・ご経験に応じて柔軟に設計させていただきます。  【重視する点／歓迎スキル・経験】 必須ではありませんが、以下に該当する方は歓迎します。 BtoB向けテレアポ／IS業務の実務経験 電話での法人対応に抵抗がない方・課題ヒアリング型の営業経験 Slackでの業務コミュニケーション経験 基本的なビジネスマナー・コミュニケーション力 PC操作が可能な方（CRM入力、オンライン対応） 業務委託として一定の自走ができる方  【備考】 トークスクリプト 架電リスト：あり CTIツール：あり マニュアル・オンボーディング：あり 商材理解・ターゲット設計が整理された状態でスタートできます  【 応募方法 】 ・簡単な自己紹介や実績をご提示ください。   その他ご質問等ありましたら、お気軽にお問い合わせください。 ご応募をお待ちしております！ 下記の内容でアプローチしそのまま打ち合わせの流れになった 【会社概要】 株式会社SoloptiLinkは「営業の最適解を、すべての業界に」をミッションに、AI×人材を融合した営業支援・営業代行事業を展開しております。  テレマーケティング、インサイドセールス、営業戦略設計までを一気通貫で支援し、継続的な売上創出体制の構築を得意としております。  【対応条件／料金体系】  ・架電単価：1コール70円 ・月間5万件規模の継続架電体制構築可能  ※上記以外の追加費用は一切いただきません。 ※費用対効果が合わない場合は、契約見直しも柔軟に対応いたします。  【稼働開始スケジュール】  ・契約後 最短2週間で稼働開始可能 リスト設計、スクリプト調整、テスト架電を経て本稼働へ移行いたします。  【対応領域】  ■ BtoB営業支援 ・法人向けサービス新規開拓 ・アポイント創出／商談設定 ・インサイドセールス代行  ■ BtoC営業支援 ・個人向け商材販売促進 ・イベント／催事送客 ・反響追客架電  商材特性に応じたトーク設計・ターゲティングが可能です。  【導入・取引実績】  ・株式会社フォーバル ・株式会社ライトアップ ・日本エコシステム株式会社 ・シャープ株式会社 ・長州産業株式会社 ・他1000社以上との取引実績  【営業支援成果】  ・人件費 1/8 削減 ・開始2ヶ月でアポ数400％達成 ・10ヶ月で売上1億円以上創出  【運用実績】  ・月間5万コールの対応実績あり 継続案件において、大規模母集団への安定的な架電運用を実施しております。  【運用品質・管理体制】  ・全架電録音対応 ・通話ログ共有可能 ・日次／週次／月次レポート提出 ・KPI（通話数・接続率・アポ率）可視化  運用状況を透明化し、改善提案まで一体で実施いたします。  【当社の強み】  ① 継続運用前提の営業体制構築 単発支援ではなく、KPI設計を行い長期成果を創出。  ② 大量架電×品質担保 量と質を両立した営業活動が可能。  ③ トークスクリプト最適化 ABテストにより反応率を継続改善。  ④ コンサルティング連動 ターゲット戦略・販売導線設計まで伴走。  これまでの営業支援実績とコンサルティングノウハウを活かし、貴社の売上拡大に向けた継続的な営業基盤構築に貢献いたします。  詳細な体制・実績については添付資料をもとにご説明可能です。 ぜひ一度お打ち合わせの機会をいただけますと幸いです。  何卒よろしくお願い申し上げます。', NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '49e9c286-37fe-4f85-99e6-accfda0d5351', 215, 'beb4ff53-fbea-4527-9f6a-6a3e9f4b4a8c', 'cead4ca5-5b45-4d1a-b71f-ef1ff99acc1e', '男', '00000000-0000-0000-0000-000000000004', '2026-02-18', '2026-02-24', '19:00:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b83f0476-6199-4e7d-9bb1-a4d758afdf87', 216, 'e8650ea6-0387-4a7b-9709-e836837a280f', 'f8c9c2a4-949e-41d2-b0da-f50258295691', '男', '00000000-0000-0000-0000-000000000004', '2026-02-18', '2026-02-24', '19:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4347b320-de97-428a-a336-6b12181d0fee', 217, 'e061b9f4-d2fd-400c-aac2-8746ecd7e282', 'f6dfcdfb-fcba-450a-bb0b-9f01b99ed98d', '男', '00000000-0000-0000-0000-000000000002', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', '6ff5a92a-a498-4000-842d-b7a9e338fac8', '【 概要 】 法人向けのテレアポをしていただける方を募集します。  【 依頼内容 】 ・概要：営業支援の商材に関する、コールドコールでのBtoBの営業 ・具体的業務内容： ー日次での稼働開始前の打合せ ー稼働開始後のチェックおよび録音のフィードバック ー設定したKPIに基づくテレアポの推進 ・希望稼働時間：週15時間程度、月60時間程度安定的に稼働をいただけますと非常に助かります。 ・コミュニケーション：稼働開始後1,2週間は密にコミュニケーションを取りながら進めていきたいと考えております。 ・スクリプト、リスト：有 ・電話代：Zoom Phoneの権限を貸与いたします。  【 期間 】 ・契約期間：問題なく業務を行っていただける場合半年～長期にわたって継続的にご一緒できればと思っております。  【 契約金額(税込) 】 ・報酬設計： 時給：1,980円～3,000/h （成果に基づき、さらに契約金額を上げることも可能でございます。）  【 重視する点 】 テレアポ業務の経験がある方  【 応募方法 】 ・簡単な自己紹介や実績をご提示ください。 ・条件提示にてお見積もり金額を入力してください。  ご質問がありましたら、気軽にお問い合わせください。 応募をお待ちしております！   【こちらが送付した内容】 はじめまして。 募集内容を拝見し、ご協力できそうと思いご連絡しました。  BtoB／BtoC問わず、テレアポ・インサイドセールスの支援を行っています。 継続案件を中心に、安定した架電運用の実績があります。  【対応可能なこと】 ・新規アポイント獲得 ・インサイドセールス代行 ・反響追客 など  【実績】 ・株式会社フォーバル ・株式会社ライトアップ ・シャープ株式会社 ・日本エコシステム株式会社 ほか  月間5万コール以上規模の運用実績があり、 商材に合わせたトーク改善や運用最適化も対応可能です。  【体制】 ・月5万件規模まで対応可能 ・通話ログ／各種レポート共有可 ・費用感は内容・ボリュームに応じて柔軟にご相談可能  1名体制の案件からでも柔軟に対応可能ですので、 まずは詳細をお伺いできれば嬉しいです。  よろしくお願いいたします。   上記送って日程調整 先方からの質問など特に無し', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '03e6579c-3330-4a0f-ba02-b84ea1bbc301', 218, '0a05a09d-fbf2-452c-aec3-4d51f4f7e540', '53a5e4f8-655a-4836-8c15-be137c024361', '男', '00000000-0000-0000-0000-000000000001', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', 'b0cdab03-cde8-4066-8eb0-94f813d76f22', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '46ad1712-1afc-4c19-8f10-233d9d739bbc', 219, '6d8258dd-518c-4e3b-81ef-cb1103242e4d', 'b54f3eaf-3f6b-41ae-850d-8174db56d663', '男', '00000000-0000-0000-0000-000000000001', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e0570c49-5ceb-4ae2-853d-b0e634152096', 220, 'd1e8c5fc-9420-4099-9bac-0b61c9527860', 'a89bd62a-06c7-4c52-a660-9a11549dc847', '男', '00000000-0000-0000-0000-000000000001', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '12e85160-823a-435a-b911-26a413ae3696', 221, '5dc8b1bc-d891-4b04-ba7b-85da8cada77c', '350494ba-0333-42a5-bf16-cc359bb5b3ea', '男', '00000000-0000-0000-0000-000000000001', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', 'e8cc8cf4-9c74-49ae-bc5f-675b3eb5bc05', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4a2ab2dc-6e74-46d8-9194-5ebaee2d9aa0', 222, '082df1ac-7150-4d78-baa1-56212a54c170', 'cae7a2fb-0af7-414b-89a6-ee5d9549a27f', '男', '00000000-0000-0000-0000-000000000001', '2026-02-20', '2026-02-26', '14:30:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Cヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ddf061f4-fddd-43e8-8966-4600392f1808', 223, 'eed3c4e4-715a-4172-9a24-e4207b3dfa3a', '011aa93a-aa12-4e71-8491-9a8d23e345b4', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-24', '2026-03-11', '14:00:00', '確定アポ', '担当者', '7c81b1dd-de6e-4895-86e7-ad14d73e83e9', '１万コールを無料でできることはお伝え済み ・補助金についての話は一切しておりません。 ・そのほかについても話しておらず、担当者呼び出し→１万コール無料でできる旨お伝えし日切', NULL, '00000000-0000-0000-0000-000000000001', NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8563615c-4a8a-4c9e-9bb0-4f79bbf14356', 224, '5d2ce498-8ea8-467e-be64-177d71377475', 'b1e9b260-44b2-414a-bba5-8ccdf6661d3b', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-24', '2026-03-11', '14:00:00', '確定アポ', '担当者', 'af0ef607-1e5f-4556-b618-0307eb98dc5f', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Aヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '090a61c2-5120-4739-82c1-caaab473e1fd', 225, 'aa344e71-b2bb-4433-9237-b1021e9a57eb', '3c56c042-8a79-489f-9151-22491042de76', '男', '63a55be1-0fca-459f-8335-8c800019c678', '2026-02-24', '2026-03-11', '14:00:00', '確定アポ', '担当者', '17a41e52-2f2d-4646-ae4f-e57eac062028', NULL, NULL, '00000000-0000-0000-0000-000000000001', '商談可', NULL, 'Bヨミ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e716554c-3859-4ab4-8c11-d9b3b534fa42', 226, 'af72c62f-147b-4648-8c13-00b53c1b73e4', '98ce8a6d-c990-4a07-a142-169df6ba0078', '女', '00000000-0000-0000-0000-000000000002', '2026-02-25', '2026-02-25', '14:00:00', '確定アポ', '社長', '162b01d1-74f1-4020-a827-26ddc7d19ac7', NULL, NULL, '00000000-0000-0000-0000-000000000002', '商談可', '失注', '失注', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '15b1fc51-ab50-47b7-8d1d-b3049a4041e0', 227, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '00e5f9f7-4632-4f99-8b10-5934bbfee848', 228, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8d165c0f-e186-4127-baff-cccb6bea333f', 229, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '42cfcbe0-5267-4f29-8a3c-bfaea5bb4757', 230, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '43b2a137-172f-4389-a798-81d2417a4a1e', 231, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5d606ad5-8601-4dc9-b087-abdba93ae5b9', 232, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '41d9bb75-35bc-4183-92ef-4768d018d0e9', 233, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fc329acc-5c19-4083-ab29-178021d7da98', 234, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5891bbc8-a2ae-41b5-ba02-86db91cfb661', 235, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bb432831-1b88-4a24-bc82-3e8583b07b10', 236, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd86ed78f-354a-4309-88a3-cb2189ef90fc', 237, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6f904f24-9f8f-4376-93c7-0ae911b43975', 238, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '82746712-fc24-4f29-ba3a-cd1f8210bb66', 239, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5ef583d2-4e89-4e3d-aa63-622c3d832860', 240, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '782c1779-c2df-455c-a663-2a09d70e74a9', 241, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd9793103-b913-471e-a0e0-6a5e639a3b00', 242, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'dea43442-ee8b-442f-a3c4-4a3722501044', 243, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8176ffc4-6c1d-4731-b6e0-5018a986b27c', 244, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ebe743ae-dfd8-49f3-8610-2b4ef9440f0f', 245, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aac08c7b-8324-4395-bea1-dcedd076c583', 246, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0ac75205-511d-4644-9881-85cfc09d1681', 247, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2268697c-301f-46ee-b9a0-92951f52f931', 248, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'de1752ef-1a8b-40af-9333-658dbc3a5a33', 249, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8dee27f5-cff6-4833-bf6e-8b2bb2de0b96', 250, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a75d6574-8c2d-4ba3-b75b-4144d57aa680', 251, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'dc082420-802b-401c-8737-b0e3c7a87833', 252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aa467a34-1854-4759-ac74-9357aafc5fcb', 253, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eba603c2-6d75-4db2-85b6-81e3539fa226', 254, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '075db641-42cd-48d9-adc1-f510e737c1bc', 255, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a01b0f52-4d98-4e7e-bc51-e1804302aa50', 256, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '986e2657-92c4-4b8d-ba34-620afb10f1d5', 257, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '71a5ed37-1aa2-4eb5-aac6-9f1fd5548329', 258, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1d686c2e-05a6-4d70-9bba-5d09e5883ba5', 259, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ecf779de-5092-41b8-be79-43019ea6a55b', 260, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f859683b-95cb-4e27-8267-a7cad29646d9', 261, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '42dad5e2-b25e-46ed-9751-07cffb50ede0', 262, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a710b020-2f6f-46c2-96b2-926f72b087d2', 263, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd8ea876d-c7f3-413c-8899-90cdbd088c9e', 264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b46a36fb-0ba2-4f9d-ac08-56a8b7eab95b', 265, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd2a0c560-bcf5-4b5a-98ec-758c5c366235', 266, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '263e63f3-dcf7-40b8-9ea6-27767604129e', 267, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5a8ea56b-4aa7-4580-9a29-b664cf22a0f4', 268, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2ab744e0-2ed1-47c5-83ea-1ce7fd1ed12e', 269, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '72b29234-0c30-48c0-bf39-e24d7db727e5', 270, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd49fd842-b714-4b1e-93a1-7703f34721bc', 271, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9612ab7b-bbfa-42ea-95bb-5f00bccc4a4e', 272, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5bdd4556-0375-4fc3-a489-5d553664b351', 273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'df9543ae-ea59-43b7-bb5a-630326187a2b', 274, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a61fc4bc-d60e-4749-80e0-f6f9e0c19768', 275, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '18f5bf55-f132-4ec0-99cc-196623e180c3', 276, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c551aa91-b229-46f5-8595-b07dff8fc2e0', 277, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7779d2c1-1da6-4751-8402-96a72f5e494a', 278, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'db212655-2f07-4c69-80cb-8ca910699491', 279, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c14a75e7-14fa-4cb7-9ce8-8b0513cebb8c', 280, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4437e4ad-01ba-407e-9485-30a89b0bfd49', 281, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd13cd670-6c67-402b-8c0a-f229b19ce788', 282, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '738e7ba6-6ab0-422d-a4ce-8877a9b4f29b', 283, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fc9c4132-81da-4bec-9477-41920f174523', 284, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e7dffdde-1242-4ab4-b6cb-1ccd863474ad', 285, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f53dace3-c83d-4285-8dab-62af13f05db0', 286, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e3f9c9b3-16be-459e-9484-521556f7f86a', 287, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '49ec95d4-b6bc-4735-a833-aaec6f8c70c3', 288, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'afb521dd-00a1-4e07-ac7b-076e861079d2', 289, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8e6ac91a-a829-46a1-be1e-ae627aff9f62', 290, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0aff2a1e-9822-4b09-be5d-38bafde4d9fc', 291, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4d10a0e6-a29d-4e4d-80c5-0d00d6ce92be', 292, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3c21eea5-0eeb-4485-bdab-e783a3251a28', 293, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'caf1cb46-9b1f-424b-a2b4-4d561d047334', 294, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '11e888f3-1716-4eaf-9e17-45f88471cced', 295, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1331785a-d14d-4a03-90c7-d1b08448f5db', 296, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5a955a6c-978d-4c77-bb45-531eec590520', 297, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5ebe5e3a-91c7-417f-8028-13602f6fdc76', 298, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '55e61790-a90a-4c99-a6ce-af8f071e208e', 299, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6188e6ca-1763-4120-87e2-8089917ab96e', 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '79196a3a-9969-44db-b89f-3800016fc0b1', 301, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8f81664a-7545-490a-b1f6-389e8a673b4d', 302, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f6705fc4-bd25-44cc-b6b2-f189391acf35', 303, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '82f8ddd6-1a41-42a2-b231-a0a0ea0c32ea', 304, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd3fe2896-8074-40aa-89a7-a8753b9e5779', 305, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd93f2e5e-9650-4da1-ad5a-39105b80fcf7', 306, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '512a89e1-b080-4e10-913e-fc3862442699', 307, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1beb4eaf-fc4f-479d-80f3-c761e74b0d2e', 308, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '01056928-3330-4497-8dbe-7e79d18f59ce', 309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd0f17875-a24c-4ff9-a478-90387f6a5537', 310, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4b3f2f11-4721-445b-8269-37aee64cda05', 311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e95339dd-aad8-4123-91f6-333e6cebbd31', 312, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ae2bdde3-f16a-4fd7-847f-b509b970ddfc', 313, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '78e8166c-0639-4863-8c8e-efe17131448e', 314, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8689626a-b610-40c2-bf8b-2cf230b48a52', 315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd7bdd88a-4dca-47ed-a64f-9d233bcf249f', 316, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '680c9779-f046-41b4-bde0-c7d75b65b8ad', 317, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1d09487e-f6e0-47c5-a39d-6954428589ad', 318, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '016d7804-1090-461c-b666-a6153da189e5', 319, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a9301c9c-6043-4685-bc96-eaf672168c48', 320, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4cf52ddd-5947-47a9-bd48-2c6343047dfb', 321, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2c958b2e-2f2b-4280-a99b-a3723c3a63e8', 322, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9f284455-5c9b-4802-82a5-b1c3a8f4e937', 323, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e5322283-8c3c-4da7-8af4-d3c011be5309', 324, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9b950aea-fc09-4e0c-8c8e-232ce75ccbec', 325, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5d48f503-455b-492b-9b80-0795e63d7811', 326, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '16523291-cf57-45c9-b684-8eeb533c1e87', 327, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1428cdaa-74c3-4a06-b13d-bcfe809a8134', 328, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd3c5a9d7-a1ce-4363-8ce6-e739a10401b6', 329, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a83357ff-93eb-4b76-a558-936822a0d54c', 330, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '854e794a-6fc2-431d-a2e4-7bb6b9f2e3a2', 331, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5f20b5bb-76dc-43df-9187-f7ace6388098', 332, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '82e8017a-d393-4ba7-807e-56918076bf37', 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8c7c89dc-3d67-484c-a779-82bfdd63a97f', 334, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a86e1ad6-8b1a-4c61-8313-38291a57a7bb', 335, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '97953f81-98b1-4e90-9e77-db337a717209', 336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'af94afac-6b1d-4e22-8c25-ab365afa9fb6', 337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '19c3e058-1a21-44e1-beb8-d7066197a894', 338, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd84ea34a-7da1-499a-b90e-e468f46563b4', 339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3cc3ca22-5cef-478f-bff3-e49f0415af97', 340, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2f088abc-3c98-4daa-8f30-8a2c3598e129', 341, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a7665892-3784-48f1-bc50-9172fc159155', 342, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '51b62abd-4bdc-47fa-9b6c-f15532d342c5', 343, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e11eba81-1ffe-4b8e-a541-1509238bd750', 344, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '996bbc55-4a70-409f-a0dd-482450b7ccdf', 345, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0f4b3c38-4441-4984-8409-bc52d08fd784', 346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9e97c2d8-be80-4324-863f-10edb48fe75e', 347, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '38289da9-6571-41bd-9c63-ca207733fd84', 348, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c2f84708-d23a-4bb4-86cc-dbd76c7f4fd3', 349, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0af1f2ec-0bf0-49d5-9665-6375a60573eb', 350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4f7b1f2c-a50a-4ce7-848c-7e1b5c1b407c', 351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f43fc3bd-2b9e-4139-9708-d60233bb7458', 352, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'add69301-a523-47a2-9f32-ed6859cfc114', 353, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4feb123f-2ff1-40ed-927d-d0edc908653a', 354, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8bfa0bfd-6054-4a8f-bea1-955661e6edb4', 355, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ac6f38ea-cb8d-4c65-9a27-94f8704393fa', 356, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '812fff83-75e5-460e-b607-ce3c20bfb6ce', 357, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5b9ea925-690e-4ca4-9469-6327abc53b9b', 358, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2734e315-a232-43bf-8c80-9ae53764e22e', 359, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ba18e8d3-3f36-4c29-bee7-71e0d5ae7225', 360, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e4b0cd17-213b-4f82-b388-ffde0c822994', 361, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c204d366-c4dc-456f-9e14-b88cff5c9d3b', 362, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '12d2f5be-62d0-481a-9787-17a0cfd68925', 363, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e8cd99b5-2968-4a41-959b-c70f3e871172', 364, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1b7697c9-fac4-49d0-9fc0-1f642cc1fa97', 365, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f930a1fa-662e-42ad-8f11-bb22bdecf473', 366, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1d24d953-e0df-4feb-9776-a8c68902e2ad', 367, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9a29aa49-e632-40c4-b183-56f24835b569', 368, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd45eb717-583b-4b4a-891a-9215ee765452', 369, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3bebab27-76e1-498e-8e49-85381d1c44f5', 370, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'af514606-6cac-4083-aaec-3acd90d05710', 371, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f0139995-69a5-493e-85ba-95359761655d', 372, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3186974f-5284-415b-adde-669e7f169528', 373, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '60890c7c-e628-4aa8-bdb8-20bd16eef518', 374, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b018b307-d003-4051-a2e4-03fe2027df31', 375, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8539aa21-6cf9-4c32-823c-103eb1285bd1', 376, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3082442a-22bb-45ae-a112-7cde7e8c5fbb', 377, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5909a64d-ee3f-4c80-96eb-96a9391b5a5e', 378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c9f1732a-d450-47b6-a36f-55b6820cebc1', 379, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6113c393-4aff-40a2-9f4d-3e3f8fff1027', 380, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b38fa04c-c92d-45c3-8a5b-aed4f189550b', 381, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6b38e09a-17d4-449f-b8e5-3a90b2c92be4', 382, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '35e14b5e-a49d-4348-aa66-94e30a269061', 383, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a8dab638-14fc-47aa-abe5-795f18f0ee89', 384, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '783b3e83-1e13-4ebd-b565-44848cce9296', 385, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c9489ff6-50a2-4f51-8486-21b5923e4a08', 386, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7a7450a1-1adc-4e7d-8ecc-da200e34c929', 387, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a73c3815-5336-4066-a349-5a2a41c2b62b', 388, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b4c5daa3-a9e2-4647-b867-e0a6abbdc9b0', 389, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0e7d71e9-70a5-4a3b-ac57-ede97b35853a', 390, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e56f9c9a-3519-4307-ad4d-12fdb97228a6', 391, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2756d4fc-961a-4fdf-95ec-206a7b25d1d0', 392, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '38793def-2c7b-4637-9fc4-27b23081fe2a', 393, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2537c2e4-950e-4259-9432-b457c668d82f', 394, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'caee79bc-5636-483c-8807-30a9f704e32a', 395, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b84d7cb7-0fcb-4ed5-9a25-daf2109eab29', 396, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '77c4e389-82ac-442d-8c8f-97af64acc4c4', 397, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c2a591db-5b0d-4ed6-b7b5-9b9179a2ef49', 398, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '53cbc801-30fd-4415-bf34-c8fb47df0fe5', 399, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8dbda8dd-ae7a-42b2-981a-1091e816d94f', 400, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8c6c8b03-196f-4d20-9120-c49fc9e777f8', 401, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e3624eb2-ba3d-4e3e-b307-4ce4f4aebe5d', 402, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '11d04d09-2dc3-4a8d-b24b-e6b000e4b7e1', 403, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2c598010-e5fd-4e3e-9ef4-356690861588', 404, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eac04308-4db6-4a36-b178-b0791f194507', 405, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '09bfbb15-6d4a-46f2-be58-f1d4fb99ea0c', 406, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fdd3cd6c-f8da-48da-9f52-10be772b0aa8', 407, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1d1080ea-2045-4f01-84c9-2ea7b80e38b5', 408, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1e1325dd-3dad-4c79-b939-b28cd9fd1af1', 409, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '68502a13-e036-4abf-af1f-5e3890fc0efa', 410, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6f059e8b-4625-4df1-bd24-d499cc1d4020', 411, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8d98fdb1-47ed-4b6f-b345-930f61f05967', 412, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8a6aa2df-febf-4fc6-9427-3eb24a98abed', 413, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'af65150a-eb37-4e61-ab84-3f3cccf0c67a', 414, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f3b5ca2a-82d9-423a-911f-3aa0f8fb5aa9', 415, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2c05c23b-5d0c-4206-818b-3aa1b454cbe2', 416, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4400be97-9a40-4e38-9eab-f56421b392e2', 417, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a61c73ef-e36c-4165-818c-b3dde153d066', 418, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '199594d5-7503-4782-8952-71bb350c0ea7', 419, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1200fd9d-932a-46dc-b1f9-7c279921d83b', 420, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '02053a14-1e3a-4d25-bc98-50a51cefb3f2', 421, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9ee4058b-c1fa-4b5c-8b08-2f869f81fb1f', 422, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '96275e54-a693-46f6-a0c1-cede01b73bb4', 423, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '671e14cd-6886-4bee-b185-072559de7e4e', 424, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b37dcf57-54d8-4c24-9da3-d033e617d02e', 425, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c86fddfd-9707-4418-8a41-fdd4d850fc64', 426, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '36c45318-a7c6-4058-83e3-136c8983f89e', 427, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '432e0de3-2274-4c7c-8dea-a537340d2b0a', 428, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ebb662cd-5d9c-4070-8152-2600fb717d68', 429, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '11f836e9-4e14-479b-a9cb-3ef3719b1846', 430, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3bec55ec-a5da-4eb5-8e79-20efcd627391', 431, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e4d4d556-d39e-4839-84a6-7eaaba043d04', 432, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8d844300-d9e9-4d8f-835d-a313c7bb32d5', 433, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '660ac9c5-ea7b-4441-9451-46ec7b738823', 434, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3f95a2ed-dd3c-4990-8d9e-30d0d8304e40', 435, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6bfe333a-8307-4e1d-85cf-1698a3bcb10d', 436, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '81ed73a3-3a8a-44a7-896f-cfcf02958331', 437, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fcaa1354-7527-4f64-90b0-c0c91bc96dca', 438, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '15be453c-630c-45e7-9cbd-08cb0390730e', 439, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b38de712-2c99-4b48-bc20-6838806cd19f', 440, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eda913e1-4bda-4825-b40d-b146db9acba2', 441, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '498dda26-f947-4c66-8714-fb7443fa2f48', 442, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9570da14-6cae-4fcf-a798-6cd18fab00b3', 443, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'fd334e29-2b5c-4be9-916c-7647dbcf1d43', 444, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2660cf04-e354-46fa-9e5f-a2623a904fa6', 445, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2e27730c-a149-4222-93dc-efa43b13f3ef', 446, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eb6338c4-8f8f-4318-b19f-efb8fafab655', 447, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2cff6670-713a-4a08-8408-a9533ca8b8d0', 448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e1f9641a-a84c-4d97-ae29-03f68df04b07', 449, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '039fedc3-1936-41c5-a340-63b18b32f2fe', 450, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a23503e8-21cd-42f1-b38c-bd94a3059ae3', 451, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3216172c-a94a-40c1-aa3e-17d923349a60', 452, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '646559b8-6abe-4b66-99dc-209665da6db8', 453, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '54a154e8-09d8-4a67-8971-76b89d6567d3', 454, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1b7d85d6-a0e0-48a7-8740-059bbaadc616', 455, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1c36c1c3-430b-4110-8d83-eccf9d98a214', 456, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b1628155-9751-40f9-8731-5bb0a9a30029', 457, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2bfdb86f-4f6d-4a22-98b8-e2cfc151dd63', 458, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f6015b04-b743-4958-9a27-43c6d95caaa7', 459, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4b37cfe7-078c-42a0-a49e-98f888c2c882', 460, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e4a58da9-5256-489e-ae62-5245d9725e79', 461, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b434aaa7-29ce-4cf3-8adc-d6d515d8c3bd', 462, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'dddc4c2e-bbfa-4bad-8cb7-aff0f59a15aa', 463, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '71d14131-1692-465d-81a4-54a620de86c4', 464, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a98c0a51-5e5a-4072-bfb0-4499fa711b5b', 465, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a0f324cb-3c99-4541-bf30-0c7358a0303b', 466, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '278a2257-3718-427f-9e60-611dff50be75', 467, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7638c3b7-d6c8-4868-af85-9de066ecaec5', 468, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bb0fb102-9213-49d4-83bc-00a9a2036d91', 469, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aa1103f7-e873-4948-81f3-941d35926eac', 470, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a82399b9-be96-42e0-a615-1f457c4b6724', 471, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bd40e422-af08-4999-a912-d28734bc6a0a', 472, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '670cce26-b75f-48ca-aabb-709b69efa13a', 473, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3bf398a1-8aea-4c0a-b362-3639880fdbcc', 474, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e8ceefeb-d729-46e2-8161-8f85c2748d78', 475, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b9e84090-0c7d-46e3-b41a-876383927a22', 476, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f442f5e7-cf9d-4bdb-88a5-dd93ab5349bd', 477, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '7fe615c3-31ed-4cd8-afc3-cff032eb80a3', 478, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '42b5dc25-5718-411d-a36c-a9dc055e3270', 479, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '85b82927-888c-4709-9ffd-5b0a02375013', 480, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a1441a05-a943-4aef-9300-05a775daf826', 481, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2469444d-805e-49e1-a1e8-299c97a08dc1', 482, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '52c10c19-883b-43f8-9766-284550377716', 483, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6e9ae7fd-1f96-4d5c-a7b8-b63ac5ad02e3', 484, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '548e1327-0e1a-4f84-ac7d-c01bf18c1219', 485, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b703085c-39ba-487f-8db3-1d51df601cbf', 486, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4809123e-faa7-4bd9-a23b-dff1987b3dcf', 487, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3de7c69a-d18a-451a-a67b-b6a5682927b2', 488, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6a2d872f-8115-48b0-ac31-67bbe310f313', 489, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ab5ef2ea-d59d-45eb-b737-6ecccab47462', 490, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '62cc6692-6eac-43b7-9f2a-4769dfe9a3f8', 491, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '45671164-6a93-455b-b13f-a81f59b97e48', 492, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '0fde0346-39a0-4ce7-96ee-72857092c3f4', 493, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ec570195-9511-415e-941b-338c1f5184fb', 494, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd85562de-f803-4efb-874f-fbd84c8d3747', 495, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1340a81b-1758-45d4-8323-42949ea3a415', 496, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2142cc73-901b-441d-864a-725fec6c4a22', 497, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd08952f7-c180-4c05-8b97-4c00d2317e63', 498, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '906363b3-1867-49b4-9477-869f9ac0edb4', 499, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '90e9617f-839e-4143-9751-2bea7b0ba6a0', 500, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '05d5e1f2-2872-40a1-8a4e-2f44a64af41d', 501, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '412b7a3e-aafc-4d5f-b10b-91b5f922a93e', 502, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '69ecb300-9724-4872-abe0-8c9f787b5075', 503, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '95fd9410-3334-4f79-b3d4-ccc182ba76c9', 504, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '420abbdc-e878-4082-92b1-7c7150e7641f', 505, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4e393ada-13ca-4bf4-a353-f222e2f15811', 506, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '34217f8a-aab5-4597-b0a2-69fe46e648d3', 507, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a00f1252-941e-4459-9abd-cc6b77ff13f2', 508, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b431d37a-c5f9-40cd-9c78-6a5aeabeafad', 509, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd3d38238-a22e-456e-9a98-6d20b865cb63', 510, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8e4fac53-cedd-43df-a423-2562672e024a', 511, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '533019a1-cd5e-4216-a5d6-274727f9e3b4', 512, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3c390788-2049-4e65-b761-e704dc2d9cfb', 513, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2792c97d-3386-4aa9-9035-2f6357b00cfb', 514, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a7b893d8-f5ed-400c-a870-47b0b3a4eec9', 515, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'dfdcbf04-3124-4dc6-934d-5028b2102081', 516, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8066d49c-c61a-4dee-9342-b6d839b3fa5b', 517, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ace1a897-cef7-4192-9ba3-718bf543926e', 518, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'baf65a30-221e-4b93-952f-fc9d282af8e2', 519, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2b5ec388-ef9d-440b-ae55-a198bd0dbf04', 520, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd761c8c3-2b1d-4aed-aae9-1dc51e5fe961', 521, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '54a98601-0eae-44e3-8f29-6c129b7f6590', 522, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f3c16e64-bd07-4c10-a3cd-0ce2c3dfde88', 523, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bc49d400-23c1-4cec-8e2d-dbe621453e4f', 524, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b0fcdd42-3277-42a4-94eb-5a698ba34777', 525, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'ff93043b-7577-4ded-988c-29ab0346cca9', 526, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd408765b-9cc0-4668-b030-8c9086765a91', 527, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5441a07a-edba-4882-ab53-8e939ed3e242', 528, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd93b93de-52c7-4eeb-b660-0edb0a3215cf', 529, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b3f93310-cb6b-4afc-83e2-560dcd7c4d22', 530, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c9af66a3-5770-436b-8e53-6333a3185ac5', 531, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9b5b1045-cd55-4c4a-8e35-b974c300baa2', 532, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '69377eb6-05eb-417a-91f5-a38b71157a88', 533, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '03bcd081-78ff-40b5-888f-6356e9e3c367', 534, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '99e28c45-8554-40f2-a04a-4929339926b2', 535, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6d3a869d-f926-42c2-80c2-6a1d2e2d126c', 536, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'e422bb10-f883-4d2f-9f58-57011cff7d52', 537, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'cd5601e5-0137-40ad-b3d6-ea3b19b9af19', 538, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '8011c9e5-b101-4a13-9f49-f9a90ce330d6', 539, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'db31f7af-23f6-4f10-8c85-b95aa611db1b', 540, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '629cd8a7-c486-4545-8f4f-3940d79e61e4', 541, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '26903dc1-62b6-4e3c-829a-89fc33d17198', 542, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2911d181-fb66-429a-b53c-aea9f1e1e8be', 543, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2e002cf0-39c1-4f35-a4f1-ea3f56845751', 544, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd8f2dd28-5e50-4802-b7a0-c279abd6ff83', 545, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4a018177-8a06-462d-9101-45dc31e69117', 546, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1b5e9a31-46a9-47a2-968d-f3ae9d1e29ef', 547, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b397dad4-c48b-4a7a-a622-979bf6a7c404', 548, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '1f2de36c-8614-41a6-ac86-26a156ed5ef9', 549, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '519c8679-344d-4566-930f-c69f9823f20f', 550, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'aead7f60-a653-4e0e-9a45-a04a39f16aba', 551, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '46355500-23d1-413b-9e33-442fb992aca7', 552, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'b18cd9aa-e4ac-4556-94df-3cd0dee20663', 553, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '25bad5ed-f899-4199-b15b-a4885f32faef', 554, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd98893fd-7e92-4183-8311-cf03860584a1', 555, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '98b54608-3e04-4c42-94a6-9e0d60f920fd', 556, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9b5deb54-33ba-4953-a9ff-a41bae6ed1fa', 557, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '725022b5-7ef6-4056-a329-93f80eea7550', 558, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '3bff9763-a2e6-4bf5-b7ca-30b79de070ee', 559, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'c73affe6-d41c-4b42-b265-e7870231e12b', 560, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '6047c90b-49bb-4079-b5fe-32051c0c5e2e', 561, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '457d3f11-b565-4654-b609-6aea70217d48', 562, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'd86694a6-776e-40c7-8fe1-ba9310b93150', 563, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '980f6693-8f52-41dc-b991-cd4e790fe99c', 564, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '9173bcf0-d6a6-4cba-ba1c-dd655cd47cdc', 565, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '376b50d6-05a1-4dd8-8b46-8db0920feae5', 566, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'a8ea30dd-ee43-479c-83d2-b330ba0a481e', 567, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '303597ff-3c82-495a-aefe-8380aceee1ff', 568, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4ad7350d-0a4e-4e98-b88e-5f8f17856a5e', 569, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '72e6704a-08ac-4f41-8c57-0cbc0ef930fb', 570, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '22203633-d9cb-48d6-8e1f-3ccb91a2bb33', 571, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'eedd9e04-1e4d-4896-9cbf-b9f2a2c35a5a', 572, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'f0389d73-38ef-4cb4-9b3e-383a18a3a67c', 573, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4d6ec500-7430-416b-beb7-6bf0c67b71df', 574, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  'bbeaef77-2ebd-429c-8808-ce18718bb7f9', 575, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '387822e6-4829-4a37-aa4c-59bff9f6ddb3', 576, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '4861e716-3312-49c4-a24c-cf9a173cfd9b', 577, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '2b2a847e-2412-487a-ae66-3402552793bb', 578, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5ea58d1f-d1d5-4182-8a96-7879fd6d3331', 579, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '91722924-5ac2-406f-afff-f8a3fe68ff2f', 580, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '81bf8103-0171-4724-9ae6-2946c68648e2', 581, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);
INSERT INTO deals (id, deal_number, company_id, contact_id, gender, appointer_id, appo_date, meeting_date, meeting_time, appo_type, appo_target, list_id, memo, reminder_status, closer_id, meeting_result, order_result, yomi_status, loss_reason, next_action, next_action_date) VALUES (
  '5ea26e5b-7fca-4dae-8cc1-4d4605513016', 582, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ネタ', NULL, NULL, NULL
);

-- ============================================================
-- 6. Deal Followups
-- ============================================================
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7982de18-47e8-41a5-b845-633597169b34', '2d7f881d-104d-4d64-8fd9-fc77b8bb0fcd', 1, '2025-12-08', '00000000-0000-0000-0000-000000000001', '失注', '問い合わせフォームへの営業準備が出来次第、 対応を進めていく 1月以降は初期1万円となる これで1.5万円とのこと 案件自体はいつでも獲得可能 古物商のリスト確保ができるのかが鍵', NULL, NULL, NULL, '回答を行う', '2025-12-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c3fe70e4-66e4-4908-a475-2290608634b3', '2d7f881d-104d-4d64-8fd9-fc77b8bb0fcd', 2, '2025-12-03', '00000000-0000-0000-0000-000000000001', 'C', '◆ 商談内容サマリー（結論）  ダイバーシティオークションは、古物商保有者向けのオンライン完結型オークションプラットフォーム。 現在 689 会員 → 1 万社規模へ拡大を狙う成長フェーズ。 集客（会員獲得）は「紹介・広告」が中心で、自前のテレアポ体制はなし。  成果報酬型で新規会員獲得を外部営業代行に委託したい意向。 来年から入会金が 1 万円 →「成果報酬原資」として利用。 報酬イメージ：1件あたり 10,000〜15,000円で依頼したい。  ◆ ダイバーシティオークションの事業特徴 1. 事業概要  業者間の中古品売買オークションの運営（ブランド・時計・ジュエリー等）  すべてオンライン完結  出品者と落札者を両方集める BtoB2C モデル  7月以降：落札手数料 0円／入会金無料（キャンペーン）／年会費無料とハードル低めの仕様  2. 競合比較  大手では 月4億規模のオークションを週4回行う企業も存在  ダイバーシティはまだ規模は小さいが、料金の安さ・参入障壁の低さで差別化  機能差は小さいため、集客力＝勝負ポイント  ◆ 現状の課題  最終リスト（ターゲット企業の確度リスト）が不足  獲得チャネルが「紹介・広告中心」で、能動営業（架電）が弱い  会員数 689 → 目標1万社への拡張に対し、現行の集客ペースでは不足  テレアポ企業ではないため、代行の活用を前向きに検討している  市場が広いが、ターゲットがかなり細分化されるため、リスト要件の精度が必要  ◆ 会員獲得ターゲット（優先度付き） Aランク（最優先）｜即アポイントにつながる層  古物商許可（公安委員会）を保有する事業者  ブランド買取業者  時計・ジュエリー専門店  リユース店（大型除く）  楽天ショップ・メルカリショップ運営者（中古ブランド扱い）  Eウェイ（中古卸サイト）に出店している事業者  →「継続的に仕入れが必要なプロ事業者」。成約率が最も高い。  Bランク（中位優先）  せどり系 個人事業主（中古ブランド・時計）  フランチャイズ系買取店オーナー  ブランド品の卸・委託販売業者  →入会ハードルが低く、オンラインと相性が良い層。  Cランク（優先度低）  古着屋（今回のターゲット外）  低単価商材中心の業者  ◆ 現在の営業状況  会員数：689 → 直近 500件の新規流入あり（広告・紹介）  主要チャネル：  Google広告（1件あたり獲得単価 約1万円）  業界媒体掲載  紹介  テレアポは未実施（ノウハウなし）  ◆ 成果報酬の想定 ■ 報酬単価（先方希望）  1件あたり：10,000〜15,000円  来年からの入会金1万円をそのまま成果報酬の原資にする方針  ■ 受注要件  スクリプト・想定質問はすべて先方が保有しているため、 即時稼働可能な状態  ◆ 市場の特徴と営業戦略の前提 市場の特徴  楽天・メルカリ・Eウェイなど「オンライン物販」プレイヤーが膨大  古物商保有者は全国に 約25〜30万事業者  副業せどり系の参入増により、小規模個人が市場の半数以上  営業上のポイント  リスト精度 × 架電量 が売上を決める市場  オンライン完結型オークションは「仕入れの幅を広げたい層」に刺さる  特に ブランド・時計・ジュエリーは高確率', NULL, NULL, NULL, '回答を行う', '2025-12-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '25cc4073-cd08-451a-b4b4-43e50ad3d8f7', '2d7f881d-104d-4d64-8fd9-fc77b8bb0fcd', 3, '2025-12-08', '00000000-0000-0000-0000-000000000001', '失注', '問い合わせフォームへの営業準備が出来次第、 対応を進めていく 1月以降は初期1万円となる これで1.5万円とのこと 案件自体はいつでも獲得可能 古物商のリスト確保ができるのかが鍵', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5eb639db-e11e-4b02-8709-83126be6beaf', 'dd33cecc-9288-4379-8579-5dabeb45d1dd', 1, '2025-12-09', '00000000-0000-0000-0000-000000000001', 'B', 'A Iテレアポ 人数的にさいていない状況で、今回は人が一件づつ行う形で回っているので、 導入しないという結論となった  人材紹介系S E S、介護、看護関係)、BPO関係、派遣・、(証券会社、金融資産系、暗号資産系)口座開設 上記のリストをわたし、先方の方で取引先などのスクリーニングを行い、 リストをもらう その中に入っている会社であれば、1商談1.5万円の報酬で確定 これは進められる', NULL, NULL, NULL, 'AIテレアポの検討結果確認と、こちら側で可能かについて、回答', '2025-12-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fd5df6a8-081e-4cda-aaa7-86b4f8ffd55c', 'dd33cecc-9288-4379-8579-5dabeb45d1dd', 2, '2025-12-02', '00000000-0000-0000-0000-000000000001', 'C', '【商談報告書】インピネス株式会社（瀬戸様・野村様） ■ 商談テーマ  人材紹介系S E S、介護、看護関係)、BPO関係、派遣・、証券会社、金融資産系、暗号資産系 口座開設  成果報酬型アポイント提供／AIテレアポ活用の検討  ■ 商談結論（最重要）  AIテレアポの導入に前向き。来週中に最終検討結果が出る予定。  稼働については「すぐに対応可能」との認識を共有済み。  成果報酬型アポイントの単価は 1万円〜1.5万円 を想定。  ■ インピネス社の事業概要・背景  アドアフィリエイト会社（広告 × アフィリエイト）  得意ジャンル  人材系・金融系・ジム系（パーソナル・ピラティス）  ウェルネス・クリニック系も成約しやすい  HP制作・LP系、リード獲得系、スクール系も運用可能  手を出しづらいジャンル  EC系は難易度高い  ■ 同社のニーズ（今回のヒアリングから抽出） 1. 欲しいアポの種類  人材採用系（高需要）  金融系（成約率高い）  ジム関連（フィットネス/パーソナル/ピラティス）  2. 目的  アドアフィリエイト商材を成果報酬で運用  人材が勝手に流れてくる“案件供給の母集団”を作りたい  報酬として 1〜1.5万円/件 を許容  3. ターゲット企業  人材紹介・人材派遣系  金融商材（ローン/保険/投資）  パーソナルジム/フィットネス/ピラティス  ウェルネス/クリニック系（高い需要）  ■ 同社の強み・特徴  アフィリエイト実績が豊富  過去の 事務系ジャンルで月間大型集客実績 がある  自社独自の広告運用ノウハウ（バナー/動画/セグメント）  もともと広告代理店・システム開発との取引も多い  ■ 現状の営業課題  「アポ定義」が曖昧な企業も多く、予算感（50万円など）を引き出せないケースがある  アポの質がばらつき、  “話を聞くだけ”  “時間だけ取られる” → 商談にならないことがある  テレアポは形だけ実施しているが、CV単価は1.5万円付近に収束  300架電で4〜5件のCVが平均的  ■ AIテレアポ・成果報酬テレアポの活用意向 ● AIテレアポ  導入に前向き  来週中に社内判断  稼働は即可能  ● 成果報酬型アポイント  人材・金融・ジム領域は「完全成果報酬でも回せる」  成果報酬額：1万円〜1.5万円/件  責任者・担当者の同席も問題なし（呼び出し可能）  ■ 商材（インピネス側）  アフィリエイト運用代行（成果報酬型広告運用） → 企業側はリスクなく導入できるイメージ → 運用成果が出れば大きなCPが取れるモデル  ■ 次回アクション  来週：導入可否の最終回答を受領  成果報酬アポ提供の仕組み・オペレーションを提示  具体的なターゲットリスト案・アポ定義資料を共有  初月想定CV数・目標件数のシミュレーション提出', NULL, NULL, NULL, 'AIテレアポの検討結果確認と、こちら側で可能かについて、回答', '2025-12-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0c0fb21c-366c-47a6-926c-8a6bd58b46c3', 'dd33cecc-9288-4379-8579-5dabeb45d1dd', 3, '2025-12-09', '00000000-0000-0000-0000-000000000001', 'B', 'A Iテレアポ 人数的にさいていない状況で、今回は人が一件づつ行う形で回っているので、 導入しないという結論となった  人材紹介系S E S、介護、看護関係)、BPO関係、派遣・、(証券会社、金融資産系、暗号資産系)口座開設 上記のリストをわたし、先方の方で取引先などのスクリーニングを行い、 リストをもらう その中に入っている会社であれば、1商談1.5万円の報酬で確定 これは進められる', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4fac3d7c-9fce-4517-9261-379220497681', 'b7107c59-e4da-4f20-a410-f70fe3333ef2', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', 'いい話とはなったが、導入できない状況', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8a0f2609-bc0b-47bd-ae5a-106fa27e6307', 'b7107c59-e4da-4f20-a410-f70fe3333ef2', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', 'いい話とはなったが、導入できない状況', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b1a3f4ac-c554-40d8-ba12-19fd81003850', 'fe061661-2643-43e9-9c40-568b9f0f38cb', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', '売るものなし', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b96d87ed-faeb-4b2b-be08-574fab7ea98e', 'fe061661-2643-43e9-9c40-568b9f0f38cb', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', '売るものなし', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f8d9f2d7-c58f-4fbd-b046-2d5e203d66b8', '0bd0187b-975b-4177-8edd-0102be922214', 1, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '現時点で、販売可能なサービスなし', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5a8ebdce-1389-41c1-98ea-25f85f261b0c', '0bd0187b-975b-4177-8edd-0102be922214', 2, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '現時点で、販売可能なサービスなし', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '388b97cf-1fcc-42b9-b463-75a4b468ecfd', '0596ac84-557e-4151-8225-ba5c7679a42b', 1, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '自社サービスと被る部分があるため、導入不可', NULL, NULL, NULL, '折り返し待ち', '2025-12-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7b03f2f6-8672-476e-8e27-09620817606d', '0596ac84-557e-4151-8225-ba5c7679a42b', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー】ハイブリッド経営サポート株式会社 ■ 現状認識・導入検討状況  現在保有リストは 約1,000件 のため、テレアポ本格稼働は6ヶ月後を想定。  現時点では、フォーム営業／リスト作成／名刺自動フォローの3点に強い関心を示している。  ただし、初期費用が高い印象を持っており、 **「全部まとめて初期10万円で利用可能なら前向きに導入を検討」**との明確な価格条件を提示。  現在は デモ画面・ウェビナー動画の到着待ち。  ■ 具体的ニーズ・課題 ▼ 営業プロセス上の課題  普段の営業活動は「紹介のみ」で獲得しており、営業を積極的に行えていない。  名刺フォローは “ほぼ諦めている状態” で、自動化ニーズが高い。  メールマーケティングを強化したく、フォーム営業への期待値が高い。  ▼ リスト関係  行政書士のみのリスト作成を希望。  現状は 認定支援機関のリストを自力で取得しているが、効率化を求めている。  ▼ 商品ラインナップの要望  「意図的に拡販したい商材」があるため、売りやすい新商品を求めている。  ▼ その他背景  外国人ビザの取得時に診断士チェックが必要なため、士業向けの施策にも関心。  補助金申請を行っている 小野田さんとの接続を希望し、紹介予定。  ■ 体制・リソース  営業担当2名がスタンバイ済み（時給契約）。  メールマーケティング強化目的で、今回の導入を前向きに検討。  テレアポにも関心があり、 「将来的に電話もやらせてみたい」 と具体的に言及。  ■ 総評（導入確度）  導入のキーは 初期費用10万円以内に集約できるか。  フォーム営業×士業リスト作成×名刺フォロー自動化の3点セットをまとめて提案すれば、受注可能性は高い。  デモ・ウェビナーの提示後に再アプローチ推奨。', NULL, NULL, NULL, 'ウェビナーを送付', '2025-12-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2f165699-62af-42ee-b3ba-a1cefe6badef', '0596ac84-557e-4151-8225-ba5c7679a42b', 3, '2025-12-14', '00000000-0000-0000-0000-000000000001', 'C', '17日　電話不在　折り返し依頼', NULL, NULL, NULL, '折り返し待ち', '2025-12-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '90f467a7-9414-4562-b0f1-344d8bc32d2c', '0596ac84-557e-4151-8225-ba5c7679a42b', 4, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '自社サービスと被る部分があるため、導入不可', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '14cc3418-1b46-4075-ab54-91057f794716', '059f5e37-0cf0-4377-91c3-e6f3ccd79cb8', 1, '2025-12-03', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '29337bc8-ff87-4e61-8d02-99065f7b7eea', '059f5e37-0cf0-4377-91c3-e6f3ccd79cb8', 2, '2025-12-03', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9537e820-79d1-467b-85a4-dc713d339928', 'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 1, '2026-02-06', '00000000-0000-0000-0000-000000000001', '受注', 'チャットワークにて契約調整中', NULL, NULL, NULL, '入金済み', '2025-12-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '78ac5ec4-d8ba-4cdf-a37f-b64737f79772', 'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー｜株式会社アプクロ 佐藤様】 1. テレアポ体制（現状の営業オペレーション）  直営テレアポ部隊：30〜50名規模  架電量：毎日3,000〜5,000件（＝月6〜10万件規模）  リスト：自社で十分保持しており、量に困っていない  1日あたり 約30件の案件を創出しているイメージ（推測）  ＝完全に“量産型テレアポモデル”。AIとの親和性が非常に高い。  2. 現状課題（推測ベースで整理）  数字・発言から読み取れる課題は下記の通り。  ① 人数依存（30〜50名 × 架電数）の属人構造  人数と精神耐性（離職）に強く依存するため、コスト・品質が安定しづらい。  特に架電量が非常に多いため、AI移行のメリットが最大化しやすい。  ② コール単価を下げたい（固定費の圧縮）  月6万〜10万件を“人手”で回すと、 　1件あたり20〜35円のコストが発生している可能性が高い。  → AIなら「1件0.5円〜3円」にできるため圧倒的に相性◎。  ③ 成果のばらつき（人により差）  受電・架電の質が安定しない  労務管理が重い  モニタリングに限界  ④ 深夜・休日の架電不可  → AIなら時間帯の制限が少なく、特に土日稼働が効く。  3. AIテレアポに対する評価・温度感  佐藤さんは、 「最終的にはAIが一番良い」と明確に判断している。  理由は以下：  架電量が多すぎて、人手だと採算が悪い  オートコール化できれば費用対効果が圧倒的  月額20〜30万円なら試しやすい  導入までのハードルが低い （＝初期費用が安いほうが良い）  → 今月〜1月の導入意欲あり（導入前提の“温アツ”状態）。  4. 打ち手（次アクション） ■① 初期費用：50万 → 10万円に調整済 → OK  → これは心理的ハードルを大幅に突破した重要な一手。  ■② 月額プラン：20万円 or 30万円  → “まずは試してみよう”という温度なので、 20万円スタート → 数値改善で30万円 / 架電量追加の提案が最適。  ■③ 推奨：PoCプラン（1〜2ヶ月検証）  AIテレアポの王道は「短期の成果測定」。  1万件テスト架電  接続率・反応率・AHT  成果比較（人 vs AI）  有効アポ数比較  5. 営業戦略上の着眼点（Gちゃん社内用） （1）アプクロはAIテレアポのドンピシャ顧客  大量コール  人数依存型  リスト大量  コスト最適化が喫緊課題  現場の負荷が高い  ＝まさに「AIテレアポ化すべき会社」の代表格。  （2）導入時期が近い → 失注リスクをゼロにする  12月〜1月スタートと明言 → ここで失注すると競合に入られる。  最速で「導入ロードマップ」を渡すべき。  6. すぐ送るべきフォロー案（送付文章の要約）  以下のような形で送れば、プロとしての信頼が一段上がります：  導入の流れ（3ステップ）  初期費用10万円の提示  月額20万円でPoC開始案  1月スタートのためのスケジュール  文章が必要ならすぐ生成します。  7. 結論：この案件は“入り切っている”ので落とせる  課題とAIの解決相性が極めて高い  導入意欲あり  価格も納得済み  タイミングも1月で確定  、この案件は“確実に取り切るべき”案件。 来期の好スタート案件として最適です。', NULL, NULL, NULL, '検討状況確認', '2025-12-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6d195472-03f6-4e39-a367-8ef87007543b', 'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 3, '2025-12-14', '00000000-0000-0000-0000-000000000001', 'A', 'AIテレサポ申し込みを行うとのこと 見積もり、契約書準備中', NULL, NULL, NULL, '申し込み回収', '2025-12-14'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0f6788a9-3f23-4adc-bca0-3e6f727fbcec', 'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 4, '2025-12-23', '00000000-0000-0000-0000-000000000001', 'A', 'リーガルチェックで、チャージの件確認され、 回答したことで、今日、明日には契約書を進められるとのこと 改めて、メールで連絡が来る状況となるので、クラウドサインで契約となる', NULL, NULL, NULL, '契約書送付', '2025-12-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1ec5718d-2d7c-4577-9ba6-4ecf69f196cf', 'aff428eb-1c1c-4a95-9168-c6cc3d4b25e3', 5, '2026-01-05', '00000000-0000-0000-0000-000000000001', 'A', 'チャットワークにて契約調整中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd5a0ee8f-a5c2-41fc-ab06-6fc0cc090fb7', 'b56a5776-53e9-48b3-83d9-f63963f63776', 1, '2025-12-16', '00000000-0000-0000-0000-000000000001', '失注', '導入後キャンセル', NULL, NULL, NULL, '申し込み回収', '2025-12-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '999992c5-a1e8-4772-8d0b-e0a51cb6ae25', 'b56a5776-53e9-48b3-83d9-f63963f63776', 2, '2025-12-09', '00000000-0000-0000-0000-000000000001', 'C', '株式会社AO 吉川悠太様 商談内容まとめ 👤 相手先情報 企業名: 株式会社AO  ご担当者名: 吉川 悠太様  事業内容: WEB制作 (URL: https://aoco.jp/profile/)  🤝 商談の状況と結果 議題: AIテレアポサービスの提案  現在の評価: 月額20万円での利用に「非常にいい」と好印象。  今後の商談予定: 11日 15:30 (※可能であれば早めたい意向あり)  交流開始: 11月から交流会を通じて。  🤖 AIテレアポサービスへの具体的なニーズ 吉川様は、以下のフローでのAIテレアポの活用に強い関心を示しています。  活用イメージ:  自社で集めたリストに対し、AIでアンケート連絡を実施。  アンケート結果からニーズのある顧客を抽出。  ニーズのある先に対し、人が直接連絡を行う。  📈 その他の関心領域 (未説明部分) AIテレアポ導入以外にも、以下の機能・サービスに興味を示されていますが、詳細はまだ説明しきれていない状況です。  問い合わせフォーム営業  名刺フォロー  リスト作成  💻 株式会社AO様の事業と注力分野 一番の注力分野:  ECサイト制作 (50万円以上の案件)  その他の注力分野:  Instagramの運用  広告運用  📊 営業・集客に関する現状と課題 年間契約者数: 約40社  主な流入経路:  ホームページからの問い合わせ: 月1〜2件  ウェブ関連の広告  営業目標/実績 (ウェブ関連):  月間商談数: 3件  成約数: 1件決まれば良い程度  オフライン営業:  名刺フォローや再アプローチの必要性を感じている（名刺ストック：100枚）  商工会議所の会員向けの折り込みチラシ  アウトバウンド営業:  XやInstagramのDM  フォーム営業 (現状):  過去に依頼経験あり。  コスト感: 1件10円 (リスト用意は自社で5円/リスト)  懸念点: フォームが弾かれるのではないかと懸念しており、AIテレアポへの興味に繋がっている。  IT導入:  来年からのIT導入を検討中。  💡 今後の商談に向けて AIテレアポの**「自社リストへのアンケート活用」**という具体的なフローに沿った提案を強化する。  月額20万円という金額は好印象のため、その費用対効果をさらに具体的に示す。  吉川様が興味を示している問い合わせフォーム営業、名刺フォロー、リスト作成といった機能についても、AIテレアポとの連携や具体的なメリットを説明する準備をする。  吉川様の最注力分野であるECサイト制作やInstagram運用といったサービスへのリード獲得に、どのようにAIが貢献できるかを具体的に提案に盛り込む。', NULL, NULL, NULL, '際商談', '2025-12-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '679570ac-4871-4003-a80d-5471709d075e', 'b56a5776-53e9-48b3-83d9-f63963f63776', 3, '2025-12-10', '00000000-0000-0000-0000-000000000001', 'A', '株式会社AO ツバメリード リスト作成AI 月額合計8万円 初期0円  こちらの内容で、契約決定となりました。 まずは2ヶ月ほど試したいということですので、 申し込み方法を教えていただきいたいです。 今日中に契約したいと思っておりますので、よろしくお願いします。', NULL, NULL, NULL, '申し込み回収', '2025-12-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e6d03501-c773-4313-b5a8-87716747fc43', 'b56a5776-53e9-48b3-83d9-f63963f63776', 4, '2025-12-16', '00000000-0000-0000-0000-000000000001', '受注', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '369e973f-8e7c-4d68-8f2f-497ac22ea68d', 'b56a5776-53e9-48b3-83d9-f63963f63776', 5, NULL, '00000000-0000-0000-0000-000000000001', '失注', '導入後キャンセル', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ff72f411-1ce6-4e2d-bbf7-57bb71bbe5e5', 'a751609b-a838-4f03-8b89-29094d7f28ad', 1, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fd5b3f99-dbd6-4862-bd3a-9e4ba46a71e3', 'a751609b-a838-4f03-8b89-29094d7f28ad', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'eba6d7be-ab5d-4374-85da-c94e0a1f4be4', '0e097a66-eb1e-4b7b-ac17-6f20fa1f3756', 1, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '746e2fc2-acfb-4b76-9adc-226815f63925', '0e097a66-eb1e-4b7b-ac17-6f20fa1f3756', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8ee9b4dc-e2df-4a46-8234-5e7794d65e74', '1733bab6-fd1d-49f1-bb85-b385221f3f7a', 1, '2025-12-25', '00000000-0000-0000-0000-000000000001', '失注', '"売上の3% 継続率が高い" 年間売上が30万円〜40万円で、事業場が増える案件もある  営業代行の点でも3%の報酬との事で安すぎるため、今回はNG', NULL, NULL, NULL, 'メールにて検討状況確認', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c468405c-470a-446c-a8e6-de11a0b7c48c', '1733bab6-fd1d-49f1-bb85-b385221f3f7a', 2, '2025-12-14', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー】株式会社ヘルスインテクト  担当：代表取締役 村田 旬作 様 対応：小貫（Gちゃん） 所在地：東京都港区港南2-15-1 品川インターシティA棟28階 TEL：03-6717-2895 Mobile：070-3839-1981 Email：murata@healthintect.co.jp  HP：healthintect.co.jp  1. クライアント概要（産業医支援 × 中小企業特化）  中小企業向けの産業医導入支援を提供  既に 50社以上へ導入実績あり  村田社長1名＋業務委託1名で対応  中小企業で産業医が機能しづらい課題を解消するため、  スケジュール調整  雑務・細かい業務の巻き取り  衛生委員会立ち上げ  議事録作成 など、バックオフィス側まで包括サポートしている点が強み  産業医契約は法律で継続性が担保されるため、解約率が極めて低い（＝超ストック型）  2. 営業の現状・課題 ■ 現状  新規の獲得経路は  紹介（士業・社労士）  HP問い合わせ：月2〜3件（30件の反響データ）  現状、村田社長がすべての営業を一人で対応  外向きの新規アプローチはほぼ実施していない  ■ 課題  新規企業獲得をスケールさせる手法が不足  代表1名体制で“紹介依存”になっており、仕組みの強化が必要  問い合わせはあるものの、能動的に案件を増やす導線がない  法改正がない限り継続売上が強いのに、マーケットアプローチが弱い  3. 今回の提案内容（小貫より）  問い合わせフォーム営業 × リスト作成 × 自動化の導入  同領域の他社と比較し、 → 費用対効果が最も安定的に出るという説明  初期費用：5万円  月額：各施策を組み合わせて調整  産業医が必要な企業リスト（労働者50名以上）をターゲットセグメント化して営業  紹介・問い合わせだけでは取りきれていない層への能動アプローチを強化  4. 先方の反応・意向  フォーム営業代行会社との比較検討を希望  すぐの契約判断というより、 → 「検討状況の整理に1週間ほどほしい」  メール連絡を希望（murata@healthintect.co.jp ）  外部向け営業の必要性は認識しており、 → 新規10社/年の目標は継続したい  契約はサブスク色が強く「長期取引になる」点は理解しているが、無理な営業は避けたい姿勢  交流会経由でのつながりのため、印象は良好  5. 商談の重要ポイント（意思決定に直結）  産業医契約は一度取れれば強烈なストック化（解約率ほぼゼロ）  労働者50名以上の企業は法律で“産業医必須” → ターゲット明確  紹介だけでは取り切れない新規企業を、 → フォーム営業×リストで能動獲得できる構造を作れる  他社比較中のフェーズのため、 → “費用対効果のロジック”をこちらから明確に提示した方が勝ちやすい  6. 次アクション（ToDo） 【Gちゃん側】  ① 比較検討用の提案資料（初期5万円／運用プラン／効果シミュレーション）を作成  ② 産業医向けフォーム営業テンプレの共有  ③ 50名以上企業向けターゲットセグメント案の提示  ④ 1週間後のフォローメールを事前にドラフト作成  【村田社長側】  ① 他社との比較  ② 導入方法（直契約か段階導入か）の検討  ③ メールで連絡待ちの状態  7. 総括（エグゼクティブコメント）  産業医ビジネスは、  法律で需要が固定  契約後の継続性が極めて高い  中小企業は放置されがちで市場未開拓  という“美味しい市場”。  Gちゃんのフォーム営業×自動化モデルとの相性は極めて高く、 村田社長の“1人営業体制”の課題を一気に解消できる。  比較検討のフェーズをどう勝ち切るかが勝負。 次回フォローはメールがベスト。', NULL, NULL, NULL, 'メールにて検討状況確認', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd7614714-e62d-4ab9-a41f-2c4c9331d9f7', '1733bab6-fd1d-49f1-bb85-b385221f3f7a', 3, '2025-12-25', '00000000-0000-0000-0000-000000000001', '失注', '"売上の3% 継続率が高い" 年間売上が30万円〜40万円で、事業場が増える案件もある  営業代行の点でも3%の報酬との事で安すぎるため、今回はNG', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e72ba7d3-3ef2-43d0-bd63-2abdc7fd4fbd', 'c30f62e0-b2b9-41ce-9d96-e91d4ab384f5', 1, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '直近の導入は難しいとのこと', NULL, NULL, NULL, '携帯に連絡し検討結果を確認', '2025-12-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6b5ef416-08c2-4208-8bf9-93068c96fe89', 'c30f62e0-b2b9-41ce-9d96-e91d4ab384f5', 2, '2025-12-10', '00000000-0000-0000-0000-000000000001', 'C', 'ご提示いただいたメモを元に、チーム共有やSFA（営業支援システム）への入力に最適な形式で商談内容を整理・要約しました。  商談報告：合同会社RISOOO DESIGN ■ 基本情報  顧客名: 合同会社RISOOO DESIGN（リソーデザイン）  担当者: 浅野 貴宏 様  URL: https://risooo-design.website/#service  事業内容: ブランディング支援、LP制作  ■ ネクストアクション（最重要）  期日: 12月19日（木）  アクション: 携帯へ電話し検討結果を確認。  クロージング条件: 12月中の申し込みであれば0円で実施可能と提示済み。  1. 顧客サービス・強み 主力商材: LP制作（単価35万円）。  サービス内容: 制作に加え、半年間の伴走支援を行い、分析データを元に改善を実施。説明のしやすさが売り。  独自の強み（USP）:  行動経済学を用いた設計（人の心理に沿った色やデザインの構築）。  紹介のみで年間60件（60社）の受注実績あり。  関連企業: グループ企業が6社あり、会長が存在。「株式会社ソル制作」が販売経路拡大に関与している模様。  2. 現状の営業体制・課題（As-Is） 新規開拓手法: 現状は「紹介」と「名刺交換」がメイン。  グループ独自の交流会などで名刺を獲得している。  名刺管理・追客:  交換した名刺はオンライン秘書に送付（月額2万円）。  課題: 指示がない限り動かない受動的な体制であること。  アウトバウンド: 現状は未実施。  3. 今後の展望・ニーズ（To-Be） FC展開（来年4月〜）: LP事業をフランチャイズ化したい意向。  直近のニーズ:  FCオーナー開拓: テレアポ等でオーナー候補を探したい。  案件獲得: FC展開を見据え、制作案件そのものも増やしたい。  ボトルネック: ターゲットリストの枯渇、アプローチ不足。  4. 提案内容と反応 提案商材:  フォーム営業（自動送信）  名刺フォローAI  営業リスト作成  顧客反応:  内容は「非常に良い」との高評価。  FCオーナー開拓のためのテレアポ、案件獲得のためのフォーム営業に関心あり。  既存の名刺資産活用として、名刺フォローも提案済み。', NULL, NULL, NULL, '携帯に連絡し検討結果を確認', '2025-12-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '412d047d-7c2d-4ed0-b3e9-4a11ceb9caf0', 'c30f62e0-b2b9-41ce-9d96-e91d4ab384f5', 3, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '直近の導入は難しいとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e11fb58f-4fea-4919-af8c-a9f874715161', '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 1, '2025-12-30', '00000000-0000-0000-0000-000000000001', '受注', '初期5万円　月額11万円　名刺フォロー、問い合わせフォーム、リストAI', NULL, NULL, NULL, '回答', '2025-12-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e4b84fdf-76d4-452b-8368-6e928d4d5b3c', '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 2, '2025-12-14', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー】株式会社インクリット  担当：久保田 裕助 様 対応：小貫（Gちゃん） 所在地：兵庫県神戸市灘区水道筋5丁目2-15 アーバン王子公園203 TEL：080-9722-9962 URL：https://inclit.jp/2  1. クライアント概要（補助金・助成金特化の支援会社）  月額1万円〜5万円の補助金・助成金サポートサービスを展開  IT導入補助金を中核に、来年度からは全ての補助金・助成金（23業種）に対応  3月だけで5社立ち上げなど、案件増加傾向  エネルギー系（太陽光・水素・蓄電池・バイオマス）、美容系（幹細胞・育毛）など多業種に関与  “パッションが強い”評価を周囲から受けるタイプの営業スタンス  2. 現状の営業体制・課題 ■ 営業体制  営業代行4社をすでに導入（プラットフォーム形式）  成果報酬型2社も稼働中  1アポあたり5万円で購入（担当クラス関係なく固定）  ※質が悪いアポも混在し、費用対効果がブレている問題あり  ■ 課題  新規顧客開拓の効率化が急務  アポ単価が高騰しており、歩留まりが低い  4月以降の公募要領変更に伴う情報のアップデートと体制強化が必須  補助金は“事業準備期間”が重要 → 3ヶ月前倒しの仕込みが必要  3. 今回の提案ポイント（小貫より） 提案内容  フォーム営業 × リスト作成 × 名刺自動フォロー × AI支援のフルセット  初期費用：5万円  月額：11万円  補助金LPからの直登録 → 契約につながる導線構築を推奨  補助金特化の獲得モデルと相性が良いため、問い合わせフォーム営業との親和性が高いと説明  リスト関連の補足情報  BtoCリスト購入事例  株式会社エナジー：  1,000件：55万円  ※倒産リストを使った角度の高い営業も可能  担当：女性の福田さん  4. 先方の意向・反応  すぐにでも助成金・補助金領域の営業強化はしたい  1月7日までのIT導入補助金が大チャンスという認識を共有  4月の公募要領変更に向け、 → 「今から3ヶ月で営業体制を整えるか」 → 「4月スタートにするか」 という2軸で検討中  新規開拓強化の必要性は強く感じている  「代理店としての拡張」や「実質0円導入（貸付）」など、提案に柔軟  久保田さん自身が非常に熱量高く、“動きが早いタイプ”  5. 商談の重要ポイント（意志決定に直結する論点）  補助金商材 × 問い合わせフォーム営業の相性が抜群 → “応募したい企業”は必ずウェブフォームを持つ  アポ5万円時代からの脱却が急務 → 本サービスは定額11万円でアポ獲得効率を平準化できる  来年度（4月）の公募要領変更前に体制を固める必要がある  補助金市場はスピード勝負 → 1月〜3月が“勝負のQ”  6. 次アクション（ToDo） 【Gちゃん側】  ① LPリンクの共有と接続導線の整理  ② 今回の提案内容（初期5万／月額11万）の正式見積資料を送付  ③ 補助金領域のフォーム営業テンプレ・成功事例の準備  ④ 1月7日までのIT導入補助金向け短期スプリント提案書の作成  【インクリット側（久保田様）】  ① 導入開始時期の最終判断（今すぐ開始 or 4月スタート）  ② 提案LPの確認  ③ 新規開拓の重点業種・優先順位の選定  7. 総括（エグゼクティブコメント）  今回の案件は、補助金市場の“波”が明確に来ている中、 Gちゃんのフォーム営業・リスト自動化スキームと インクリット社の補助金特化モデルが非常に相性の良い組み合わせ。  特に  アポ単価5万円問題  公募要領変更前の重要3ヶ月 ここを踏まえると、今すぐ着手する価値が極めて高い案件。', NULL, NULL, NULL, '検討状況確認', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9e2e631a-cd26-42fa-9b37-f429cd31bf64', '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 3, '2025-12-23', '00000000-0000-0000-0000-000000000001', 'C', '今かなり忙しい状況で、 金曜日までには回答できるようにするとのこと 脳のリソースを検討に使えていないとのこと 引越し中で', NULL, NULL, NULL, '回答', '2025-12-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '91858f57-98c3-48e9-906d-65f850811bb5', '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 4, '2025-12-26', '00000000-0000-0000-0000-000000000001', 'A', 'ほぼほぼ導入に前向きではあるものの、 金種のの方がお金を入れてこなくて、その金策に走っている状況となる 金、土、日の中で決定できるようにするとのこと  株式会社インクリット 氏名：久保田ユウスケ メールアドレス：kubota@inclit.jp 携帯番号：080-9722-9962  月額11万円', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c5786031-a221-4adc-a940-5d7aec22417b', '81a7ba37-ebf8-46d6-b779-4b4bc6ee18de', 5, '2025-12-30', '00000000-0000-0000-0000-000000000001', '受注', '初期5万円　月額11万円　名刺フォロー、問い合わせフォーム、リストAI', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a42b4bf4-8389-488c-9c78-51b2c430e4e6', '7ddeb095-d5d8-4229-afba-afea74390100', 1, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b6408b51-40d4-4986-836c-115403ff9aa3', '7ddeb095-d5d8-4229-afba-afea74390100', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7c85db2e-175c-4a47-8b30-72eb2eba3777', 'edda3d78-a647-4a2a-8925-9ac37f6c62e6', 1, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '商談相手が退社となってしまっているため、失注とする', NULL, NULL, NULL, 'お繋ぎか可能か確認', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fd12065d-3131-409d-a0dc-8364da6c2a9a', 'edda3d78-a647-4a2a-8925-9ac37f6c62e6', 2, '2025-12-08', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポの件で検討中となるが、 12月が営業組織の責任者が忙しいらしく、 1月にでタイミングが合えばお繋ぎいただける', NULL, NULL, NULL, 'お繋ぎか可能か確認', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0a01b97e-b3c9-448b-b6fb-391f81481034', 'edda3d78-a647-4a2a-8925-9ac37f6c62e6', 3, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '商談相手が退社となってしまっているため、失注とする', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '515d1f1f-1d4e-4470-a1a5-7ac2c15960b3', '3f3b6e1c-9691-4c54-8cca-721d62115ef2', 1, '2025-12-23', '00000000-0000-0000-0000-000000000001', '失注', 'お世話になっております。  お電話出れず申し訳ございませんでした。 社用携帯を手元に置けておらず、、  社内で検討しましたが、フォーム営業もテレアポも目下は既存の方法で進めることといたしました。  また時期が来ましたらご相談させてください！', NULL, NULL, NULL, '検討結果確認', '2025-12-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '59ad191e-528c-4558-aa3e-b4b3b9cbafb9', '3f3b6e1c-9691-4c54-8cca-721d62115ef2', 2, '2025-12-12', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜株式会社Shiiiro（担当：チョウ ソギョン様）  ■ 基本情報  氏名：チョウ ソギョン 様  メール：sukyeong@shiiiro.co.jp  TEL：080-3474-9691  体制：共同代表 3名による協議で意思決定  回答予定日：12月19日  1. 現状の営業体制と課題 ◆ 営業体制  営業専任者は不在（紹介経由が中心）。  代表自身がアウトバウンド活動（交流会参加）を実施。  1人で成果を再現できる仕組みづくりを希望。  ◆ 営業活動の実態  問い合わせフォーム営業：社内で実施  作業自体は業務委託（1通あたり5円、未送信でも1円）  1000件単位で運用、1週間程度で消化  月2〜3万円程度のコスト  リスト作成：手動＋スクレイピング活用  主にデザイン会社向け  精度改善を希望  ◆ 他社事例（気になっているサービス）  交流会で出会ったテレアポ会社  1アポ1万円  電話→LP送付→アポ獲得という流れで成果が出ているとの情報  アウトバウンド運用に関心あり  ◆ 営業課題  安定したリード獲得基盤がない（紹介依存）  休眠顧客のフォローが手つかず  リスト精度が低く、負荷が高い  無形商材の販路拡大が優先テーマ  2. Shiiiroの事業と特徴 ■ 事業領域  製造業向けDM支援（10日の交流会でのトピック）  AIを組み込んだシステムの開発・運用  無形商材の販路拡大支援  インバウンド施策（SEO・ウェビナー）にも取り組み  ■ 強み  代表が**元・製造業（生産技術職）**で、工場ラインの理解が深い  前職ネットワークや業界特性を理解して提案できる  現在は紹介が中心だが、プロダクトの質は高評価されやすい  3. 提案に対する反応・検討ポイント ■ 前向きに評価されたポイント  問い合わせフォーム営業（自動化）  リスト作成の効率化・精度向上  休眠顧客フォローのAI自動化にも興味あり  全体として「非常に良い」との評価  ■ 導入可否の基準  代表3名での協議  19日に最終回答  ■ 検討中の料金帯（こちらの提示）  初期費用 0円  月額 11万円  4. 今後の展開機会（Cross-sell / Up-sell）  問い合わせフォーム営業 → 自動化フロー全体の設計  リスト作成をAI＋スクレイピングで完全効率化  休眠顧客・既存顧客フォローの自動化AI  アウトバウンド強化（AIテレアポ／1アポ◯円モデル提案も可）  製造業向けのDM支援 × リスト生成 × AIフォローの統合支援  5. 次アクション  12/19：返答待ち（共同代表3名協議）  必要であれば、  お試しミニデモ  フォーム営業の具体的な数値サンプル  休眠顧客自動化の設計例 を共有するとCV率向上が見込める。', NULL, NULL, NULL, '検討結果確認', '2025-12-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1613763d-19fa-4363-98d1-2772106ea6d8', '3f3b6e1c-9691-4c54-8cca-721d62115ef2', 3, '2025-12-23', '00000000-0000-0000-0000-000000000001', '失注', 'お世話になっております。  お電話出れず申し訳ございませんでした。 社用携帯を手元に置けておらず、、  社内で検討しましたが、フォーム営業もテレアポも目下は既存の方法で進めることといたしました。  また時期が来ましたらご相談させてください！', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1333b519-4e6e-476d-adb0-736b3089f0a2', '33cbe75f-a240-44bc-9426-c1fc67489b9e', 1, '2025-12-12', '00000000-0000-0000-0000-000000000001', '没ネタ', '【商談サマリー】(株)ジェイビルド 浜水 純 様 ■ 基本情報  氏名：浜水 純 様  接点：交流会を通じてコンタクト  会社規模：従業員数 4名  事業領域：外装（防水・塗装・下地）、内装、リフォーム、改修工事  受注形態：紹介経由が中心。元請として入りつつ、一次・二次請け案件も対応。  ■ 現状と課題認識 ▼ 1. 営業体系の未整備  営業フロー／サービス体系がまだ確立されておらず、 **「仕組みが整ってから導入したい」**というスタンス。  現時点では長期案件として見込むのが妥当。  ▼ 2. 受注経路は紹介・業界ネットワークが中心  既存案件はほぼ紹介と、工事会社・不動産会社など横のつながりからの依頼。  新規開拓の経験・仕組みはまだ十分でない。  ▼ 3. 今後は“営業拡大”を明確に意識  紹介中心から、新規営業の強化に興味。  ただし、体系化した営業オペレーションの構築が先行課題。  ■ 顧客のニーズ（顕在／潜在） ◆ 顕在ニーズ  施工品質には自信があるため、安定的な案件供給の仕組みを整えたい。  営業活動を強化したいが、具体的な方法や体制がまだ不明確。  ◆ 潜在ニーズ  ・施工業向けの新規リード獲得  ・問い合わせフォーム営業  ・AIテレアポ（外装・内装領域はリスト精度も高く、相性◎）  ・名刺・紹介ネットワークの自動フォロー  ・営業提案資料や受注率向上のためのトークフロー整備  ■ 本商談のポイント  導入意欲はあり、ただし「営業体系を整えてから実装」したい意向。 　→ 仕組みが整ったタイミングで一気に導入する可能性が高い。  事業は職人品質×紹介中心で安定しているため、営業導入の伸び代が大きい。  短期案件ではなく、中長期フォロー必須の見込み顧客。  ■ 今後の打ち手（次回アクション）  営業フロー標準化のテンプレ例（建設業向け）を共有して、 「体系化 → 導入」のイメージを持ってもらう。  外装／内装／リフォーム業に特化した フォーム営業・AIテレアポの成功事例を提供。  来期の営業戦略立案タイミングに合わせて、 必要パーツ（リスト作成・AI架電・自動フォロー）のパッケージ提案を行う。', NULL, NULL, NULL, '営業状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '87d3d94b-f1b3-4bfd-98cf-1f7288c0901f', '33cbe75f-a240-44bc-9426-c1fc67489b9e', 2, '2025-12-12', '00000000-0000-0000-0000-000000000001', '没ネタ', '【商談サマリー】(株)ジェイビルド 浜水 純 様 ■ 基本情報  氏名：浜水 純 様  接点：交流会を通じてコンタクト  会社規模：従業員数 4名  事業領域：外装（防水・塗装・下地）、内装、リフォーム、改修工事  受注形態：紹介経由が中心。元請として入りつつ、一次・二次請け案件も対応。  ■ 現状と課題認識 ▼ 1. 営業体系の未整備  営業フロー／サービス体系がまだ確立されておらず、 **「仕組みが整ってから導入したい」**というスタンス。  現時点では長期案件として見込むのが妥当。  ▼ 2. 受注経路は紹介・業界ネットワークが中心  既存案件はほぼ紹介と、工事会社・不動産会社など横のつながりからの依頼。  新規開拓の経験・仕組みはまだ十分でない。  ▼ 3. 今後は“営業拡大”を明確に意識  紹介中心から、新規営業の強化に興味。  ただし、体系化した営業オペレーションの構築が先行課題。  ■ 顧客のニーズ（顕在／潜在） ◆ 顕在ニーズ  施工品質には自信があるため、安定的な案件供給の仕組みを整えたい。  営業活動を強化したいが、具体的な方法や体制がまだ不明確。  ◆ 潜在ニーズ  ・施工業向けの新規リード獲得  ・問い合わせフォーム営業  ・AIテレアポ（外装・内装領域はリスト精度も高く、相性◎）  ・名刺・紹介ネットワークの自動フォロー  ・営業提案資料や受注率向上のためのトークフロー整備  ■ 本商談のポイント  導入意欲はあり、ただし「営業体系を整えてから実装」したい意向。 　→ 仕組みが整ったタイミングで一気に導入する可能性が高い。  事業は職人品質×紹介中心で安定しているため、営業導入の伸び代が大きい。  短期案件ではなく、中長期フォロー必須の見込み顧客。  ■ 今後の打ち手（次回アクション）  営業フロー標準化のテンプレ例（建設業向け）を共有して、 「体系化 → 導入」のイメージを持ってもらう。  外装／内装／リフォーム業に特化した フォーム営業・AIテレアポの成功事例を提供。  来期の営業戦略立案タイミングに合わせて、 必要パーツ（リスト作成・AI架電・自動フォロー）のパッケージ提案を行う。', NULL, NULL, NULL, '営業状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7cadb27d-b2f0-4e58-bdb7-08c8a92a0221', 'f821b6c1-3d94-4295-9070-5dd275e387fe', 1, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '自社で導入されている状況とのこと', NULL, NULL, NULL, '契約書対応予定', '2025-12-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2f4d988c-65df-48ec-ab5f-c2a64998a200', 'f821b6c1-3d94-4295-9070-5dd275e387fe', 2, '2025-12-14', '00000000-0000-0000-0000-000000000001', 'C', '■ 商談サマリー（オイカゼ / 大村祐貴 様） ■ 商談相手  氏名：大村 祐貴 様  メール：yukiomura1121@gmail.com  TEL：080-1729-7445  属性：フリーランス型の動きで営業マン不在。紹介経由の案件獲得が中心。  ■ 現状整理 ◆ 営業スタイル  ほぼ 紹介メインで案件獲得（年間の取引先は10社未満）。  紹介元は3社ほどに限定されており、安定はしているものの、再現性の高い新規獲得チャネルが弱い。  Web問い合わせは 数ヶ月に1件レベル。  テレアポはほぼ行っていない。  ◆ リード状況  月間リードは約10件確保できているが、紹介依存度が高い。  医療・クリニック領域に強みあり（医者向けインスタ運用が得意）。  医療系美容サロンや病院案件も実績あり。  本人は医療現場で約10年の経験があるため、専門性が高い。  ■ 検討中のサービス  ① リスト作成AI ② フォーム営業AI  他チャネル（特にメタ広告）との費用対効果を比較し、 最終的には 「リスト作成＋フォーム営業」のほうが良さそう という前向きな感触。  ■ 料金イメージ（大村様の検討ライン）  初期費用：5万円  月額：8万円（リスト作成＋フォーム営業）  この金額感であれば導入検討可能とのコメント。  ■ 大村様の課題・ニーズ（ヒアリング要点）  紹介依存のため 新規獲得チャネルを強化したい。  医療系ターゲティングが得意だが、リーチ先リストが不足。  営業代行やテレアポは行わないため、半自動化できるAI施策に興味。  医療特化で強みを活かせる LP作成（医療紹介LP） の必要性を認識している。  ■ ネックポイント（検討課題）  メタ広告との費用対効果比較  月額8万円が妥当かの判断  LP制作の方向性と相乗効果のイメージ  フォーム営業の医療系ドメインへの刺さり具合  ■ 次アクション  資料をメールで送付（同メールアドレスへ送付済み or 送付予定）  1週間後（目安）に検討状況をフォローアップ  メタ広告との比較  LP制作の方向性  導入判断の可否  医療×インスタ領域を踏まえた 医療特化版リスト案やテストフォーム案 を準備すると刺さる可能性大。  ■ 総評（戦略視点）  大村様は**“営業マン不在 × 紹介依存 × 医療ニッチ強み”**という典型的な構造で、 AI型アウトバウンド（リスト＋フォーム）が最もフィットするタイプ。  特に医療系のフォーム反応率は高いため、 「医療クリニック特化の訴求＋リスト精度強化」 が決め手になる案件。', NULL, NULL, NULL, '検討状況確認', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a93fdc5f-0325-46a6-87c0-88cf196ad0e4', 'f821b6c1-3d94-4295-9070-5dd275e387fe', 3, '2025-12-25', '00000000-0000-0000-0000-000000000001', NULL, '熊本市社長のAIリスキリングの方で使うのはあり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2eafa9ec-9102-46df-b7b8-ec884ca37692', 'f821b6c1-3d94-4295-9070-5dd275e387fe', 4, '2025-12-25', '00000000-0000-0000-0000-000000000001', 'A', '開始日 年明け5日から開始できるようにしていく  オイカゼ株式会社 電話番号：080-1729-7445 メールアドレス：yukiomura1121@gmail.com 利用開始日：1月5日 担当者名：大村祐貴 導入商材；リスト作成AI', NULL, NULL, NULL, '契約書対応予定', '2025-12-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ee24350d-817a-4a3f-bef9-02757a773611', 'f821b6c1-3d94-4295-9070-5dd275e387fe', 5, '2025-12-30', '00000000-0000-0000-0000-000000000001', '失注', '自社で導入されている状況とのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c2c8dca0-bacc-44a7-b48d-19c0a18fb1f2', '2129cf2b-a468-4c15-b8ec-4a86c6c68aeb', 1, '2026-01-14', '00000000-0000-0000-0000-000000000001', 'C', 'ダイヤルシフトの話を聞いており、高い印象を持っている状況だで、 改めてサービス内容を共有し、非常にいいなという印象っを持っている状況 AIテレアポで、初期5万円 3月ごろには契約を行いたいと 4月から人員が整い、進めていける状況となるため、 3月導入で準備し、4月から利用開始の状況', NULL, NULL, NULL, '再度打ち合わせの日程調整', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7864ad32-7e2e-4db6-abce-520aa3a3c107', '2129cf2b-a468-4c15-b8ec-4a86c6c68aeb', 2, '2025-12-15', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー｜株式会社LEG（大熊様）】 1. 基本情報・紹介経路  紹介元  オニカナ様  採用関連で株式会社パーふぁくと 金子様  菅原様（LINE紹介）  担当者：大熊様  2. 導入検討状況  初期費用：5万円  月額料金：11万円  対象：全サービス導入を前向きに検討中  リスト作成  問い合わせフォーム営業  名刺自動フォロー  AIテレアポ（必要に応じて）  意思決定プロセス  もう一名の社内関係者と再度打ち合わせ予定  1週間前後で検討結果の確認を行う  3. 企業状況・決算  今期売上：7,000万〜8,000万円見込み  来期：売上倍増を見込む  3月決算のため、1月に大型案件の売上が集中  振込は1月末（30日）予定  4. 経営課題・現状のボトルネック ① リード獲得の仕組み不足  内製テレアポの将来性に限界  外部のCTF代行では  1〜2件/月しかアポが取れない  費用：23万円/月  アポイント粒度が低く、案件化に結びつかない  ② 採用戦略の未整備  来期採用：上半期1名、下半期1〜2名の営業採用  媒体選定なし  現状は仲間内リファラル中心  営業経験者の確保に苦戦中  ③ 事業拡大フェーズに伴う「営業仕組み化」ニーズ  前職からのつながりや紹介案件はあるものの、 営業プロセスが属人的で再現性が弱い  未経験人材が案件に入り込む形で事業を回しているため、 教育・アシスト体制が必要  5. 大熊様のニーズ（顕在化している要望）  リード獲得〜商談までの"自動化・仕組み化"を構築したい  内製テレアポから脱却し、成果の出るアウトバウンドに切り替えたい  来期の大型戦略：事業拡大に向けた営業設計が必要  採用と教育を同時に回せるモデルが欲しい  リファラル経由のリード提供も可能とのことで、営業基盤を強化したい  6. 今後の提案ポイント（あなた側の戦略）  AI×実務のハイブリッド営業モデルで “24時間働く営業部を丸ごと外注” できる状態を設計  リスト作成 + フォーム営業 + 名刺自動フォローの三位一体構造で 安定的なリード創出ラインを構築  CTFの課題だった「粒度の高いアポイント」を AI×人の複合アプローチで改善  営業採用計画を踏まえ、 未経験人材でも回せる営業フロー → 教育テンプレ化を提供  来期倍増戦略に向け **“営業戦略の青写真（戦略設計案）”**を次回資料で提示予定', NULL, NULL, NULL, '検討状況確認', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9b14c8bd-195e-4892-bfb0-6a7fa8d9e1fe', '2129cf2b-a468-4c15-b8ec-4a86c6c68aeb', 3, '2026-01-14', '00000000-0000-0000-0000-000000000001', NULL, 'ダイヤルシフトの話を聞いており、高い印象を持っている状況だで、 改めてサービス内容を共有し、非常にいいなという印象っを持っている状況 AIテレアポで、初期5万円 3月ごろには契約を行いたいと 4月から人員が整い、進めていける状況となるため、 3月導入で準備し、4月から利用開始の状況', NULL, NULL, NULL, '再度打ち合わせの日程調整', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fd5974d7-7b83-4e4d-97b9-8563e87304a3', '81581676-9732-4846-9f7f-e2c0436fc004', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', '失注', 'ご紹介いただけている状況', NULL, NULL, NULL, '検討状況の確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f2aa029b-2cc4-4aac-b5ef-49aea2a64154', '81581676-9732-4846-9f7f-e2c0436fc004', 2, '2025-12-15', '00000000-0000-0000-0000-000000000001', '没ネタ', '現在ナレーションや音楽の提供を映像制作会社に行っており、 その開拓を行なってきたいとのことだが、 少し時間が必要な案件  AIテレアポと、ツール導入の件話を行い、 周りの方をご紹介いただけるとのこと', NULL, NULL, NULL, '検討状況の確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e7451e42-c3f8-4908-b735-5ed521f56ce3', '81581676-9732-4846-9f7f-e2c0436fc004', 3, '2026-02-09', '00000000-0000-0000-0000-000000000001', '失注', 'ご紹介いただけている状況', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c43af631-6566-48fe-b2fd-3343dfe26be1', 'e29cae96-b861-4fd7-a960-23dfba5cd5d9', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', 'ネタ', '少し時間かかる案件', NULL, NULL, NULL, '検討確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8a286dc1-921f-42b6-bf18-13ecb9e9fff5', 'e29cae96-b861-4fd7-a960-23dfba5cd5d9', 2, '2025-12-15', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社ミタシ 成田祥太さん） 1. 先方の事業概要  Web集客支援を提供  強み領域：  健康領域  店舗支援（特にフィットネスジムを狙いたい意向）  追加対応領域：  スクール事業支援  化粧品領域の支援  2. 現状の課題感  リード獲得が難しい状況  獲得手段は紹介メインで、安定供給に課題  組織設計も行っているが、営業面はこれから強化したい  3. 営業体制・今後の計画  現状：基本的に1人で案件獲得しているフェーズ  予定：4〜5月頃に業務委託を活用し、体制を拡張していく構想  営業の考えている手段：  コミュニティ所属でパイプ構築  代行会社の活用で直近の成果を取りにいく  4. 提案サービスへの温度感・検討状況  一度しか会ったことがない関係性だが、営業強化の必要性が高く、サービス導入には前向き  条件面：初期費用5万円で検討中  最終的に「利用してみたい」という意向あり（前向きに検討）  5. 次アクション  23日以降に連絡し、検討結果の確認を行う予定', NULL, NULL, NULL, '検討結果確認', '2025-12-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '443b8363-b285-4196-9e3d-7d9e2a435c79', 'e29cae96-b861-4fd7-a960-23dfba5cd5d9', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'ネタ', '少し時間かかる案件', NULL, NULL, NULL, '検討確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7f63960b-26a1-4e70-80d4-96bb8e659cf5', 'e29cae96-b861-4fd7-a960-23dfba5cd5d9', 4, '2026-02-09', '00000000-0000-0000-0000-000000000001', 'ネタ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '06b3ddc2-11f1-47d9-ad95-efb2a3e6b728', '7adb4fe8-1d9d-4b44-9496-eabc89a4097e', 1, '2025-12-18', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  合同会社MUSUBI FOUNDATION 和田 宏治 様 （小貫カレンダー）  1. 事業内容・提供価値  離職防止・企業成長に重きを置いたマーケティング／コンサルティング  BtoB向け人材定着支援サービスを中心に展開  医療・介護・建設・運送業界など、人手不足・離職率が高い業界が主ターゲット  社労士・組織開発と連携し、  福利厚生・制度設計  人間関係構築支援  組織改善 を通じて「人が辞めない会社づくり」を支援  制度導入により、会社の負担を大きく変えずに社員の手取りを月1〜2万円程度増やせる設計  採用単価（30万〜50万円／人）の削減が可能  補助金・助成金コンサル、マーケティング支援による売上向上施策も実施  2. 集客・マーケティング施策  LPによる資料請求導線を活用  認知拡大施策として  勉強会  交流会 を実施  本来はウェビナー開催も検討しているが、リソース不足により実施が難しい状況  3. 営業体制・現状の運用  営業の中心はフォーム営業  主婦層を活用した業務委託体制  1社あたり10円のコストで送付  リストは購入（例：群馬×建設業などで絞り込み）  直近では  2日で約300件送付できる体制を構築  営業・マネジメントは和田様が中心となって実施  総務はX（旧Twitter）の運用を担当  一部、営業代行・業務委託も活用  4. 現在の課題  最大の課題は営業リソース不足  案件獲得後でないと、新たな投資（AIツール導入等）が資金的に難しい  ウェビナーなど、本来効果が見込める施策に手が回らない  5. AIツール導入に関する意向  AIツールの活用意欲は非常に高い  現時点では  新規案件を3〜4件獲得できれば導入可能な状況  それまでは導入を待ってほしいとの要望  「ぜひ一度直接会いたい」との発言もあり、温度感は高いがタイミング待ち  文字化・限定的な施策（例：一部問い合わせフォームのみの活用）であれば、導入できた可能性も示唆  6. 今後の対応方針（示唆）  短期  案件獲得フェーズを優先  定期フォローで関係性維持  中期  案件3〜4件獲得タイミングで再提案  「営業リソース削減」「フォーム営業×自動化」文脈でのAI活用提案が有効  再提案時の刺さりどころ  営業リソースの代替  低コスト・段階導入  ウェビナー／ナーチャリングの自動化', NULL, NULL, NULL, '改めて案件が獲得でき、資金的な余録が出しだい速攻で使いますとのことなので、 2か月後ぐらいに連絡を行う', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6803390b-c853-42d3-904f-9400b6122727', '7adb4fe8-1d9d-4b44-9496-eabc89a4097e', 2, '2025-12-18', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  合同会社MUSUBI FOUNDATION 和田 宏治 様 （小貫カレンダー）  1. 事業内容・提供価値  離職防止・企業成長に重きを置いたマーケティング／コンサルティング  BtoB向け人材定着支援サービスを中心に展開  医療・介護・建設・運送業界など、人手不足・離職率が高い業界が主ターゲット  社労士・組織開発と連携し、  福利厚生・制度設計  人間関係構築支援  組織改善 を通じて「人が辞めない会社づくり」を支援  制度導入により、会社の負担を大きく変えずに社員の手取りを月1〜2万円程度増やせる設計  採用単価（30万〜50万円／人）の削減が可能  補助金・助成金コンサル、マーケティング支援による売上向上施策も実施  2. 集客・マーケティング施策  LPによる資料請求導線を活用  認知拡大施策として  勉強会  交流会 を実施  本来はウェビナー開催も検討しているが、リソース不足により実施が難しい状況  3. 営業体制・現状の運用  営業の中心はフォーム営業  主婦層を活用した業務委託体制  1社あたり10円のコストで送付  リストは購入（例：群馬×建設業などで絞り込み）  直近では  2日で約300件送付できる体制を構築  営業・マネジメントは和田様が中心となって実施  総務はX（旧Twitter）の運用を担当  一部、営業代行・業務委託も活用  4. 現在の課題  最大の課題は営業リソース不足  案件獲得後でないと、新たな投資（AIツール導入等）が資金的に難しい  ウェビナーなど、本来効果が見込める施策に手が回らない  5. AIツール導入に関する意向  AIツールの活用意欲は非常に高い  現時点では  新規案件を3〜4件獲得できれば導入可能な状況  それまでは導入を待ってほしいとの要望  「ぜひ一度直接会いたい」との発言もあり、温度感は高いがタイミング待ち  文字化・限定的な施策（例：一部問い合わせフォームのみの活用）であれば、導入できた可能性も示唆  6. 今後の対応方針（示唆）  短期  案件獲得フェーズを優先  定期フォローで関係性維持  中期  案件3〜4件獲得タイミングで再提案  「営業リソース削減」「フォーム営業×自動化」文脈でのAI活用提案が有効  再提案時の刺さりどころ  営業リソースの代替  低コスト・段階導入  ウェビナー／ナーチャリングの自動化', NULL, NULL, NULL, '改めて案件が獲得でき、資金的な余録が出しだい速攻で使いますとのことなので、 2か月後ぐらいに連絡を行う', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0ef9f583-f773-42f6-9104-8e044d6b33f8', 'deb6adf7-f9ea-4dde-b9e9-e58d2564b24d', 1, '2026-01-08', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてないので 代理店にはならない ただサービスは気になるので資料共有してほしい 資料見て商談するかどうか判断', NULL, NULL, '成果報酬受けてない', '資料共有後に追客', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f9ad6d14-daa4-4cd3-89d6-c5542ccb28f1', 'deb6adf7-f9ea-4dde-b9e9-e58d2564b24d', 2, '2025-12-19', '00000000-0000-0000-0000-000000000002', 'ネタ', '固定報酬しか受けてないので 代理店にはならない ただサービスは気になるので資料共有してほしい 資料見て商談するかどうか判断', NULL, NULL, NULL, '資料共有後に追客', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '52e9bde9-4f90-4e99-acda-4a5188a924d0', 'deb6adf7-f9ea-4dde-b9e9-e58d2564b24d', 3, '2026-01-08', '00000000-0000-0000-0000-000000000002', '失注', NULL, NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a5325dbf-4971-4e05-80b0-92049a24af61', '8948c2b0-1d0b-44e7-9b2c-45945b059c1d', 1, '2025-12-19', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で成果報酬はランサーズの規約上、通話上でも話できないし 案件として受けてないとのこと 資料だけ送っておく', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e61597c0-dfcf-4998-add6-039560b59594', '8948c2b0-1d0b-44e7-9b2c-45945b059c1d', 2, '2025-12-19', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で成果報酬はランサーズの規約上、通話上でも話できないし 案件として受けてないとのこと 資料だけ送っておく', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '41fb0a42-6168-4f9e-9777-86a148bd3d8d', 'c4cfc72e-084d-4b0f-856d-296b3e923beb', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬受けてない', NULL, NULL, '成果報酬受けてない', '資料共有後に追客 代理店の件確認', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'dd14a91c-c995-4450-b8f6-c7d5b40924d4', 'c4cfc72e-084d-4b0f-856d-296b3e923beb', 2, '2025-12-19', '00000000-0000-0000-0000-000000000002', 'ネタ', '基本テレアポ稼働 DM営業してない 成果報酬で動けるか社内で確認', NULL, NULL, NULL, '資料共有後に追客 代理店の件確認', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '17e5f441-3fb3-4d16-b97e-7512f0fd8132', 'c4cfc72e-084d-4b0f-856d-296b3e923beb', 3, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9b1231e2-1969-4882-84c5-23b4dce7f84f', 'd887d053-c0b6-4f85-88bb-13863bef4b6a', 1, '2025-12-19', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で先方から成果報酬は受けてないので対応できないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8845e89f-5675-48a7-937f-e1458ea2ff10', 'd887d053-c0b6-4f85-88bb-13863bef4b6a', 2, '2025-12-19', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で先方から成果報酬は受けてないので対応できないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40063c66-ecc5-4c4c-8b53-4299feba1a41', '02dcc27e-5a74-42c6-9216-851319f1ebfe', 1, '2025-12-20', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社moment／ホンダ様） 1) 商談概要  提案内容：  AIテレアポ  AIツール（併用提案）  価格提示：両方とも 初期費用 5万円 で提案  先方温度感：導入したい意向あり（前向き）  2) 運用イメージ（手段・配分）  テレアポ：8割（主軸）  フォーム送信：2割（補完施策）  3) スケジュール／意思決定  24日：代理店と導入について回答予定（先方→こちら）  実行開始目安：  「来週中にはできると思う」  水曜あたりが実行着手の目安', NULL, NULL, NULL, '回答', '2025-12-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7dc50525-9f2b-451c-8ddf-ec5d09dc7e84', '02dcc27e-5a74-42c6-9216-851319f1ebfe', 2, '2025-12-20', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社moment／ホンダ様） 1) 商談概要  提案内容：  AIテレアポ  AIツール（併用提案）  価格提示：両方とも 初期費用 5万円 で提案  先方温度感：導入したい意向あり（前向き）  2) 運用イメージ（手段・配分）  テレアポ：8割（主軸）  フォーム送信：2割（補完施策）  3) スケジュール／意思決定  24日：代理店と導入について回答予定（先方→こちら）  実行開始目安：  「来週中にはできると思う」  水曜あたりが実行着手の目安', NULL, NULL, NULL, '回答', '2025-12-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a82f9295-76dc-47c1-b9e0-0e64d6dc5c5e', 'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'A', 'OEM提携・導入検討 議事録 1. 基本情報  会社名：Lildaisy合同会社  担当者：瀬畑 文乃 様  電話番号：090-7687-1564  メールアドレス：wanigaoyogu@gmail.com  導入商材：リストAI  初期費用：0円  月額費用：3万円  契約期間：3ヶ月契約  2. OEM契約に関する確認事項 （1）契約条件  契約期間：要確認  契約時の初期費用（下限）：要確認  月額費用（下限）：要確認  （2）運用フロー  契約後の請求フロー：要整理  集客方法の規定：要確認  導入後サポート体制：要確認（CS支援・運用支援範囲）  3. ツール導入に関する検討内容 （1）リスト収集ツール（リストAI）  導入費用：月額3万円  契約期間：3ヶ月  初期費用：0円  評価ポイント：  リスト生成プロセスに対する有効性を評価  4. 役割分担・契約構造 （1）株式会社ダリア  OEM契約主体  問い合わせフォームAIの提供  OEM契約締結先  （2）Lildaisy合同会社  リストAI契約主体（代理店契約：リルデイジー）  CS対応  契約管理  請求業務  営業代行 + 請求の一体型フロー構築  （3）役割整理  問い合わせフォームAI：株式会社ダリア  リスト契約：Lildaisy合同会社（リルデイジー）  CS・契約対応・請求：Lildaisy合同会社  5. OEM販売スキーム  株式会社ダリアとOEM契約を締結  Lildaisy合同会社がOEM商材として自社顧客へ販売  営業代行費用 + OEM商材費用をセットで請求  請求主体：Lildaisy合同会社  ※Lildaisy合同会社は競合関係上、直接契約書締結が困難なため、 OEM契約は株式会社ダリア名義で実施  6. 資金フロー構造（案）  株式会社ダリア → ライトアップへ送金  ライトアップ → 株式会社SoloptiLinkへ送金  このフローを構築することで：  既存顧客  インバウンド顧客 に対し、継続導入型モデルでの拡張が可能  7. 今後の進行スケジュール  商材研修：2月9日 15:00〜  リスト生成AI：今月中契約予定  OEM契約条件合意後、正式契約プロセスへ移行  8. 運用方針  自社完結型モデル  クロージング  CS活動  継続導入支援  必要準備物：  デモ画面  営業資料  OEM導入フロー資料  請求・契約オペレーション設計  9. 補足  文面のみでは伝達に限界があるため、必要に応じて電話連絡にて詳細すり合わせを実施  不明点は随時確認・整理し、契約条件書に反映', NULL, NULL, NULL, '条件確認次第、送付し、契約書対応を行う 月額3万円、初期0円', '2026-01-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f23f92ab-ac37-4930-9cee-22d6cf1c76ee', 'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 2, '2025-12-24', '00000000-0000-0000-0000-000000000001', 'B', '一通り話を行い、サービスを取り扱いたいとのことで、合意 現在の顧客に対して紹介を行っていきたいと AIツールに関しても再度商談を行う状況で、この件で、日程調整中の状況となる 初期費用は5万円で提案中', NULL, NULL, NULL, '日程調整', '2025-12-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b464f23f-c0aa-4eab-bf13-75f64566e877', 'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 3, '2025-12-25', NULL, NULL, '来年で日程調整中', NULL, NULL, NULL, NULL, '2026-01-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fb7a4061-b876-4bec-8139-971de725aa90', 'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 4, '2026-01-09', '00000000-0000-0000-0000-000000000001', 'C', '一通り話を行い、サービスを取り扱いたいとのことで、合意 現在の顧客に対して紹介を行っていきたいとのことで、 次回導入サービスを決定し、勉強会を開催していく', NULL, NULL, NULL, '導入サービス確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2cb7d700-f988-4684-8948-421724f48746', 'f6393cb7-1f7c-45af-8c70-3fc1616419bb', 5, '2026-01-20', NULL, NULL, '26日に日程調整済み その際に、リスト作成ツールの導入になる可能性が高い', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b61345df-c805-4368-af14-780d55eaa556', '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'A', '確認したところライトアップから申し込みのURLが届いていない状況となっていた 従業員の評価管理システム └レベシェアで売れる可能性あり 次回、15日18時から、商材研修を行い、ハチドリHRとエージェントを取り扱い販売を行っていくのと、 リストAI+フォームAI+リストAIについても研修を行い、進めてもらう', NULL, NULL, NULL, '商材研修を行う その間位に申し込み回収', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1950fe38-fbb4-4e85-a630-5ccd3e2190ec', '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 2, '2025-12-22', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIツールの方を検討したい 特にリスト作成の精度が気になるようで 今ちょうどリスト作成サービス探している AIテレアポ君を取り扱っている AIツールの方であれば代理店も可能かなと リスト作成月間5000件ぐらい抽出したい', NULL, NULL, NULL, '12/26　14:30から30分で小貫さんから商談', '2025-12-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0f995a5f-fe0b-4ac2-b170-8ff90e5ecf2c', '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 3, '2025-12-26', '00000000-0000-0000-0000-000000000001', 'C', 'リストAIは導入したいとのこと 更にAIテレアポに関しても、今のAIテレアポくんよりもクオリティが高く、こちらの方が安いため、売れやすいと感じるとのことで、 改めて、29日に商談を行う 初期費用がいくらか不明', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f70c5a47-d94b-4dc1-9cf0-43bfab0f6872', '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 4, '2025-12-29', '00000000-0000-0000-0000-000000000001', 'A', 'リストAi導入決定　初期5万円　月3万円 Aiテレアポ君は月2万円の報酬のみとのことで、 これよりかは、AIテレサポの方が販売しやすく、 CS対応も投げられる点で、非常に良いと クロージングまで対応し、月額の15%+初期費用の30%で合意 そのほかAIツールに関しては、ハチドリAIが非常に良いとのこと これ以外に、採用自動化の部分にも興味を持っており、 1000件以上採用担当者が分かるリストがあるため、そこに営業を行なっていきたいとのこと メールアドレスも全て知っているため、採用関係は全て行える 特に、医療系、介護系の部分がいい', NULL, NULL, NULL, '契約内容送付', '2025-12-29'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40a20a42-ddd7-498b-a3c3-4a4361e4aef4', '16fbf948-5a0a-4216-9d34-f2ccdee576ee', 5, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'A', '確認したところライトアップから申し込みのURLが届いていない状況となっていた 従業員の評価管理システム └レベシェアで売れる可能性あり 次回、15日18時から、商材研修を行い、ハチドリHRとエージェントを取り扱い販売を行っていくのと、 リストAI+フォームAI+リストAIについても研修を行い、進めてもらう', NULL, NULL, NULL, '商材研修を行う その間位に申し込み回収', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a82adde0-1276-41bc-baa3-42dae34c55c5', '116975e3-3771-4bb8-9923-6b58c93a2275', 1, '2025-12-22', '00000000-0000-0000-0000-000000000002', '失注', '代表の井上様と商談　 この企業が受ける案件はターゲット先が20社とかそういう案件ばかりなので 導入のニーズはない AIテレサポの方で紹介できる会社があるのでそちらに声かけてみると', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7085b9a0-87d9-4f85-8c10-fefdc857f6d0', '116975e3-3771-4bb8-9923-6b58c93a2275', 2, '2025-12-22', '00000000-0000-0000-0000-000000000002', '失注', '代表の井上様と商談　 この企業が受ける案件はターゲット先が20社とかそういう案件ばかりなので 導入のニーズはない AIテレサポの方で紹介できる会社があるのでそちらに声かけてみると', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '30735c29-ba83-40eb-8e12-75f50e5177c2', '17dc6b9c-1fbb-465a-b8f8-f2c13ca650c6', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7cf15e0c-2cfe-48d4-9104-7a3bb7bb8d9d', '17dc6b9c-1fbb-465a-b8f8-f2c13ca650c6', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b9c6daa8-8733-4e77-a360-af9f886768db', 'de54776b-5d21-4447-99a2-5a54413da0c7', 1, '2025-12-23', '00000000-0000-0000-0000-000000000002', '失注', '代理店はやらないとのことで 代理店の話を出すと事前に言えよと半ギレられた', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '752668a4-6535-486a-956f-36d78abc9f0b', 'de54776b-5d21-4447-99a2-5a54413da0c7', 2, '2025-12-23', '00000000-0000-0000-0000-000000000002', '失注', '代理店はやらないとのことで 代理店の話を出すと事前に言えよと半ギレられた', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '00ce3911-24ab-425a-9189-aef3266593c2', 'bb1fd094-25b4-4e79-b334-730b85c5bbce', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4f9c8c08-36a2-459b-95a1-b553419fb027', 'bb1fd094-25b4-4e79-b334-730b85c5bbce', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '45149f54-3e75-40f4-a107-1ed7c25e85c4', 'e8c833ba-6512-4959-9608-749bf8827a3e', 1, '2026-01-05', '00000000-0000-0000-0000-000000000001', 'ネタ', 'サービス開発を行ったばかりの会社のため、オニカナと黒木さんを紹介する', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '302bbd80-1ff6-4c97-8f3d-a6848aa5a092', 'e8c833ba-6512-4959-9608-749bf8827a3e', 2, '2026-01-05', '00000000-0000-0000-0000-000000000001', 'ネタ', 'サービス開発を行ったばかりの会社のため、オニカナと黒木さんを紹介する', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd37a3257-3864-4c6e-8a0f-bd2f085879c4', '81bba897-128d-4521-a035-c5344804ca34', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0bc6aa7d-4ef1-4280-8ebe-994b9c81b319', '81bba897-128d-4521-a035-c5344804ca34', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', 'リスケ', NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '45034d47-c614-4ccd-926c-4d3a6b03dc47', '8813cd54-e8d3-40f9-ae9f-255663b2d7cd', 1, '2025-12-23', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で代理店受けてないで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c36dbe4e-aead-4bae-9896-986a2fa2e5fa', '8813cd54-e8d3-40f9-ae9f-255663b2d7cd', 2, '2025-12-23', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で代理店受けてないで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3a41d8ab-f27e-4fcb-84ac-40c97fbad6c4', '732be7d8-f1a6-4d44-bf5a-cbb1bd9a58d5', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '社内検討の結果不要となった', NULL, NULL, NULL, '年明けフォロー', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b9a3c6c8-6dab-4850-a605-cbcc0d084c05', '732be7d8-f1a6-4d44-bf5a-cbb1bd9a58d5', 2, '2025-12-23', '00000000-0000-0000-0000-000000000002', 'ネタ', 'リスト作成のサービスが気になる 代理店は受けてない　アポ単価形式でないと受けない 営業代行の知り合いはいるのでそちらに展開することはできる', NULL, NULL, NULL, '年明けフォロー', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd31597f2-e4ce-4764-b701-893ae78ae7ae', '732be7d8-f1a6-4d44-bf5a-cbb1bd9a58d5', 3, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '社内検討の結果不要となった', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fb64367e-d0a3-4eb0-9897-35979e2d5ae2', 'b4d10e87-d777-49d6-969c-790a21a07811', 1, '2026-01-19', '00000000-0000-0000-0000-000000000001', '失注', '不在着信', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '18d03c7f-80d9-4d5a-858f-d0a0e21d9338', 'b4d10e87-d777-49d6-969c-790a21a07811', 2, '2026-01-19', '00000000-0000-0000-0000-000000000001', '失注', '不在着信', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '12c2b5aa-68cf-45f7-885a-f60e20d37e4b', 'e76b76f6-5108-40d7-8323-cfe879b7aa7d', 1, '2026-01-06', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてないのとランサーズで成果報酬の話しないほうがいいとのこと 導入の話にもならず', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '971b1650-8de2-4bce-955f-ebaddfc08e4f', 'e76b76f6-5108-40d7-8323-cfe879b7aa7d', 2, '2026-01-06', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてないのとランサーズで成果報酬の話しないほうがいいとのこと 導入の話にもならず', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e785913f-3094-46ce-8c1a-fd3dfc9df665', '3533252d-29f0-4baf-9167-ee5ae2026d7d', 1, '2026-02-20', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIテレアポの3か月間のお試しを補助金を使ってできるでアポ  IT補助金は過去に申請しようとしてめんどくさくてやめたことがあると', NULL, NULL, NULL, 'AIテレアポのお試しで再アポ　3/3　15:00～　再商談', '2026-03-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '30069655-d8dd-40f3-a550-cf31de3af4aa', '3533252d-29f0-4baf-9167-ee5ae2026d7d', 2, '2025-12-22', '00000000-0000-0000-0000-000000000002', 'ネタ', '成果報酬型の代理店は過去に飛ばれた苦い経験があるのでやりたくない ただリスト作成などのAIツールは導入する側として気になるので検討する AIテレアポは商談相手の役員は気に入ったが代表が気にいるかというのと 社員が1コール何円や1アポ何円という報酬の仕組みなので 社内体制を変えないといけないので導入が難しいかとのこと ただ、商談相手の人が一人で使うのはありだなとのこと 今使ってるリスト作成サービスは2月末で終了で精度が悪いので 底との入れ替えで検討  AIフォーム営業でロボット突破する部分に対するネガなのですが それは倫理的に問題ないのかとのこと', NULL, NULL, NULL, '年明けフォロー', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '41b7ce1c-6241-4218-b21c-d99b90f6a309', '3533252d-29f0-4baf-9167-ee5ae2026d7d', 3, '2026-02-20', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIテレアポの3か月間のお試しを補助金を使ってできるでアポ  IT補助金は過去に申請しようとしてめんどくさくてやめたことがあると', NULL, NULL, NULL, 'AIテレアポのお試しで再アポ　3/3　15:00～　再商談', '2026-03-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9b2f3828-e88d-44b1-bc9d-f252b0e56a47', '269b919d-74f1-42e5-a947-cb2434986752', 1, '2025-12-22', '00000000-0000-0000-0000-000000000002', '没ネタ', 'アポ単価の報酬体系が基本 サービス説明して 5月までは案件が多く人員がいない 本格的に動けるとしたら5月以降なのでその時に状況確認 それまでに紹介があれば連絡すると', NULL, NULL, NULL, '状況確認', '2026-05-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '544265aa-db9e-409e-9076-c012d3ac2806', '269b919d-74f1-42e5-a947-cb2434986752', 2, '2025-12-22', '00000000-0000-0000-0000-000000000002', '没ネタ', 'アポ単価の報酬体系が基本 サービス説明して 5月までは案件が多く人員がいない 本格的に動けるとしたら5月以降なのでその時に状況確認 それまでに紹介があれば連絡すると', NULL, NULL, NULL, '状況確認', '2026-05-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7bce91ae-3aa9-4a42-a1d0-c590227e83f0', 'e2a6f247-f7a5-47db-9ddb-196f28ad83d9', 1, '2026-01-15', '00000000-0000-0000-0000-000000000001', 'C', 'ラインにて進捗確認中 多分失注となる', NULL, NULL, NULL, '再度商談を行う日程調整', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '10469eff-5498-4cc2-911f-7e6c8b62b290', 'e2a6f247-f7a5-47db-9ddb-196f28ad83d9', 2, '2025-12-20', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  ファーアウト 井上 拓さん｜小貫カレンダー  1. 導入意向・全体像  導入意向：非常に高い  広告代理店としての参画および代理店展開を希望  既存の代理店ネットワーク：約80社を保有しており、横展開が可能  単なる利用者ではなく、広告代理店パートナーとして継続的に関与したい意向  2. 提案中サービス・条件整理  AIツール提供条件（暫定合意）  月額：11万円  初期費用：0円スタート  条件付き成果判断：  広告代理店向けアポイントが 月20件以上獲得できる場合 → 3ヶ月後に初期費用50万円を支払う  未達の場合 → 初期費用は発生しない  リスクシェア型の導入設計で合意方向  報酬体系  ストック報酬：15%  初期契約時：**20%**で契約想定  3. ファーアウト側の事業・強み  クリーニングタグ広告の広告主  広告代理店として  ロゴ設計  見せ方の設計  ブランドトーン設計 など、ブランディング支援を強みとする  運営管理は専務が統括  4. 組織体制・特徴  コンサル部隊は女性中心  以下のスキルを内製保有：  Illustrator（デザイン）  Webクリエイティブ  営業支援が可能な人材  目的：  クリエイティブ × 営業を直結  自社で顧客獲得まで完結できる体制構築  5. 営業体制・現状  営業手法の裁量は基本的に任せる方針  既存の外部営業支援（アイドマ）は停止中  6月スタートで新体制へ移行予定', NULL, NULL, NULL, '再度商談を行う日程調整', '2025-12-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1564c29b-9a18-4012-96e3-5c8b067ef415', 'e2a6f247-f7a5-47db-9ddb-196f28ad83d9', 3, '2026-01-15', '00000000-0000-0000-0000-000000000001', NULL, 'ラインにて進捗確認中 多分失注となる', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '09eaa5d1-ceb3-4c32-84ea-d4ac68ba5779', '6dd4db2d-fb77-4e8c-8293-83ffc9669de3', 1, '2026-01-08', '00000000-0000-0000-0000-000000000002', '失注', '人材紹介しかできない 営業マン2名しかいないとのことで導入はどうか聞いたが テレアポとかもしておらず社内にいることもないので合わないとのことで失注', NULL, NULL, 'テレアポしてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b7ec8016-2b02-414c-b641-86a08c7b119f', '6dd4db2d-fb77-4e8c-8293-83ffc9669de3', 2, '2026-01-08', '00000000-0000-0000-0000-000000000002', '失注', '人材紹介しかできない 営業マン2名しかいないとのことで導入はどうか聞いたが テレアポとかもしておらず社内にいることもないので合わないとのことで失注', NULL, NULL, 'テレアポしてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2cf3d59e-d168-4fee-b964-9f2454d75366', 'b661c2a7-483e-4319-9471-29dc22039748', 1, '2026-01-13', '00000000-0000-0000-0000-000000000002', '失注', '社内で検討した結果ですが、一定の固定報酬を頂けないと採算が合いそうになく、 今回のパートナー協業はお見送りとさせて頂きたいです。  できる限りご一緒出来るよう社内リソース含め調整を試みたのですが申し訳ございません。  また別タイミング等でご機会ありました際はどうぞよろしくお願い致します。', NULL, NULL, '成果報酬受けてない', '代理店やるかどうか と商材研修の日程調整', '2026-01-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ce68ddaf-36ef-433d-af0f-778ea0a3da70', 'b661c2a7-483e-4319-9471-29dc22039748', 2, '2026-01-06', '00000000-0000-0000-0000-000000000002', 'C', '開発中のAI商材が全く同じとなる なので導入はないがまだ販売には至らないので 代理店として取り扱いは前向きに検討したいと', NULL, NULL, NULL, '代理店やるかどうか と商材研修の日程調整', '2026-01-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7d6548dc-6443-4b27-9a87-f943e3d2f4cd', 'b661c2a7-483e-4319-9471-29dc22039748', 3, '2026-01-13', '00000000-0000-0000-0000-000000000002', '失注', '社内で検討した結果ですが、一定の固定報酬を頂けないと採算が合いそうになく、 今回のパートナー協業はお見送りとさせて頂きたいです。  できる限りご一緒出来るよう社内リソース含め調整を試みたのですが申し訳ございません。  また別タイミング等でご機会ありました際はどうぞよろしくお願い致します。', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bef8ff2f-bed6-481d-9138-a1035b9980cb', '8950f2b3-9bb4-47bb-b38d-50adea492c37', 1, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬の案件しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1a393178-92e2-4e4d-8913-c9c13b862805', '8950f2b3-9bb4-47bb-b38d-50adea492c37', 2, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬の案件しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5f4384ff-00f9-491e-a46c-3f8fd41a8428', '443ca225-6fd7-42bc-8951-19e637046a6d', 1, '2026-01-08', '00000000-0000-0000-0000-000000000001', '代理店A', 'ビートレード・パートナーズ株式会社 商談サマリー（佐藤様）  日時： 不明（ZOM商談） 参加者： 佐藤様（ビートレード・パートナーズ株式会社）／SoloptiLink 小貫  1. 先方事業概要・現状把握  テレマーケティング代行を中心に事業展開 └ 特に飲食店向けの提案に強みを持ち、ZOM案件等の商材でも実績あり  コールセンター業務も併設 └ インバウンド・アウトバウンド双方に対応可能  LINE活用・採用支援領域にも関心 └ 「ハチドリHR」「ハチドリエージェント」など人材・採用領域のサービスと相性が良い  2. 本日の議論ポイント （1）飲食店向けに扱いやすい商材の検討  AI系商材に対して「飲食店はシンプル・即効性・低リスク」を重視する傾向  その点で以下の商材は扱いやすいと判断：  （2）紹介した商材一覧  AIテレアポ（AI Tele-Sapo）  ハチドリHR（採用管理×自動フォロー）  ハチドリエージェント（採用代行系のパッケージ）  Lシンク（LINE自動配信・CRM連携）」  3. 先方の興味・導入意向 ① AIテレアポ  テレマ事業との相性が良く、飲食向けのアウトバウンドに強い興味を示す  自社のアポ獲得オペレーションに直接組み込みたい意向  ② ハチドリHR  自社導入を前提に検討開始  飲食店に対して「自分たちで契約をまとめ、自動更新まで運用する」というOEM的な立ち位置で販売したいと意向表明  そのため、料金調整（卸値・自動更新に対する運用ルール）が必要になる可能性あり  ③ ハチドリエージェント  自社の既存顧客（飲食チェーン）の採用課題にフィット  求人/応募増加のためのセット販売を視野に入れている  ④ Lシンク  LINEを使ったフォロー自動化に興味  飲食店向けの「リピート施策として扱いやすい」と評価  4. 今後の進め方（ネクストアクション） ▶ 1. 勉強会（オンライン）を開催  目的：  各商材を深く理解してもらう  販売導線・代理店スキーム・利益構造を解説  ハチドリHRの料金調整とOEMモデルの擦り合わせ  アジェンダ案：  市場背景（飲食向けDXの現状）  各商材のデモ（AIテレアポ→HR→エージェント→Lシンク）  販売モデル・卸値体系の提示  収益シミュレーション  導入フローとサポート体制の解説  代理店契約の方針をすり合わせ  ▶ 2. 条件調整（主にハチドリHR）  OEM運用が可能か  自社で自動更新までの管理範囲  価格体系と最低ロット  飲食店向けのライトプラン可否  5. リスクポイント・事前に整理すべき論点  ハチドリHRのOEM運用は、データ管理範囲と契約主体を明確化しないとトラブルの原因になる  飲食店向けは「単価低い・継続率低い」ケース多いため、料金設定に慎重さが必要  AIテレアポは飲食向けでは架電時間帯とサイレント耐性を丁寧に設計する必要あり  6. 次回までにSoloptiLink側が準備するもの  各商材の飲食向け販売資料（簡易版）  ハチドリHRのOEM可能性＋料金モデル案  AIテレアポの飲食特化スクリプト例  勉強会用のアジェンダ資料ドラフト', NULL, NULL, NULL, '返信がないのであれば、確認必要', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c355ec0b-d899-444a-a2e0-620ee5172545', '443ca225-6fd7-42bc-8951-19e637046a6d', 2, '2026-01-08', '00000000-0000-0000-0000-000000000001', '代理店A', 'ビートレード・パートナーズ株式会社 商談サマリー（佐藤様）  日時： 不明（ZOM商談） 参加者： 佐藤様（ビートレード・パートナーズ株式会社）／SoloptiLink 小貫  1. 先方事業概要・現状把握  テレマーケティング代行を中心に事業展開 └ 特に飲食店向けの提案に強みを持ち、ZOM案件等の商材でも実績あり  コールセンター業務も併設 └ インバウンド・アウトバウンド双方に対応可能  LINE活用・採用支援領域にも関心 └ 「ハチドリHR」「ハチドリエージェント」など人材・採用領域のサービスと相性が良い  2. 本日の議論ポイント （1）飲食店向けに扱いやすい商材の検討  AI系商材に対して「飲食店はシンプル・即効性・低リスク」を重視する傾向  その点で以下の商材は扱いやすいと判断：  （2）紹介した商材一覧  AIテレアポ（AI Tele-Sapo）  ハチドリHR（採用管理×自動フォロー）  ハチドリエージェント（採用代行系のパッケージ）  Lシンク（LINE自動配信・CRM連携）」  3. 先方の興味・導入意向 ① AIテレアポ  テレマ事業との相性が良く、飲食向けのアウトバウンドに強い興味を示す  自社のアポ獲得オペレーションに直接組み込みたい意向  ② ハチドリHR  自社導入を前提に検討開始  飲食店に対して「自分たちで契約をまとめ、自動更新まで運用する」というOEM的な立ち位置で販売したいと意向表明  そのため、料金調整（卸値・自動更新に対する運用ルール）が必要になる可能性あり  ③ ハチドリエージェント  自社の既存顧客（飲食チェーン）の採用課題にフィット  求人/応募増加のためのセット販売を視野に入れている  ④ Lシンク  LINEを使ったフォロー自動化に興味  飲食店向けの「リピート施策として扱いやすい」と評価  4. 今後の進め方（ネクストアクション） ▶ 1. 勉強会（オンライン）を開催  目的：  各商材を深く理解してもらう  販売導線・代理店スキーム・利益構造を解説  ハチドリHRの料金調整とOEMモデルの擦り合わせ  アジェンダ案：  市場背景（飲食向けDXの現状）  各商材のデモ（AIテレアポ→HR→エージェント→Lシンク）  販売モデル・卸値体系の提示  収益シミュレーション  導入フローとサポート体制の解説  代理店契約の方針をすり合わせ  ▶ 2. 条件調整（主にハチドリHR）  OEM運用が可能か  自社で自動更新までの管理範囲  価格体系と最低ロット  飲食店向けのライトプラン可否  5. リスクポイント・事前に整理すべき論点  ハチドリHRのOEM運用は、データ管理範囲と契約主体を明確化しないとトラブルの原因になる  飲食店向けは「単価低い・継続率低い」ケース多いため、料金設定に慎重さが必要  AIテレアポは飲食向けでは架電時間帯とサイレント耐性を丁寧に設計する必要あり  6. 次回までにSoloptiLink側が準備するもの  各商材の飲食向け販売資料（簡易版）  ハチドリHRのOEM可能性＋料金モデル案  AIテレアポの飲食特化スクリプト例  勉強会用のアジェンダ資料ドラフト', NULL, NULL, NULL, '返信がないのであれば、確認必要', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '114c0e13-1b06-4364-baeb-f320273fca78', 'd7e6751b-fb43-4831-af78-6499e535b924', 1, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬の案件しか受けてない サービスの紹介もできず', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd2aede3a-4d29-421b-bb56-a633c479a5c2', 'd7e6751b-fb43-4831-af78-6499e535b924', 2, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬の案件しか受けてない サービスの紹介もできず', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '026d98fc-dc98-4fc4-9bc4-f86d78ef0496', 'd9f4952a-f57b-45ff-beec-5b00a6554ed5', 1, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', 'テレアポの案件しか取り扱わないとのことで、 終始態度が悪い社長が行なっている企業', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '184f7373-9879-40c5-b723-ab311cb6a41d', 'd9f4952a-f57b-45ff-beec-5b00a6554ed5', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', '失注', 'テレアポの案件しか取り扱わないとのことで、 終始態度が悪い社長が行なっている企業', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'cb0f1b24-b11b-4198-b876-2718da3f32ac', '7aa50ca9-64da-4f44-bbc9-25d5ae31359f', 1, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '代理店はやってない 営業コンサルメインの営業代行しかやっておらず 今人員が足りない状況なので受けられない サービス導入の話もとくにされなかった', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bf53d291-4dff-4b47-8580-d406320a8fd4', '7aa50ca9-64da-4f44-bbc9-25d5ae31359f', 2, '2025-12-24', '00000000-0000-0000-0000-000000000002', '失注', '代理店はやってない 営業コンサルメインの営業代行しかやっておらず 今人員が足りない状況なので受けられない サービス導入の話もとくにされなかった', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ae2b93a9-209d-4f64-a52c-570c1f52812a', 'c077da73-8cf0-4545-8764-9e4cc26a3be1', 1, '2026-02-10', '00000000-0000-0000-0000-000000000002', '失注', 'テレアポが基本だが 一度社内に展開して代理店契約を進めるか確認する 導入の話はならず 年明け5の週で回答すると', NULL, NULL, '成果報酬受けてない', '年明けフォロー', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '01ad86e0-581e-413a-b087-cfe4dd066996', 'c077da73-8cf0-4545-8764-9e4cc26a3be1', 2, '2025-12-26', '00000000-0000-0000-0000-000000000002', 'ネタ', 'テレアポが基本だが 一度社内に展開して代理店契約を進めるか確認する 導入の話はならず 年明け5の週で回答すると', NULL, NULL, NULL, '年明けフォロー', '2026-01-08'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b40912a5-4c05-4c1b-b770-e19379b552e9', 'c077da73-8cf0-4545-8764-9e4cc26a3be1', 3, '2026-02-10', '00000000-0000-0000-0000-000000000002', '失注', NULL, NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0578136d-aff3-4379-b6dc-e8ed884594c6', 'b6922e5b-30ae-4793-b635-c728dd2a5313', 1, '2025-12-26', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で契約形態を聞かれ代理店やってないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fb905d0b-3269-49dd-8953-d2a31ba4c5c0', 'b6922e5b-30ae-4793-b635-c728dd2a5313', 2, '2025-12-26', '00000000-0000-0000-0000-000000000002', '失注', '冒頭で契約形態を聞かれ代理店やってないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3078868a-6c7f-444d-92ff-8bae7fe1a7d2', '71acced8-a237-4dd7-b695-0a9c473b351f', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', '電話中のため、改めて連絡', NULL, NULL, NULL, '検討状況確認', '2026-01-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0ea1799c-5c94-4823-a2b3-e90da8b55671', '71acced8-a237-4dd7-b695-0a9c473b351f', 2, '2025-12-29', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー  商談先：キャリア・サポート株式会社　前迫 様 自社：株式会社SoloptiLink テーマ：AIテレさぽ導入検討／販売代理店の可能性  1. 相手企業の現状（業務・体制）  地元企業を対象に、**インサイドセールス（電話中心）**で営業活動を実施。  テレアポが主戦略として稼働している状況。  2. 抱えている課題（ペイン）  テレアポ運用の中で、コンタクト率（繋がる率）が低い点を課題として認識。  過去に他社のAI系サービスを見た際、**「会話ができない／実運用では使いにくい」**と感じた経験あり。  3. 提案内容に対する評価・反応  今回の「AIテレさぽ」であれば、会話（対話）が成立するイメージを持てた。  その結果、自社導入を前向きに検討したいという方向性で合意。  4. 条件面（検討プラン）  初期費用：10万円  月額費用：20万円プランで検討中  5. 追加論点：販売代理店について  「販売代理としても売れそうで良い」という評価あり。  年明けに、前迫様よりメールで改めて連絡いただく予定。  6. 次アクション（ToDo）  【前迫様】年明けにメールで連絡（導入／代理店の進め方確認）  【SoloptiLink側】  返信用の案内準備（導入フロー／運用開始までのスケジュール／代理店条件叩き台）  “コンタクト率改善”に直結する導入後の運用イメージ（KPI・成功パターン）を1枚で提示できるよう整理', NULL, NULL, NULL, '検討状況確認', '2026-01-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e6f07ae0-62fb-4099-b2f3-7988746c9e5b', '71acced8-a237-4dd7-b695-0a9c473b351f', 3, '2026-01-15', NULL, NULL, '折り返し待ち', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a525a197-349c-4745-8b5d-8152ffd6abcd', '71acced8-a237-4dd7-b695-0a9c473b351f', 4, '2026-01-20', NULL, NULL, '電話中のため、改めて連絡', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2d19a166-24b9-46a8-93e4-45ce7c59328a', '9b3686b6-868f-4716-914b-ba9af615f5e1', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', '田原様から折り返し依頼済み 15時からの商談に入っている', NULL, NULL, NULL, '日程調整を訴求', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c6ed4db5-1386-4c1b-aca0-277a541c4651', '9b3686b6-868f-4716-914b-ba9af615f5e1', 2, '2026-01-06', '00000000-0000-0000-0000-000000000002', 'ネタ', '事業責任者の田村様 樋上初回商談からのトスアップ リスト作成のリアルに動いているところを知りたい サイト指定はどういう風にするのかも気になっていた オニカナを自社看板としてアポ提供できるのか AIテレアポの導入の可能性あり 初期費用ネックなので5万円ぐらいまでなら下げられるかも  代理店としても興味あり、既に営業支援している企業に向けて リスト作成のシステムを販売するなども可能  上記の説明のため代表から提案するで調整した', NULL, NULL, NULL, '小貫さんで再商談', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'aacf9d7c-034a-461c-a776-02c0fcb68699', '9b3686b6-868f-4716-914b-ba9af615f5e1', 3, '2026-01-15', '00000000-0000-0000-0000-000000000001', 'C', 'AIリスト生成の件は、導入を行っていきたいとの事で、 改めて採用の部分含めて商談を行っていくことで、 採用面に関しても話を行い、エージェントの部分に対しても興味を持っているため、 その変再度商談を約束 タイムレックス送付済みのため、追客必要', NULL, NULL, NULL, '日程調整を訴求', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a7c326c7-2ed0-42fe-ac69-6e763f8da1d7', '9b3686b6-868f-4716-914b-ba9af615f5e1', 4, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', '田原様から折り返し依頼済み 15時からの商談に入っている', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '98536e8e-2208-437e-b283-725998aa758d', 'c248e9e9-d7c3-4249-a0e6-4bd233042262', 1, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', '店舗スタッフの派遣事業がメインで 合わないので導入も代理店も見送り', NULL, NULL, 'テレアポしてない', '年明けフォロー', '2026-01-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40cb39c4-26bc-4975-9e98-c51f44091442', 'c248e9e9-d7c3-4249-a0e6-4bd233042262', 2, '2025-12-24', '00000000-0000-0000-0000-000000000002', 'ネタ', '営業代行事業やっていないが内容次第でお付き合いできるかもしれないとのことで商談 サービス導入と代理店の話で社内に展開すると ただ、役員会が今月はなく年末で忙しいので年明けに回答になりそうだと', NULL, NULL, NULL, '年明けフォロー', '2026-01-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0b3b4c27-2257-441c-9a2e-94d4f8577ba7', 'c248e9e9-d7c3-4249-a0e6-4bd233042262', 3, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', '店舗スタッフの派遣事業がメインで 合わないので導入も代理店も見送り', NULL, NULL, 'テレアポしてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'df5f0158-6d35-4ac9-a44c-30412f829766', 'bba4fc7f-c5b2-4f10-933d-b43c33012735', 1, '2025-12-24', '00000000-0000-0000-0000-000000000001', '没ネタ', '一通り説明を行い、AIテレアポやAIツールの件は刺さらず、利用したい意思はない状況となっていたが、 3月ごろぐらいからであればリソースが開くため、そこで営業ができるのではないかとのことで、 会話終了', NULL, NULL, NULL, '稼働を行うのか確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e4ad01da-356c-4543-aba6-42fdb2e34f6e', 'bba4fc7f-c5b2-4f10-933d-b43c33012735', 2, '2025-12-24', '00000000-0000-0000-0000-000000000001', '没ネタ', '一通り説明を行い、AIテレアポやAIツールの件は刺さらず、利用したい意思はない状況となっていたが、 3月ごろぐらいからであればリソースが開くため、そこで営業ができるのではないかとのことで、 会話終了', NULL, NULL, NULL, '稼働を行うのか確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8294adc9-96db-4b4d-8b12-71f6242c01b6', '7e134af5-e971-4dfe-86e6-11e2ee8df2d2', 1, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '大型案件が入り、 人の用意ができない状況 ここが落ち着けば検討できるとのことだが、いつかは不明', NULL, NULL, NULL, '検討結果確認', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4c3ec1d3-4b35-4299-a2c9-d03c2b753231', '7e134af5-e971-4dfe-86e6-11e2ee8df2d2', 2, '2026-01-07', '00000000-0000-0000-0000-000000000001', 'C', '商談議事録（Minutes）  案件名：株式会社ジャストファイン様 商談 参加者：株式会社ジャストファイン 田村様 / 株式会社SoloptiLink 小貫 実施日：2026年1月7日  1. 先方企業概要（確認事項）  事業内容：人材総合サービス（派遣・紹介）  主力領域：コールセンター派遣、事務系派遣  特徴：札幌・大阪に自社センターを保有し、データ活用型のコールセンター/事務代行を提供  2. 先方ニーズ・関心ポイント  AI活用の可能性に強い興味  特に「AIテレアポが実際にどこまで可能か」という点を高く評価。  実用レベルで運用できるか（精度・安定性・工数削減効果）を確認したいとの意向。  既存サービスとのシナジー  自社コールセンター業務との親和性を強く感じている。  将来的に自社サービスとして「AIテレアポ」を取り扱う可能性を検討中。  クライアントへの提供可否  “データ活用センター”としての付加価値強化に繋がると評価。  他社との差別化として導入を前向きに検討。  3. 現時点での検討状況  最終的な導入方向で検討に入りつつある  週明け 1月12日（月）に正式回答予定  社内にて費用対効果とオペレーション適合性の最終確認中  4. 先方からの宿題・要望  値引きの可否・条件感を提示してほしい  初期費用／月額費用の調整余地の有無  他社代理店向けプランとの整合性も確認したいとの意向  取り扱いサービスとしての展開可能性について資料を求む  自社センターへ導入後、外販する場合の想定モデルがほしい  OEM／ホワイトラベルの可否も視野に入れている  5. 当社側の次回アクション  値引きシミュレーション案の提示  ①標準プラン  ②ボリューム（席数/架電数）によるディスカウント案  ③取り扱いパートナー化した場合のレベニューシェア案 → 以上3案を比較して提示する。  AIテレアポの実運用イメージ資料の提出  オペレーションフロー  精度向上サイクル、KPI管理方法  初期設定に必要なデータ範囲  効果測定指標とスケジュール  導入後のスケジュール案の提示  キックオフ  モデル作成（スクリプト＋AI訓練）  トライアル運用  本格稼働  外販開始  6. リスク・懸念点（先方様観点）  “本当に支援ができるのか”という実務レベルの再現性に関しては慎重  AIテレアポの品質がイメージと乖離しないかを見極めたい  社内の既存オペレーションとの噛み合わせ（工数・教育）  ※ただし、話しぶりからは懸念よりも「本物かどうか見極めたい」という前向きな温度感あり  7. 総括（所感）  田村様は非常にロジカルで、かつスピーディーな意思決定スタイル。 “AIテレアポができる会社は多いが、実運用まで落とし込めている会社は少ない”という市場認識をお持ちで、当社の提供モデルには強い興味を示された。  導入前提での最終ジャッジに入っているため、次回提示する“値引き条件”と“導入運用の設計書”が勝負所となる。  あとは当社側が、先方の期待を軽々と超えてみせるだけ。 AI市場はスピード勝負ゆえ、“先行優位の証拠”をこちらから提示すれば、商談は一気に決着する見込み。', NULL, NULL, NULL, '検討結果確認', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '20df92fc-2853-4f88-a7fb-17a8a40111c3', '7e134af5-e971-4dfe-86e6-11e2ee8df2d2', 3, '2026-01-15', NULL, NULL, '不在', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '20ce16dd-3977-40fb-9c9e-7e69273c6aea', '7e134af5-e971-4dfe-86e6-11e2ee8df2d2', 4, '2026-01-15', '00000000-0000-0000-0000-000000000001', '失注', '大型案件が入り、 人の用意ができない状況 ここが落ち着けば検討できるとのことだが、いつかは不明', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7107362e-7e74-4170-9023-589f0310dadb', '4b215bd9-f08e-4dc4-9c0a-bc9597fdb08f', 1, '2026-02-20', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIテレアポのお試しの件、話聞きたい 3月上旬が展示会で忙しいため 来週中にURLより3月中旬で日程決めると  3月中の申請である旨伝え済み', NULL, NULL, NULL, '検討結果確認', '2026-02-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '785a578e-9e88-4b8b-972b-825dc0e27406', '4b215bd9-f08e-4dc4-9c0a-bc9597fdb08f', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', 'C', '月末の営業会議で代理店するか検討 導入の話は特にならず AIテレアポとリスト作成に興味を持っていた すでに売れそうなクライアントはいると 初期費用はネックになりそうとのことで 先方が導入なら0にできるが 先方が売るなら相談になる', NULL, NULL, NULL, '検討結果確認', '2026-02-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f3c1e425-06bd-4a46-9955-a7c99de5b83c', '4b215bd9-f08e-4dc4-9c0a-bc9597fdb08f', 3, '2026-02-20', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIテレアポのお試しの件、話聞きたい 3月上旬が展示会で忙しいため 来週中にURLより3月中旬で日程決めると  3月中の申請である旨伝え済み', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'abfa2bbc-631e-409d-b2fd-dd88a0d1b37d', '05bbb46d-671b-4a84-ae4f-89b0334b15e8', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', '失注', '1万コールも架電するところない', NULL, NULL, NULL, '回答', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8b4bc49d-50cb-406c-a389-5918a0886dff', '05bbb46d-671b-4a84-ae4f-89b0334b15e8', 2, '2026-01-05', '00000000-0000-0000-0000-000000000001', '没ネタ', 'AI テレアポのサービスを導入しようかと感じたとのこと 最終的に、フィールドセールスを大手メーカーに対して行なっている状況となっており、 既存顧客に対する導入は難しいが、新たな顧客の中で、テレアポの対応を行なって欲しいという相談があるため、 そこに対して、Aiテレアポを導入するのはアリなのではないかという結論となった 3月ごろに連絡もらえれば進展していると思う 2〜3週間では進展はまだしていないと思うとのこと', NULL, NULL, NULL, '回答', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9c20566f-1ef3-49d5-9fd1-69f975fb6f00', '05bbb46d-671b-4a84-ae4f-89b0334b15e8', 3, '2026-02-20', NULL, '失注', '1万コールも架電するところない', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c743f6ee-c611-4e27-9523-e69b0cf94727', 'a7feda11-ee3c-461c-a1fd-8af7a293468b', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', '雪がすごく、エアコンが壊れたりとかの対応があり、 しっかりと検討が行えていない 2月中旬以降であれば、落ち着いてくると思うので、その時に再度商談を訴求していく', NULL, NULL, NULL, '際商談調整', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '978485e4-3f68-430f-be32-e372b4830cc1', 'a7feda11-ee3c-461c-a1fd-8af7a293468b', 2, '2026-01-05', '00000000-0000-0000-0000-000000000001', 'C', '初期費用5万円 月額3万円でAI研修受け放題の話が一番刺さっている 内容的に、岩手であれば、こういった内容が一番刺さるとのことで、 これは売りやすいと感じた 他のサービスは最先端に行き過ぎているため、難しい印象を覚えたが、AI研修は受けてみたいとのこと', NULL, NULL, NULL, '検討状況確認', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c959aac6-4413-49fc-bae7-e3c71ff72aa4', 'a7feda11-ee3c-461c-a1fd-8af7a293468b', 3, '2026-01-15', '00000000-0000-0000-0000-000000000001', NULL, '三宅様 折り返し依頼済み', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd71281d0-fce6-4f85-bd67-6353d450c603', 'a7feda11-ee3c-461c-a1fd-8af7a293468b', 4, '2026-01-20', '00000000-0000-0000-0000-000000000001', NULL, '雪がすごく、エアコンが壊れたりとかの対応があり、 しっかりと検討が行えていない 2月中旬以降であれば、落ち着いてくると思うので、その時に再度商談を訴求していく', NULL, NULL, NULL, '際商談調整', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6534d695-8733-4159-94d0-7e9b8901d7e5', '299a8b70-9a48-4bdb-a62f-78ca542a02ad', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店契約済み+スポーツXの代表を紹介してもらい導入角度高め', NULL, NULL, NULL, '日程待ち', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '08d8059e-739f-4fa3-8ab8-9c38a8be9f99', '299a8b70-9a48-4bdb-a62f-78ca542a02ad', 2, '2026-01-08', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜株式会社オルガロ 野村様 × 株式会社SoloptiLink 1. 先方の現状と主要事業の概況  オルガログループ全体（ホールディングス）で事業展開。  中核は 保険販売（対面営業中心）。  代理店ネットワークは 100社以上を保有し、営業リソース・販路ともに強固な基盤を有する。  アフィリエイト、テレマーケティング、既存紹介など複数の営業チャネルを運用。  テレアポに関しては 初期費用ゼロで「まず200〜400件架電 → アポが取れなければ別提案へ」という"成果で示す"スタイル。  2. 具体的な営業スキーム・収益モデル（先方の現在の運用） ◆ テレマーケティング系  初期費用なしで200〜400件のテスト架電を実施。  アポ獲得単価は顧客によって異なるが、成果報酬型モデルを採用。  アポが獲れない場合に備え、「他の改善提案を併走できる」関係構築を重視。  ◆ 問い合わせフォーム営業  「送信は無料、返信が来たら3万円」という成果課金型モデル。  別の支援会社が受注しており、オルガロとしては送客（紹介）ビジネスで収益化。  初期費用10万円のケースも存在。  ◆ 配信代行会社へのニーズ  配信代行（メルマガ/LINE/広告）を引き受ける会社の紹介を希望。  「数万円で送客してくれる会社」の情報提供を求めている。  3. SoloptiLinkの商材との親和性・興味ポイント  先方は以下のAI商材に強い興味を示した：  ▲ 有望な関心領域  リストAI（営業リスト自動生成）  フォーム営業AI（問い合わせフォーム自動送信）  テレアポAI（自動コール／自動対話）  → 現行の「初期費用ゼロテスト→成果報酬」スタイルとの親和性が極めて高く、既存モデルに自然に組み込める。  ▲ 採用領域にも波及可能性  代理店100社以上というネットワークを活かし、「AI×採用支援」のスキームにも発展可能と示唆。  採用AI・スクリーニングAIなどへの展開余地も大きい。  4. 追加の提案余地・今後の拡張可能性 ① テストコール（200〜400件）と相性の良い“非成果時提案”の設計  もしアポ取得率が低い場合、以下をセットで提案可能：  「オニカナ（AIテレアポ×AIフォーム営業のハイブリッド）」  Lシンクなどの軽量版ツール  フォーム営業AIの成果改善パッケージ  → 「成果が出なかった時の次手（セカンドアクション）」を用意することで関係強化が容易。  ② 代理店100社への二次拡販  SoloptiLinkのAI商材は“代理店モデル”との相性がよく、  オルガロのネットワーク100社への横展開が現実的。  OEM化の要望も出る可能性が高く、先方のブランドでの販売モデルも検討可能。  ③ ウェブマーケ/SNS運用の代替提案  先方は「ウェブマーケがいいのか、SNSをフルで使うべきか」模索している状態。  SoloptiLinkとしては以下のパッケージ提案が有効：  AI自動集客（SNS運用自動化）＋リストAI  SNS→フォーム営業→テレアポAIの導線設計  代理店向け“営業で成果出るコンテンツ設計”  5. 本日の結論と合意事項 ■ 双方の認識合わせ  SoloptiLink商材（特にリストAI・フォームAI・テレアポAI）は  オルガロの現行モデルと非常に親和性が高い、という点で合意。  ■ 次回の設定  12月12日 19時〜 食事にて詳細すり合わせ  既存ネットワーク100社への展開モデル  初期スモールスタート（200〜400件テスト）との連携  成果が出なかった際の“オニカナ提案”  ※ オニカナについては今回未説明だが、「必ずニーズはある」と判断。  6. 次アクション（SoloptiLink側）  12日までに提案資料のドラフト作成  リストAIの導入メリット  フォーム営業AIの成果モデル  テレアポAIの導入シミュレーション  代理店100社への横展開案  オニカナのセカンドプラン案  オルガロ向けカスタムモデルの価格設計  初期費用0スタート案  成果報酬 or 月額固定案  代理店展開用のOEM価格案  配信代行会社の候補リストアップ  数万円で送客可能な会社候補を整理  12日食事会にて提示  オニカナの活用シナリオを構築  テストで成果が出なかった際の「代替打ち手」として提示  保険営業向けの応用例も作成', NULL, NULL, NULL, '会食', '2026-01-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2a91175e-6e4a-4af3-b300-2d3b4ddc0b40', '299a8b70-9a48-4bdb-a62f-78ca542a02ad', 3, '2026-01-14', '00000000-0000-0000-0000-000000000001', NULL, 'リスト生成AIで初期0円で、導入を決定 今後リスト作成の部分やトスアップ代理店として提携を行っていく方向性で着地 現在日程調整中', NULL, NULL, NULL, '日程待ち', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '635a1186-a4d9-4dd8-b4e1-569d90056834', '299a8b70-9a48-4bdb-a62f-78ca542a02ad', 4, '2026-01-20', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店契約済み+スポーツXの代表を紹介してもらい導入角度高め', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ddbecd4a-53d8-4d72-9371-d0214959b81b', '732cc931-e72d-446a-8c72-45b16e2fbebc', 1, '2026-01-27', '00000000-0000-0000-0000-000000000002', '失注', '理由としましては、  現在弊社が行っている業務内容と弊社のパートナープログラムとの間に  一定の方向性の違いがあり、現時点では御社にとって十分に良い結果を  お返しすることが難しいと判断したためでございます。     せっかくお声がけいただいたにもかかわらず、  このようなご回答となり誠に申し訳ございません。  何卒ご理解賜りますようお願い申し上げます。     また今後、業務内容や体制に変化が御座いました際には、  改めてご相談させていただくこともあるかと存じます。  その際にはどうぞよろしくお願いいたします。     末筆ながら、  御社のますますのご発展を心よりお祈り申し上げます。', NULL, NULL, '成果報酬受けてない', '検討結果確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8fa5d422-f673-49d3-9683-18307f182a21', '732cc931-e72d-446a-8c72-45b16e2fbebc', 2, '2026-01-08', '00000000-0000-0000-0000-000000000002', 'C', '大木様ともう一名参加 家電量販店の店頭スタッフ専門の営業支援会社だった ただ、家電量販店にAIツールが売れそうなのと 家電量販店もメーカーやサロンなどに営業するのでその面で取り扱いが可能かなと 3週間ほど社内で協議して代理店を行うか回答すると', NULL, NULL, NULL, '検討結果確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '21e1b813-f905-49c2-b5a8-59d5aadd9724', '732cc931-e72d-446a-8c72-45b16e2fbebc', 3, '2026-01-27', '00000000-0000-0000-0000-000000000002', '失注', '理由としましては、  現在弊社が行っている業務内容と弊社のパートナープログラムとの間に  一定の方向性の違いがあり、現時点では御社にとって十分に良い結果を  お返しすることが難しいと判断したためでございます。     せっかくお声がけいただいたにもかかわらず、  このようなご回答となり誠に申し訳ございません。  何卒ご理解賜りますようお願い申し上げます。     また今後、業務内容や体制に変化が御座いました際には、  改めてご相談させていただくこともあるかと存じます。  その際にはどうぞよろしくお願いいたします。     末筆ながら、  御社のますますのご発展を心よりお祈り申し上げます。', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bfed3070-8fc1-499f-abea-c20b274f7da9', '65d58446-e7bc-4564-bc8a-dc8a9b01a789', 1, '2026-01-14', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4818b6ff-8e2d-46c8-ad0d-0212cc8cb7d4', '65d58446-e7bc-4564-bc8a-dc8a9b01a789', 2, '2026-01-14', '00000000-0000-0000-0000-000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a5cb6f4b-8c09-4d6f-8df0-728386f246ea', 'b71c9747-1201-421e-99ce-34fdddc7d56c', 1, '2026-01-14', '00000000-0000-0000-0000-000000000001', '没ネタ', '無料で試せるデモがあれば、問い合わせフォームAIとテレアポを検討したいとのこと 問い合わせフォームは写真や利用規約の突破ができない状況となるため、 そこが気になるのと、 テレアポもどこまで対応できるかが気になっているとのkとで、 気になっているそぶりが全く感じられない方になるので、上位のプランなどができれば連絡取る価値あり', NULL, NULL, NULL, '提案するか検討', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6aae1902-2982-4843-86b1-95af8731ecc0', 'b71c9747-1201-421e-99ce-34fdddc7d56c', 2, '2026-01-14', '00000000-0000-0000-0000-000000000001', '没ネタ', '無料で試せるデモがあれば、問い合わせフォームAIとテレアポを検討したいとのこと 問い合わせフォームは写真や利用規約の突破ができない状況となるため、 そこが気になるのと、 テレアポもどこまで対応できるかが気になっているとのkとで、 気になっているそぶりが全く感じられない方になるので、上位のプランなどができれば連絡取る価値あり', 'なし', '※補足営業資料・AIテレアポ提案・ソル資料・商材説明資料', NULL, '提案するか検討', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'de64fb29-c779-4de4-a942-a0f220874a30', '6bcf144b-c8f6-45c6-9a0d-7efdac0cb406', 1, '2026-01-05', '00000000-0000-0000-0000-000000000002', '失注', '固定じゃないと受けないし競合になるのでやらないとのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '274d9a53-78be-41f4-a3d6-bfe1180a8a60', '6bcf144b-c8f6-45c6-9a0d-7efdac0cb406', 2, '2026-01-05', '00000000-0000-0000-0000-000000000002', '失注', '固定じゃないと受けないし競合になるのでやらないとのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b8e57c27-0741-4fa3-87a0-ee3f145a20b8', '7c63c08f-2d75-4e07-8cb9-27a51a17b0b6', 1, '2026-01-05', NULL, 'リスケ', '無応答', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e7b70c12-607c-494b-af98-7761b93efec9', '7c63c08f-2d75-4e07-8cb9-27a51a17b0b6', 2, '2026-01-05', NULL, 'リスケ', '無応答', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8d13bfed-e8b1-4c92-a626-09f596b6d311', '660d01f3-1871-4b97-b157-5932556eb1b3', 1, '2026-01-13', '00000000-0000-0000-0000-000000000002', '代理店A', '電話に全然でない　日程調整のメール送付済み こちらで一旦AIテレアポの研修をしてAIツールの研修につなげる', NULL, NULL, NULL, '商材研修の日程調整', NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9022889f-4258-4491-a5db-42e985eaaf30', '660d01f3-1871-4b97-b157-5932556eb1b3', 2, '2026-01-08', '00000000-0000-0000-0000-000000000002', '代理店A', 'AIテレアポとAIツールで代理店になる 導入の話にはならず 録音が聞かせられなかった 初期費用値引ける話はしている', NULL, NULL, NULL, '商材研修の日程調整', NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '092589c5-f4e4-4a75-96c5-ff68119fd5c2', '660d01f3-1871-4b97-b157-5932556eb1b3', 3, '2026-01-13', '00000000-0000-0000-0000-000000000002', NULL, '電話に全然でない　日程調整のメール送付済み こちらで一旦AIテレアポの研修をしてAIツールの研修につなげる', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '30d59325-9920-48e2-88aa-c14f1b3db6a6', '93a9a58c-c95c-44a7-a3d8-0e6117174628', 1, '2026-02-06', '00000000-0000-0000-0000-000000000002', '失注', 'この度はご丁寧にご連絡をいただき、誠にありがとうございます。 また、社内にてご検討いただきましたこと、重ねて御礼申し上げます。  今回は見送りとのこと、承知いたしました。 また何かお力になれる機会がございましたら、 その際はぜひお声がけいただけますと幸いです。', NULL, NULL, '成果報酬受けてない', '検討結果確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8df869f8-caef-4196-84f2-d10bdfcfa2e1', '93a9a58c-c95c-44a7-a3d8-0e6117174628', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', 'C', '代理店としてであれば上長に確認しなければいけないとのこと 担当のため上長に投げて回答を待つという温度感 20日までに回答が無ければ上長のところで止まっているとのことなので理解してほしいとのこと', NULL, NULL, NULL, '検討結果確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '58581b33-94db-49b5-a930-a4ed640325a0', '93a9a58c-c95c-44a7-a3d8-0e6117174628', 3, '2026-02-06', '00000000-0000-0000-0000-000000000002', '失注', 'この度はご丁寧にご連絡をいただき、誠にありがとうございます。 また、社内にてご検討いただきましたこと、重ねて御礼申し上げます。  今回は見送りとのこと、承知いたしました。 また何かお力になれる機会がございましたら、 その際はぜひお声がけいただけますと幸いです。', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8f70214f-1ad8-4bf6-b3fe-abc8b6746ac6', '5b2bdf8f-1896-4149-88a0-097d007b1d67', 1, '2026-01-15', '00000000-0000-0000-0000-000000000001', 'C', '4月、5月ごろに6月で木が閉まり7月以降の予算を組むため、このぐらいにご連絡いただければ、来年度の予算に組み込める可能性ありとのこと', NULL, NULL, NULL, '予算組についてヒアリング', '2026-04-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b978f5ad-227f-4a62-b9d5-4063afcdb88e', '5b2bdf8f-1896-4149-88a0-097d007b1d67', 2, '2026-01-09', '00000000-0000-0000-0000-000000000001', 'C', '初期費用5万円で提示済み  株式会社アイランド・ブレイン　西本様 × 株式会社SoloptiLink  1. 商談概要  日時：本日  参加者： 　・株式会社アイランド・ブレイン　西本様 　・株式会社SoloptiLink  商談目的： 　アイランド・ブレイン社に対して、AIテレアポ・AI営業ツール・オニカナの紹介および導入可能性の協議。  2. 先方企業の事業内容・特徴  営業代行および営業コンサルティング事業を展開  約4,000社以上の支援実績  初期接触（一次アプローチ）の代行を主軸とし、 　「業種・業界・課題の有無・会話意欲」 などの条件を精査してアポイント提供を実施  問い合わせフォームの手作業送信も実施（1件単位対応）  3. 提供サービスの料金体系（先方）  商談1件あたり：18,000円  成約報酬：3〜5%  15万円以下の案件は成功報酬なし（※成果対象外）  4. 今回の商談でのポイント ◆ 先方ニーズ  一次アプローチの効率化  問い合わせフォーム送信の自動化  アポイント獲得率向上  工数削減（人手依存の軽減）  ◆ 弊社が提案したソリューション  AIテレアポ（音声AIによる自動架電×ヒアリング精度）  AI営業ツール一式（フォーム営業、リストAI、ロープレAI、など）  オニカナ（追加提案として紹介）  → 先方の既存事業との 親和性が高く、特に一次接触部分のコスト最適化が可能との評価。  5. 先方社内での検討状況  代表へ持ち帰り検討  自社の4,000社規模の支援モデルとのシナジーを確認中  既存クライアントへの横展開の可能性あり  6. ネクストアクション（確定）  先方からの回答日： 　→ 1月14日 もしくは 15日  想定される回答内容  導入可否  導入スケジュール  追加要望の有無  テスト期間の設定可否  7. SoloptiLink側 ToDo（社内）  先方代表向けに簡易導入資料を準備 （AIテレアポのデモ動画・料金表・比較表）  フォーム営業AIとAIテレアポの活用イメージ資料作成  14日 or 15日の返答後、即オンボーディング可能な体制準備  8. 次回商談の想定論点  AI活用範囲の具体化  既存クライアントに提供する際の料金設計  API連携 or 手動運用の選定  フォーム営業の自動化工数の見積もり  パートナー契約の条件（販売代理 or OEM）', NULL, NULL, NULL, '回答　際商談の流れ', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'aeda7624-4290-4875-b02d-48874d1e094b', '5b2bdf8f-1896-4149-88a0-097d007b1d67', 3, '2026-01-15', '00000000-0000-0000-0000-000000000001', NULL, '折り返し依頼済み', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7c87713e-3296-4748-a9d7-a6791a91a665', '5b2bdf8f-1896-4149-88a0-097d007b1d67', 4, '2026-01-15', '00000000-0000-0000-0000-000000000001', NULL, '4月、5月ごろに6月で木が閉まり7月以降の予算を組むため、このぐらいにご連絡いただければ、来年度の予算に組み込める可能性ありとのこと', NULL, NULL, NULL, '予算組についてヒアリング', '2026-04-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '46bd485b-8a4a-401b-9941-6284920610a1', 'd6c87b8b-6705-4667-872b-6f9d48aa563e', 1, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', 'ファンベストの元担当 AIツールが被ってるのと パートナー契約は全くしていないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '861bcf3a-a008-4dd0-9ec1-6d3d077696c9', 'd6c87b8b-6705-4667-872b-6f9d48aa563e', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', 'ファンベストの元担当 AIツールが被ってるのと パートナー契約は全くしていないとのことで終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c6cdec60-ed0d-4e42-89d4-0c98bdd797fe', '11d7370f-adaa-4ea9-b434-bd3e416b8a32', 1, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', 'AIツールは自社開発ツールの競合になるので取り扱えない　オニカナは気になるとのことだが既に導入済みだった', NULL, NULL, '成果報酬受けてない', 'オニカナの代理店', '2026-01-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bd7a6883-a897-44fc-85e9-34ca3c4d0bd4', '11d7370f-adaa-4ea9-b434-bd3e416b8a32', 2, '2026-01-05', '00000000-0000-0000-0000-000000000002', 'C', 'AIツールは自社開発ツールの競合になるので取り扱えない　オニカナは気になるとのことだが既に導入済みだった', NULL, NULL, NULL, 'オニカナの代理店', '2026-01-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c18dbf39-087b-4665-a657-36b52345a18d', '11d7370f-adaa-4ea9-b434-bd3e416b8a32', 3, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', NULL, NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9c365196-6c1b-4aaf-82ba-96b92af69263', '3ffb34d6-5584-46c6-be6b-9c3d78a6113b', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '体制の部分で整っていない状況で、コスト面の方がデカくなってしまうとのこと 現在稼働率が高い状況のため、今は難しいという結論となった', NULL, NULL, NULL, '検討結果確認', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '67029750-77fb-40a7-9f3d-b22804946aa8', '3ffb34d6-5584-46c6-be6b-9c3d78a6113b', 2, '2026-01-07', '00000000-0000-0000-0000-000000000001', 'C', '商談議事録（Minutes）  案件名：株式会社プルーセル様 商談 参加者：株式会社プルーセル 小平 様 / 株式会社SoloptiLink 小貫 実施日：2026年1月7日  1. 先方企業の業務スタイル・現状把握 ■ 架電体制  正社員が架電を担当する運用スタイル  対応する案件は 「セレブ」「グランドセントラル」 等の顧客案件  稼働状況は 50%稼働 のパターンもあり得る  ■ 契約形態  1ヶ月ごとの更新契約も十分あり得る → オペレーション難易度が高い一方、柔軟性を重視する傾向  ■2. パートナーモデルの実態・運用状況  パートナーは現状セールスマーカーを活用  ただし 利益ゼロで対応している状況  いわば、利益目的ではなく“枠の確保”や“顧客維持”を優先している構造  リストがない案件に対しても、セールスマーカーを提案  顧客にとってメリットが明確である場合に限り  セールスマーカー原価で販売するケースもあり  → つまり「利益は薄くても顧客価値最優先」で動く会社文化。 そのため、AIテレアポ導入時は 費用対効果の“即実感”が鍵となる。  3. 組織構造・意思決定に影響する点  役員2名の体制で意思決定  ただし「上信の話は跳ねられている」との言及あり → 社内の承認フローに一定の慎重姿勢 → 新しい取り組みは**“実績と根拠”が必須**なタイプ  4. 現時点の先方の判断状況・温度感 ■ 導入温度感  パートナーとしてのパターンで進める方向感が強い  自社運用＋代理店的販売の両面を想定  コスト構造と運用負荷を見極めたい意向  ■ 次回ステップ  19日中に返信あり  ネクスト面談（再面談）に進む可能性が高い  再面談では、細かな条件面・運用面のすり合わせが中心となる模様  資料をメール送付する必要あり → 送付先 小平 拓実 様 ✉️ t_kodaira@libcon.co.jp  5. SoloptiLink側の次回アクション（必須）  提案資料のメール送付（19日まで）  AIテレアポの運用フロー  コスト構造と利益率試算（セールスマーカー比較含む）  1ヶ月更新でも安定稼働するオペレーション案  リストなし案件の場合のAI活用モデル  再面談用アジェンダ（事前送付）  稼働率50%ケースでの費用対効果  正社員架電とAI架電の役割分担  代理店/パートナープラン時の利益モデル  OEM可否とブランド統一案  セールスマーカーとの差別化ポイントの明確化  AI×人のハイブリッド運用  精度改善サイクル  KPI管理ダッシュボード  原価率・利益率の改善ロジック  6. リスク・課題認識（先方観点）  社内承認フローが慎重（上信に跳ねられた前例）  既存パートナー（セールスマーカー）との整合性  1ヶ月更新／50%稼働で利益が残るかの懸念  リストなし案件の成功確度  → こちらは“数字”と“運用実績”で解消すべきポイント。  7. 商談の総括（所感）  先方は、単なる導入ではなく 「自社の運用と収益にどう影響するか」を極めてシビアに見ています。  特にポイントは以下の3点：  原価に近い価格での提供が必要な場面もある  正社員架電とAIの住み分けを具体で示す必要がある  1ヶ月更新であっても負けない収益モデルの構築  これらをクリアすれば、 パートナー化＋外販展開まで視野に入り、長期的な案件に発展する可能性が高い。', NULL, NULL, NULL, '検討結果確認', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '91940d9c-f967-44dc-9da6-e21d3a54bce4', '3ffb34d6-5584-46c6-be6b-9c3d78a6113b', 3, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '体制の部分で整っていない状況で、コスト面の方がデカくなってしまうとのこと 現在稼働率が高い状況のため、今は難しいという結論となった', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '310d37bd-2d78-4889-bbba-44b6bcc40672', 'd5907947-bfb1-4977-bc64-fded73501887', 1, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', 'ご依頼内容について関係部署と協議をいたしましたが、現在のリソース確保が難しい状況にあり、  誠に恐縮ながら今回はご依頼をお引き受けすることができません。  貴社のご期待にお応えできない形となり、大変申し訳ありません。  なお、メールでのお返事となりましたこと、お詫び申し上げます。  ご理解いただけますと幸いです。', NULL, NULL, '成果報酬受けてない', '代理店の検討結果', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '359bd9f0-b1c1-4069-afb9-bc1a19b9cdd9', 'd5907947-bfb1-4977-bc64-fded73501887', 2, '2026-01-13', '00000000-0000-0000-0000-000000000002', 'C', 'テレアポやフォーム営業をしている 導入の具体的な話にならず リスト生成などのツールは良く話が来る 基本固定報酬しか受けてないが一応社内に展開はできるとのこと コールアポ率　2～3％ 受注率　30％で案内', NULL, NULL, NULL, '代理店の検討結果', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9f9fa63b-40ce-48ea-890c-e975a91ca83d', 'd5907947-bfb1-4977-bc64-fded73501887', 3, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', 'ご依頼内容について関係部署と協議をいたしましたが、現在のリソース確保が難しい状況にあり、  誠に恐縮ながら今回はご依頼をお引き受けすることができません。  貴社のご期待にお応えできない形となり、大変申し訳ありません。  なお、メールでのお返事となりましたこと、お詫び申し上げます。  ご理解いただけますと幸いです。', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6a8a9768-b708-4ec6-8798-3bc957363205', '4e08c677-7873-495d-b05d-eeda60cb7a21', 1, '2026-01-13', '00000000-0000-0000-0000-000000000002', 'ネタ', 'セールスマネージャー 成果報酬は受けてないので代理店は厳しそうだと 商談だけの代行はやってるので 今後お願いすることがあるかもしれないと伝えた リスト作成が導入として気になる状況だが 1/5開始で半年利用するリストサービスを導入したばかり ただ営業代行としてリストたくさんほしいので良いサービスであれば 並行して使う事も考えてないので 一度代表に確認して商談受けるか検討', NULL, NULL, NULL, '小貫さんが再面談', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8bd27664-c213-4374-9712-aaa6415e44d6', '4e08c677-7873-495d-b05d-eeda60cb7a21', 2, '2026-01-13', '00000000-0000-0000-0000-000000000002', 'ネタ', 'セールスマネージャー 成果報酬は受けてないので代理店は厳しそうだと 商談だけの代行はやってるので 今後お願いすることがあるかもしれないと伝えた リスト作成が導入として気になる状況だが 1/5開始で半年利用するリストサービスを導入したばかり ただ営業代行としてリストたくさんほしいので良いサービスであれば 並行して使う事も考えてないので 一度代表に確認して商談受けるか検討', NULL, NULL, NULL, '小貫さんが再面談', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '10e0014c-25e2-45ef-a496-3f45d88d57d7', '559dba91-ab79-48d9-920b-b06ccbdb1a62', 1, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '代理店として動くのは厳しいという結論に至った', NULL, NULL, '成果報酬受けてない', '代理店の検討結果確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0d28f272-90b9-4971-9ab2-2d28f2fcd7c9', '559dba91-ab79-48d9-920b-b06ccbdb1a62', 2, '2026-01-13', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリングした先方の情報】 ・ネクストアークは「アポ獲得〜トスアップのみ」も「クロージングまで」も案件/商材次第で対応可能 　- 高単価・専門性が必要なものはメーカー側クロージングが望ましい 　- 低単価・導入ハードルが低いものは自社で巻き取り（クロージング）も可 ・先方（中村さん）はコールセンター経験20年で、通話/秒課金の相場感を重視 　- 料金面（通話コスト、短時間切断時の課金）に敏感 ・リスト生成は「情報元（どのサイトから拾ったか）」が価値になる、という問題意識あり 　- 特定サイトから抽出できるか、URL指定できるかを強く確認したい  【こちらが提案した内容】 ・当社のAI商材をパートナー（紹介/代理店）として取り扱ってもらう提案 　- 初期費用/月額の一定割合をストック型で還元（トスアップ・クロージングそれぞれの%支払い） 　- 在庫リスクなし、契約費用0円、最初は低リソースで紹介から開始可能 　- 商材は現時点で約10種、今後「月1商材追加」予定でアップセル/クロスセルも可能 ・主要商材の説明 　1) AIテレアポ（一次対応：受付突破〜責任者接続→人に転送） 　　- 録音吹き込み型で肉声感、AIとバレにくい 　　- AIが複数回線で架電し、生産性向上 　　- 料金：初期費用 50万円、利用はチャージ式（例：20万円で約13,000コール目安。超過は追加チャージ） 　　- 途中運用：オペレーターが「発信ボタン」を押してAIが複数回線発信→繋がったらリアルタイムで聞きながら適切なタイミングで人が切替 　　- スクリプト/出口判定：キーワードと優先順位で分岐、運用しながら最適化。初期は当社が構築サポート 　2) AIツール群（ライトアップ社と共同開発の10ツール群） 　　- リスト生成AI：細かい条件でWebから抽出。担当者名/メール/FAXも取得、抽出後の自動メール送信も可能 　　　・月額3万円（目安：月1〜1.2万件程度抽出＝1件あたり約3円相当） 　　- フォーム営業AI：1件5円、到達率100%を訴求（CAPTCHA突破含む） 　　- 名刺フォローAI：名刺読み込み→SNS投稿など含め情報収集しフォローに活用 　　- パッケージ：初期費用50万円＋月額11万円（単体販売も可）  【先方の回答】 ・AIテレアポについて 　- 機能の良し悪しはこの場では判断しきれない 　- 通話費用が高く見える（短時間で切られても15円課金される点がコールセンター目線で懸念） 　- コスト削減訴求だと刺さりにくい可能性がある 　- オーナー不在時に「戻り時間/繋がりやすい時間」をヒアリングしてタグ付けできる点は理解 　- オペレーター起点で発信する仕様（完全自動発信ではない）も理解 ・リスト生成について 　- 「食べログ等の特定サイトから抽出できるか」「情報元が分かるか」を質問 　- 当社回答：情報元は基本出ない。検索キーワードにサイト名を入れればそのサイト由来の抽出になる 　- 先方懸念：サイト名が本文に出ているだけの無関係ページも拾うのでは？ 　- 当社：URL指定で抽出できるかは確認して回答する（宿題） ・パートナー提携について 　- 紹介契約自体は実施しているので形式としては可能 　- ただし「お試し」など導入ハードルが低い座組が無いと紹介しづらい 　- 月額解約：AIツール群はいつでも停止可、AIテレアポは最低3ヶ月 　- 試用プランは現状なし。代替として値下げ対応は可能 　　・代理店が自社利用の場合：初期費用0も可能 　　・代理店が販売する場合：初期費用は最大10万円程度まで下げて提供可能 ・次の動き 　- 先方：資料を社内共有して検討するので、資料送付を希望 　- 先方：今週中（遅くても）回答する  【その他】 ・宿題（ToDo） 　- リスト生成AIで「特定サイトURL指定で抽出が可能か」を確認して回答する 　- 商談用のデモ動画/資料一式を先方へ送付する ・合意事項 　- 資料送付→先方社内検討→今週中回答→必要なら追加説明（詳細研修/再説明）を実施', NULL, NULL, NULL, '代理店の検討結果確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '53eb4eef-0636-4e8c-a353-2eeca24797ca', '559dba91-ab79-48d9-920b-b06ccbdb1a62', 3, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '代理店として動くのは厳しいという結論に至った', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '866f0e44-823c-439d-8415-5c16eab28a56', 'b22a02fd-767d-4e8d-8206-d76c608b1f32', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬はリソースが用意できない', NULL, NULL, '成果報酬受けてない', '代理店の検討結果確認', '2026-01-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e38e2ab1-e7c9-433b-bbe2-bb6ed346523f', 'b22a02fd-767d-4e8d-8206-d76c608b1f32', 2, '2026-01-15', '00000000-0000-0000-0000-000000000002', 'C', '小池様ともう一名参加どちらも担当 導入の話にはならず サービス良いとはなっている 固定報酬しか受けてない状態なので 社内で検討して来週回答', NULL, NULL, NULL, '代理店の検討結果確認', '2026-01-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8ca7ef19-39ef-45bc-8fe0-5b19a0e778fc', 'b22a02fd-767d-4e8d-8206-d76c608b1f32', 3, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬はリソースが用意できない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '870e8aa2-3a84-40a1-993c-587c21c6c036', '530227bd-de19-4544-b688-9fa64d353473', 1, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬を受けてないのと この企業もAIテレアポなどの営業療育のAIツールをすでに取り扱っている', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '50ca6d77-19dd-47aa-8272-5005bcbd2b6c', '530227bd-de19-4544-b688-9fa64d353473', 2, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬を受けてないのと この企業もAIテレアポなどの営業療育のAIツールをすでに取り扱っている', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5adb78ca-bd06-4476-a492-79ee810341f2', '3aeba8df-a127-4cf0-a6bc-2b180eb6b282', 1, '2026-01-14', '00000000-0000-0000-0000-000000000001', 'A', 'ハチドリエージェントを追加発注 リスト生成AIに関しては、ライトアップ側でリストをポータルサイトし指定で行う 契約変更 契約書の内容 初期費用　初期費用15% └25%修正する  下記確認中  PITK→からの請求書作成の時に、 └初期費用30万円で、月額費用の無料期間をつけることは可能か確認  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認  契約まわり リライズ→ウェブ系は エグゼグティブマーケティングジャパンの内容でマーケティングを行い、  面談予約の部分は小貫のタイムレックスで飛ぶ状態となる └  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認 スタンダードプラン └でできる    資料請求に対して数十件で確認 └ページが出来上がって   契約書の内容 初期費用　初期費用15% └25%修正する  開始タイミング　月内には了承もらえるようにする 2月以降送客 SEO、AIOで行っていく  AIツール　公式ライン2000〜3000点あるため、どの商材で行くか、 採用自動化AI  エグゼグティブマーケティングジャパンで掲載をお', NULL, NULL, NULL, '回答 PITK→からの請求書作成の時に、 └初期費用30万円で、月額費用の無料期間をつけることは可能か確認  契約書の内容 初期費用　初期費用15% └25%修正する  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認', '2026-01-14'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b24f0d12-6f93-4dcc-b705-01901534eb34', '3aeba8df-a127-4cf0-a6bc-2b180eb6b282', 2, '2025-12-31', '00000000-0000-0000-0000-000000000001', '受注', 'リストAI初期10万円、月額3万円 AIテレアポ初期10万円　月額20万円', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3725729f-4b15-48ca-aed7-1a43a46d7402', '3aeba8df-a127-4cf0-a6bc-2b180eb6b282', 3, '2026-01-07', '00000000-0000-0000-0000-000000000001', 'A', 'アップせるでLシンク導入　1万円で導入となる 採用に関しても導入検討中', NULL, NULL, NULL, '検討状況確認　基本連絡待ちのスタンスでOK', '2026-01-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f156bedb-22eb-48ac-a086-73d2dc19ef6b', '3aeba8df-a127-4cf0-a6bc-2b180eb6b282', 4, '2026-01-14', '00000000-0000-0000-0000-000000000001', 'A', 'ハチドリエージェントを追加発注 リスト生成AIに関しては、ライトアップ側でリストをポータルサイトし指定で行う 契約変更 契約書の内容 初期費用　初期費用15% └25%修正する  下記確認中  PITK→からの請求書作成の時に、 └初期費用30万円で、月額費用の無料期間をつけることは可能か確認  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認  契約まわり リライズ→ウェブ系は エグゼグティブマーケティングジャパンの内容でマーケティングを行い、  面談予約の部分は小貫のタイムレックスで飛ぶ状態となる └  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認 スタンダードプラン └でできる    資料請求に対して数十件で確認 └ページが出来上がって   契約書の内容 初期費用　初期費用15% └25%修正する  開始タイミング　月内には了承もらえるようにする 2月以降送客 SEO、AIOで行っていく  AIツール　公式ライン2000〜3000点あるため、どの商材で行くか、 採用自動化AI  エグゼグティブマーケティングジャパンで掲載をお', NULL, NULL, NULL, '回答 PITK→からの請求書作成の時に、 └初期費用30万円で、月額費用の無料期間をつけることは可能か確認  契約書の内容 初期費用　初期費用15% └25%修正する  タイムレックスのプランで、面談予約が入った時に、小貫とGメール、リライズ側に飛ぶようにする └リライズ側で方法確認', '2026-01-14'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0637cebd-19a7-407b-bbf2-dea1524ad86b', '00ea8828-3ecc-49ae-aa3b-7a5d52c70899', 1, '2026-01-13', '00000000-0000-0000-0000-000000000001', '失注', '成果報酬形式の内容は一歳行わないとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5a4f795e-eef0-458f-ac75-122b8c99cb5b', '00ea8828-3ecc-49ae-aa3b-7a5d52c70899', 2, '2026-01-13', '00000000-0000-0000-0000-000000000001', '失注', '成果報酬形式の内容は一歳行わないとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '12a40722-e4a4-4667-b358-1bdc8834d9d8', 'ab3c07e1-f3ff-40a3-bb1b-44badec8dbbc', 1, '2026-01-14', '00000000-0000-0000-0000-000000000002', '失注', '頂戴した資料およびインセンティブ条件に基づき社内で検討いたしました。 結論から申し上げますと、誠に残念ながらこの度のお申し出につきましては、 見送らせていただくこととなりました。  弊社では、既に営業DXおよびAI導入支援領域において他社とパートナー契約を締結しており、 現在はそちらの展開にリソースを集中させている状況にございます。  貴社の条件についても併せて検討いたしましたが、既存の提携先との棲み分けや、 弊社の収益基準に照らし合わせた際の運用コスト等を総合的に判断した結果、 現時点で新規にパートナーシップを構築することは難しいとの結論に至りました。', NULL, NULL, 'AIはNG', '検討結果確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e0ee7429-0b2b-4b54-9a53-5c4b368f9b06', 'ab3c07e1-f3ff-40a3-bb1b-44badec8dbbc', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', 'C', '営業代行事業部の担当 代理店の話となると上長の確認が必要なので1週間検討 導入も興味あると　特にAIテレアポ リスト作成へセールスマーカーを使っている 話が進むことになったら上長含めて再度打合せ オートコールシステムは使っている', NULL, NULL, NULL, '検討結果確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd00490f2-9366-463b-a1b4-fc79d79e254d', 'ab3c07e1-f3ff-40a3-bb1b-44badec8dbbc', 3, '2026-01-14', '00000000-0000-0000-0000-000000000002', '失注', '頂戴した資料およびインセンティブ条件に基づき社内で検討いたしました。 結論から申し上げますと、誠に残念ながらこの度のお申し出につきましては、 見送らせていただくこととなりました。  弊社では、既に営業DXおよびAI導入支援領域において他社とパートナー契約を締結しており、 現在はそちらの展開にリソースを集中させている状況にございます。  貴社の条件についても併せて検討いたしましたが、既存の提携先との棲み分けや、 弊社の収益基準に照らし合わせた際の運用コスト等を総合的に判断した結果、 現時点で新規にパートナーシップを構築することは難しいとの結論に至りました。', NULL, NULL, 'AIはNG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd6eb3d4e-e5ac-47be-83fc-d7bf925c3b10', '40ef11d3-3d54-41f8-8f90-4c783dea0cd5', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '1コール何円という形でしか受けてないので今回は見送り AIテレアポも今は大丈夫かなと', NULL, NULL, '成果報酬受けてない', '検討結果確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9bc533a7-6325-4773-b88f-d99f4f48a925', '40ef11d3-3d54-41f8-8f90-4c783dea0cd5', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', 'C', '1週間検討 AIテレアポの導入の可能あり 基本はテレマでのトスアップ形式 代理店と導入の両方で検討', NULL, NULL, NULL, '検討結果確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '05e9c787-78d7-4d49-8605-ccfa2e23aebc', '40ef11d3-3d54-41f8-8f90-4c783dea0cd5', 3, '2026-01-15', '00000000-0000-0000-0000-000000000002', '失注', '1コール何円という形でしか受けてないので今回は見送り AIテレアポも今は大丈夫かなと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1f4ec59e-4081-4c62-ac83-fb3e2de129bb', 'f7ea5181-758a-4c8f-a2dc-379f8b666bc5', 1, '2026-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '67580f46-dc3a-476a-81f8-d370c1ff8c32', 'f7ea5181-758a-4c8f-a2dc-379f8b666bc5', 2, '2026-01-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1c6b40a4-0917-4d11-9056-60906e3334a4', '9d259f8c-dc45-4e0f-8023-8961c1f1c3ec', 1, NULL, NULL, '消滅', '理由は対応できるメンバーがいないためです。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '56efcbc6-0625-497d-8fb5-6bc53414f72a', '9d259f8c-dc45-4e0f-8023-8961c1f1c3ec', 2, NULL, NULL, '消滅', '理由は対応できるメンバーがいないためです。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2d737cf2-2adf-46b6-a67d-66dac875332b', '0005cfea-869e-4222-b097-32ad489e5ad2', 1, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', '付き合いのある企業には合わないと思うとのこと 営業代行がメインで導入としてはなさそう また、ソルオプティリンクのような営業力が強そうな企業の支援は営業力にそこまで自信がないので合わないと思うと冒頭に言ってきた ただ機会があれば企業の紹介はしたいとのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '742e9ab5-7b63-45b0-b6a8-a9f0ad5139fa', '0005cfea-869e-4222-b097-32ad489e5ad2', 2, '2026-01-09', '00000000-0000-0000-0000-000000000002', '失注', '付き合いのある企業には合わないと思うとのこと 営業代行がメインで導入としてはなさそう また、ソルオプティリンクのような営業力が強そうな企業の支援は営業力にそこまで自信がないので合わないと思うと冒頭に言ってきた ただ機会があれば企業の紹介はしたいとのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4d8beabc-ccf9-4e1b-aa22-ed4e1ef869aa', '023aa5a7-76bc-4730-a1ad-5e9bd43b61be', 1, '2026-01-13', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬受けてないのと リスト作成やテレアポは競合になるのでこちらでは売れないというど担当の意見で終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2bd2ec79-81b0-4326-a88f-7ed87d91e39b', '023aa5a7-76bc-4730-a1ad-5e9bd43b61be', 2, '2026-01-13', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬受けてないのと リスト作成やテレアポは競合になるのでこちらでは売れないというど担当の意見で終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c63d10ab-465a-4501-aa7d-50d8e561fa13', 'b9f55d83-2b60-4477-903d-de045d72d7c0', 1, '2026-01-10', '00000000-0000-0000-0000-000000000001', '失注', '柔軟性皆無の会社 固定報酬の案件しか行っていなく、 資料作成を5万円で提供できる旨伝えて、終了 パワポで資料を作っている', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '75bafc77-8416-4b2a-bc59-6cef8accf61e', 'b9f55d83-2b60-4477-903d-de045d72d7c0', 2, '2026-01-10', '00000000-0000-0000-0000-000000000001', '失注', '柔軟性皆無の会社 固定報酬の案件しか行っていなく、 資料作成を5万円で提供できる旨伝えて、終了 パワポで資料を作っている', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '15de9ded-f64b-4fcb-bf1e-615bfdbd0b2f', 'bcb25048-f130-40a2-8aa0-1e2d30686970', 1, '2026-01-17', '00000000-0000-0000-0000-000000000001', 'C', '採用自動化AIを導入して検討したいとのこと 初期費用0円にし、月額3万円で導入検討、追加でAI商材とAiステップアップ、契約書を送付', NULL, NULL, NULL, '解答', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ce473b30-d913-4f60-bd8f-11892ee70eeb', 'bcb25048-f130-40a2-8aa0-1e2d30686970', 2, '2026-01-11', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜株式会社クイヒラリ 高橋様 ■ 背景・現状認識  高橋様は経営者交流会等のネットワークに幅広く参加しており、紹介可能なパイプが多数存在。  これまで Bアイドマへ約10社トスアップしてきたが、 ・対応品質の課題 ・クレーム多発 ・紹介先の満足度低下 →その結果、評判を下げてしまい、これ以上紹介したくない状況になっている。  ■ 本日のポイント  AIテレアポ（AIアポ取得型サービス）については、 「紹介しやすい」商材として非常に前向きに評価。  高橋様としても、 → 現状の紹介先クオリティ問題を解消しつつ → 自身の人的ネットワークに安心して提案できる商材 を求めており、SoloptiLink側のAIサービスに大きな期待感。  ■ 深く興味を持った領域  特に 「採用・人材確保」に関連するAIツール に強い関心を示した。  採用フローの自動化  候補者フォローの自動化  応募獲得単価の最適化  人事負荷の削減 → この領域は高橋様の周辺企業でもニーズが高く、紹介しやすいとの見解。  ■ 次回アクション  採用系AIツールの詳細説明会を実施することで合意。  日程は タイムレックスにて調整中。  次回は以下の内容を中心に高橋様に説明予定：  採用AIの具体機能（自動応答・自動スクリーニング等）  導入事例と改善幅（コスト削減・採用数の向上など）  高橋様の顧客に紹介した際のメリット  取次や代理店スキームの整理（紹介料・継続報酬など）  ■ 全体の温度感  紹介に対する心理的抵抗が解消できれば、継続的なパートナリングが可能。  特に採用領域は「即紹介可能性が高い」ため、次回提案での期待値は高い。  今回の印象として、 “信頼できる商材を提供できるか？” が最大の焦点。', NULL, NULL, NULL, '再度日程調整確認', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '05a3634b-e43a-4a3d-aba0-3ac51260b328', 'bcb25048-f130-40a2-8aa0-1e2d30686970', 3, '2026-01-17', '00000000-0000-0000-0000-000000000001', 'C', '採用自動化AIを導入して検討したいとのこと 初期費用0円にし、月額3万円で導入検討、追加でAI商材とAiステップアップ、契約書を送付', NULL, NULL, NULL, '解答', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9f35a41a-b13e-4d32-83ce-ac09db53ee48', '26005779-2f93-48a3-97ff-5cfc6a67af05', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '新規営業を行わないということで、導入NGとなった', NULL, NULL, NULL, '検討状況確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0ede72b4-2720-4d8c-b7dd-aae34f0a9627', '26005779-2f93-48a3-97ff-5cfc6a67af05', 2, '2026-01-07', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポの導入検討及び、AIツールの説明を行い、 自社で取り扱うか否かを決定していく流れ チャットワークは交換済みのため、連絡待ちの状況となる', NULL, NULL, NULL, '検討状況確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '74b2f926-3468-464a-97bd-cc2f08ea4748', '26005779-2f93-48a3-97ff-5cfc6a67af05', 3, '2026-01-20', '00000000-0000-0000-0000-000000000001', NULL, 'チャットワークにて検討確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '993d2866-4102-408e-8d6c-779311905c9f', '26005779-2f93-48a3-97ff-5cfc6a67af05', 4, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '新規営業を行わないということで、導入NGとなった', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6683094c-86c3-4676-a5e7-9da91f2cdf4b', '35843818-1bf1-4ca4-8074-b8f5fdee42a0', 1, '2026-01-16', '00000000-0000-0000-0000-000000000002', 'C', '現在社内で検討中', NULL, NULL, NULL, '検討結果確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ba949374-d669-46a8-94dd-8367538779a6', '35843818-1bf1-4ca4-8074-b8f5fdee42a0', 2, '2026-01-08', '00000000-0000-0000-0000-000000000002', 'C', 'パートナーと導入の検討 代表に確認すると  すでにお付き合いのある既存企業に紹介できるとのこと 仕入れて販売するのありかという相談もあり チャットワークで今後やり取りしていく', NULL, NULL, NULL, '検討結果確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6f1fb217-ffdf-4072-ac72-1c5a19e75072', '35843818-1bf1-4ca4-8074-b8f5fdee42a0', 3, '2026-01-16', '00000000-0000-0000-0000-000000000002', 'C', '現在社内で検討中', NULL, NULL, NULL, NULL, '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5e6ea045-6b5c-4b1c-a2d7-48f29fa329b9', '5dc932f2-a4c4-4cbc-b1fd-6dcb2cc29b1c', 1, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'お試しのやつも興味があれば連絡するとのことで失注', NULL, NULL, '使いこなせない', '代理店と導入の検討結果', '2026-01-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '92009e7f-b442-4115-821f-6da0c1f8fcae', '5dc932f2-a4c4-4cbc-b1fd-6dcb2cc29b1c', 2, '2026-01-13', '00000000-0000-0000-0000-000000000002', 'C', '導入と代理店の両方で検討 この会社が導入であれば初期費用0円での案内 今週中に回答 フォーム営業を自社で導入してクライアント の要望に対して利用するのはありかなと  商談代行もやってる', NULL, NULL, NULL, '代理店と導入の検討結果', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b4b3b684-0b8d-43dd-aeb8-c20886481368', '5dc932f2-a4c4-4cbc-b1fd-6dcb2cc29b1c', 3, '2026-01-16', '00000000-0000-0000-0000-000000000002', 'C', 'メール送れてなかったので(メアド修正済み) 再度送付 来週検討結果伺い', NULL, NULL, NULL, NULL, '2026-01-22'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1cced407-104c-4da5-b266-642436a1c8ec', '5dc932f2-a4c4-4cbc-b1fd-6dcb2cc29b1c', 4, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'お試しのやつも興味があれば連絡するとのことで失注', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9b6b9d8e-49be-49ee-9dbf-0cc929bad22f', 'cf1db981-5633-4bb0-b3f7-d748799f7963', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', 'ネタ', '営業戦略の大黒様　マーケティング部の飯田様 代理店契約は組めないが この企業の持つパートナー企業に3時代理店となるように大黒様がお声がけいただける 興味を持った場合も紹介してもらってこちらで直接パートナーとしての面談をする →3時代理店の際の報酬体系の打合せは別途必要  AIテレアポの導入はかなり気になるとのこと 社内で検討したいとのことでかなり詳しく説明 初期費用も0円での提案可能と伝え済み 2月で期が変わるので現在予算編成中 1月末に一度検討状況を伺う', NULL, NULL, NULL, 'ＡＩテレアポの導入検討結果', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '99575f8a-a530-4108-8d87-55c0cac97161', 'cf1db981-5633-4bb0-b3f7-d748799f7963', 2, '2026-01-15', '00000000-0000-0000-0000-000000000002', 'ネタ', '営業戦略の大黒様　マーケティング部の飯田様 代理店契約は組めないが この企業の持つパートナー企業に3時代理店となるように大黒様がお声がけいただける 興味を持った場合も紹介してもらってこちらで直接パートナーとしての面談をする →3時代理店の際の報酬体系の打合せは別途必要  AIテレアポの導入はかなり気になるとのこと 社内で検討したいとのことでかなり詳しく説明 初期費用も0円での提案可能と伝え済み 2月で期が変わるので現在予算編成中 1月末に一度検討状況を伺う', NULL, NULL, NULL, 'ＡＩテレアポの導入検討結果', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0fa4a2c9-ea29-497b-9010-0f2176f28250', '8f55303e-a14a-4340-9a4d-1ec50747cff2', 1, '2026-01-08', '00000000-0000-0000-0000-000000000001', '没ネタ', '商談サマリー｜株式会社Univearth 山本泰地 様  ■ 商談相手 株式会社Univearth　山本 泰地 様 （同席：平田 様）  1. 現状の営業活動と課題認識  12月に大規模イベントが控えており、顧客獲得のための入口としてテレアポを実施している。  現在はランダムなリスト収集ではなく、展示会出店で取得した名刺・リストが中心。  物流・運送業界向けイベントでも同様の構造で、展示会リード・既存人脈を軸に営業を展開中。  2. リード獲得の仕組みと営業体制の変遷  昨年は3名体制の営業チームで進行。  現在は山本様が1名で全営業を実行している状況。  “人に依存しない自動的なリード流入”＝仕組み化された営業エコシステム構築が理想と明言。  3. AIテレアポに対する評価と導入意向  展示会リスト活用の延長として、テレアポは極めて有効なアプローチであるとの認識。  AIテレアポについてはポジティブな印象を持ちつつも、  現状の運送・物流業界の特性  実装段階のプロダクト状況 から、「今は導入タイミングではない」と判断。  4. 将来の方向性とプロダクト適合性  Univearthとしては、将来的にプラットフォーム運営（物流×DX）を目指す方針。  現時点のAIテレアポは「ニーズを完全に満たす段階ではなく、改善フェーズ」という評価。  十分に業界適合が進んだタイミングで導入を検討したいとの明確な意向あり。  5. 全体的な印象・示唆  **意思決定は前向きだが“タイミング待ち”**という状態。  運送・物流は属人的営業が根強いが、その分リード獲得の自動化価値は高い市場。  展示会リストは質が高いため、AIテレアポとの相性は非常に良い。  プラットフォーム構想があるため、将来的にAPI連携・OEMの余地が十分ある。  6. ネクストアクション（SoloptiLink視点）  **業界特化テンプレ（物流・運送向けスクリプト）**が完成したタイミングで最速共有  展示会リード専用のフォローアップAIシナリオを作成して提案  プロダクト改善進捗（会話精度・CRM連携・API化）を月次レポート形式で共有  12月イベントに合わせた短期検証プランの提案も候補  まとめ（短縮版）  訪問営業＋展示会リスト中心のプロセス → テレアポが最適解  プロダクト改善後に導入意欲あり  将来は物流系プラットフォーム運営を志向  営業組織縮小に伴い、自動化ニーズは非常に強い  12月イベントを基点に再提案の機会大', NULL, NULL, NULL, 'プロダクト開発が終わったのか確認', '2026-04-01'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e4062cfe-8bac-42a2-a783-b1fd124ac93e', '8f55303e-a14a-4340-9a4d-1ec50747cff2', 2, '2026-01-08', '00000000-0000-0000-0000-000000000001', '没ネタ', '商談サマリー｜株式会社Univearth 山本泰地 様  ■ 商談相手 株式会社Univearth　山本 泰地 様 （同席：平田 様）  1. 現状の営業活動と課題認識  12月に大規模イベントが控えており、顧客獲得のための入口としてテレアポを実施している。  現在はランダムなリスト収集ではなく、展示会出店で取得した名刺・リストが中心。  物流・運送業界向けイベントでも同様の構造で、展示会リード・既存人脈を軸に営業を展開中。  2. リード獲得の仕組みと営業体制の変遷  昨年は3名体制の営業チームで進行。  現在は山本様が1名で全営業を実行している状況。  “人に依存しない自動的なリード流入”＝仕組み化された営業エコシステム構築が理想と明言。  3. AIテレアポに対する評価と導入意向  展示会リスト活用の延長として、テレアポは極めて有効なアプローチであるとの認識。  AIテレアポについてはポジティブな印象を持ちつつも、  現状の運送・物流業界の特性  実装段階のプロダクト状況 から、「今は導入タイミングではない」と判断。  4. 将来の方向性とプロダクト適合性  Univearthとしては、将来的にプラットフォーム運営（物流×DX）を目指す方針。  現時点のAIテレアポは「ニーズを完全に満たす段階ではなく、改善フェーズ」という評価。  十分に業界適合が進んだタイミングで導入を検討したいとの明確な意向あり。  5. 全体的な印象・示唆  **意思決定は前向きだが“タイミング待ち”**という状態。  運送・物流は属人的営業が根強いが、その分リード獲得の自動化価値は高い市場。  展示会リストは質が高いため、AIテレアポとの相性は非常に良い。  プラットフォーム構想があるため、将来的にAPI連携・OEMの余地が十分ある。  6. ネクストアクション（SoloptiLink視点）  **業界特化テンプレ（物流・運送向けスクリプト）**が完成したタイミングで最速共有  展示会リード専用のフォローアップAIシナリオを作成して提案  プロダクト改善進捗（会話精度・CRM連携・API化）を月次レポート形式で共有  12月イベントに合わせた短期検証プランの提案も候補  まとめ（短縮版）  訪問営業＋展示会リスト中心のプロセス → テレアポが最適解  プロダクト改善後に導入意欲あり  将来は物流系プラットフォーム運営を志向  営業組織縮小に伴い、自動化ニーズは非常に強い  12月イベントを基点に再提案の機会大', NULL, NULL, NULL, 'プロダクト開発が終わったのか確認', '2026-04-01'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f1e8c2c7-e7a5-4493-a0d0-0fa0515e2d3d', 'ad86d716-0e43-442b-b865-b3e3d0027a26', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', 'ラインにて検討状況の確認', NULL, NULL, NULL, '所管確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4b5116b8-ea04-480c-8f2d-4b19455c1dc4', 'ad86d716-0e43-442b-b865-b3e3d0027a26', 2, '2026-01-09', '00000000-0000-0000-0000-000000000001', 'C', '商談議事録｜ninjapan株式会社 尾西様  日時： 不明 参加者： ninjapan株式会社 尾西様 / 株式会社SoloptiLink  1. 事業概要・現状認識 ■ メイン事業  ToC向けサービスが主軸  大学生向け就活塾を運営  キャリア支援に伴走  高学歴層の学生が中心  人材紹介事業も並行して実施（採用支援まで対応）  **人事部アウトソーシング（BPO）**サービスも展開  ■ 営業・マーケティング  公式LINEでの個別カウンセリング導線  LP → カウンセリング申し込み → LINE流入 → 個別対応  提携企業を複数保持  アンケート情報を活用してニーズ把握  2. 顧客開拓・営業手法について ■ 人材紹介先開拓方法  営業代行の活用  既存クライアントからのリファラル  求人データベースの活用  学生接点が強い点から求人サイト側から逆に紹介されるケースも多い  常に新規の人材紹介先を開拓したい意向あり。 経営課題レベルで解決できる提案を求めている。  ■ テレアポ・アポイント獲得  レディクルをメインで利用  学生の質を担保するため、エンタープライズ企業向けのアポイントに注力したい  セミナー／ウェビナー経由の接点も増加中  3. 現在抱えている課題 ■ ToC事業の課題（ストック型）  ストック収益のため安定性は高いが、 常時リードを安定確保したいというニーズが強い  自動化と効率化が急務  ■ ToB事業の課題（エンタープライズ向け）  より大企業向けのリーチを強化したい  予算計上される形で安定供給されるスキームを求めている  新規事業として受発注支援やDX支援の可能性も模索  4. 新規の可能性・提案連携余地 ■ 受託開発案件  ninjapan側に流入する案件を受発注として流す可能性あり  ■ LINE運用アカウント  公式LINEアカウント規模  メイン：3,000〜4,000人  他アカウント：500人 × 3つ  計5,000〜6,000名規模のユーザー対応が発生  これをAI化・自動化した場合のコスト試算を求めている。  5. 当社側からの提案内容（SoloptiLink）  今回提示した商材：  リストAI  問い合わせフォーム営業AI  採用自動化AI  AIエージェント（チャット/対応自動化）  初期費用：5万円で提案済み。  特に、  採用活動  LINE自動対応  エンタープライズ向けリード獲得 での活用意義が高いとの評価。  6. 次回アクション（Next Action）  来週中に再度連絡し、導入に関する所感・社内判断を確認する  LINE運用のアカウント数ベースでの自動化プラン・概算費用の提示  エンタープライズ向けアプローチでの  AIテレアポ  問い合わせフォームAI の適用モデルの説明を追加  採用自動化のワークフローを具体化し、提案資料として送付  7. 当社視点での勝ち筋（整理）  大量LINEリードの自動化 → 最も効果が出やすい  求人サイト連携＋AIスクリーニング → 工数削減  エンタープライズ向けアポ獲得 → レディクル依存からの脱却  採用自動化×AI伴走 → キャリア塾と親和性◎', NULL, NULL, NULL, '所管確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'cae80d81-f476-4df0-924f-9e298157bcd4', 'ad86d716-0e43-442b-b865-b3e3d0027a26', 3, '2026-01-20', '00000000-0000-0000-0000-000000000001', NULL, 'ラインにて検討状況の確認', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5de8d10b-56e6-44c5-bbf4-3cf9a33adcab', '0c446d2b-8a24-48ab-be97-d4d550e9ec1a', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', 'ネタ', '【提案サービス】 ・AI照射事業としての各種AIツールの代理店（パートナー）提案 ・主軸商材 　- AIテレアポツール（AIが一次架電〜受付突破、責任者接続まで対応） 　　└ 初期費用：約50万円、月額チャージ20〜30万円（約13,000コール／20万円、1コール約15円） 　- AIツール群（約10種、今後毎月追加予定） 　　└ リストAI、フォーム営業AI、名刺フォローAI など 　　└ 三点セット：初期費用50万円＋月額11万円 　　└ 個別利用：リストAI 月額3万円（約1万〜1.2万件抽出）  【導入の可能性】 ・自社利用については関心あり ・パートナー特典として「初期費用0円・月額費用のみ」で自社導入可能な点に理解 ・現時点では即導入判断ではなく、社内検討段階  【代理店の可能性】 ・成果報酬型代理店モデルに理解あり ・在庫リスクなし／契約費用0円／販売方法自由（トスアップ or クロージング）を評価 ・既存顧客への紹介ベースからのスタート想定 ・決算期のため、検討にやや時間を要する見込み  【次回アクション】 ・提案資料を先方へ送付 ・先方にて社内検討（目安：2〜3ヶ月程度） ・検討中の不明点があれば随時連絡いただく流れ  【その他】 ・代理店が営業活動にAIツールを活用することは可能 　└ 無料提供は不可だが、パートナー特典として初期費用免除で導入可 ・将来的にツール追加による既存顧客へのアップセル／クロスセル余地あり', NULL, NULL, NULL, '代理店の検討結果確認', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'aa27a596-5b97-4725-9a6d-2955e8da1d2d', '0c446d2b-8a24-48ab-be97-d4d550e9ec1a', 2, '2026-01-15', '00000000-0000-0000-0000-000000000002', 'ネタ', '【提案サービス】 ・AI照射事業としての各種AIツールの代理店（パートナー）提案 ・主軸商材 　- AIテレアポツール（AIが一次架電〜受付突破、責任者接続まで対応） 　　└ 初期費用：約50万円、月額チャージ20〜30万円（約13,000コール／20万円、1コール約15円） 　- AIツール群（約10種、今後毎月追加予定） 　　└ リストAI、フォーム営業AI、名刺フォローAI など 　　└ 三点セット：初期費用50万円＋月額11万円 　　└ 個別利用：リストAI 月額3万円（約1万〜1.2万件抽出）  【導入の可能性】 ・自社利用については関心あり ・パートナー特典として「初期費用0円・月額費用のみ」で自社導入可能な点に理解 ・現時点では即導入判断ではなく、社内検討段階  【代理店の可能性】 ・成果報酬型代理店モデルに理解あり ・在庫リスクなし／契約費用0円／販売方法自由（トスアップ or クロージング）を評価 ・既存顧客への紹介ベースからのスタート想定 ・決算期のため、検討にやや時間を要する見込み  【次回アクション】 ・提案資料を先方へ送付 ・先方にて社内検討（目安：2〜3ヶ月程度） ・検討中の不明点があれば随時連絡いただく流れ  【その他】 ・代理店が営業活動にAIツールを活用することは可能 　└ 無料提供は不可だが、パートナー特典として初期費用免除で導入可 ・将来的にツール追加による既存顧客へのアップセル／クロスセル余地あり', NULL, NULL, NULL, '代理店の検討結果確認', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2088ca41-2cc6-41aa-8a2d-5c14270ce5bb', 'a9e970ea-d966-4b05-8c71-814515521720', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'C', 'メールにて確認中', NULL, NULL, NULL, '検討状況確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5167edb3-9389-4929-ae78-88a45e353e2e', 'a9e970ea-d966-4b05-8c71-814515521720', 2, '2026-01-16', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜インプレックスアンドカンパニー 久保井様 1. 参加者 / 関係者  初期費用の値引きなし └話を行なっていない まだ本格導入の段階ではない  久保井様（インプレックスアンドカンパニー）  北川様（紹介元）  横山様（キーパーソン・接続すれば案件化濃厚）  矢野様・伊藤様（※元ファンベスト、接続非推奨）  2. 商談の概要  北川様経由で横山様につながるルートが最重要。  **「横山さんに繋がった時点で勝ち」**との評価。  無料で募集できる特定プラットフォームの利用背景をヒアリング。  今後、AI事業部およびツール導入検討部門へ接続可能かを社内調整していただく流れに。  3. 相手のニーズ / 関心領域  AIテレアポ  現在の架電効率と獲得率の改善が主眼。  外注 → 自社内再現性への移行に興味。  採用領域の自動化  無料募集プラットフォームとの相性を考慮しつつ、 応募管理・スクリーニング・自動返信などの効率化に関心あり。  AI事業部連携の可能性  自社顧客（営業代行クライアント）に対して横展開できるか検討中。  一度ツール群をまとめて情報を整理したい意図が強い。  4. 提案内容（本日提示したポイント）  AIテレアポの全体スキーム説明  架電の自動化  シナリオ生成  スコアリング  成果そのものを増やす「受注直結型モデル」  採用自動化ソリューションの説明  応募者対応LINE自動化  候補者管理  日程調整AI  インバウンド応募の歩留まり改善  各ツール資料の提供可能範囲を説明  名刺フォローAI  問い合わせフォームAI  営業リストAI  採用自動化AI  ハチドリエージェント  Lシンク  AIテレアポ  など一式  5. 相手の反応・温度感  情報整理したい意欲が高く、**「資料は全て欲しい」**と明言。  特に、  AIテレアポ  採用自動化AI この２領域は即検討ラインにある。  横山様接続の可否が鍵。  AI事業部への紹介は検討の余地あり、前向き。  6. リスク / 注意点  矢野様・伊藤様（元ファンベスト）は接続非推奨。 → 評判面の懸念。 → 北川様をハブにしたルートで進めるべき。  7. Next Action（次アクション） Gちゃん側（あなた側）  ツール資料一式を送付 → AIテレアポ・採用自動化・問い合わせフォームAI・営業リストAIほか  横山様向けに“決裁者向け1枚サマリー”を別途準備 → 北川様が横山様に渡しやすい資料  導入シミュレーション（ROI想定）作成 → 架電数 × アポ率 × 成約率のモデル  相手側（久保井様 / インプレックスアンドカンパニー）  北川様経由で横山様への接続を調整  AI事業部・ツール導入検討部門への紹介可否を社内検討  資料を社内共有し、一次評価をまとめる  8. 次回設定すべきアジェンダ案  横山様への接続状況の確認  AIテレアポ導入時のKPIモデル共有  採用自動化の導入プロセス説明  代理店／OEMスキームの説明（必要に応じて）', NULL, '契約書以外フルセット', NULL, '検討状況確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7511cee1-6671-4ab2-b893-4e5350f63e46', 'a9e970ea-d966-4b05-8c71-814515521720', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', NULL, 'メールにて確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '66da3224-7a31-4c0b-9c44-3fb4f67d942e', '72577c4c-f884-4231-8d30-935cd730ae39', 1, '2026-01-10', '00000000-0000-0000-0000-000000000001', 'ネタ', '営業会議に出席し、下記を確認する必要あり、 これができれば、さらに入り込むことができるため、 AI顧問または採用AIt人材紹介AIの導入を行う', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '18736f41-b82e-4b2f-8f3e-909155457335', '72577c4c-f884-4231-8d30-935cd730ae39', 2, '2026-01-10', '00000000-0000-0000-0000-000000000001', 'ネタ', '営業会議に出席し、下記を確認する必要あり、 これができれば、さらに入り込むことができるため、 AI顧問または採用AIt人材紹介AIの導入を行う', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9ecb8642-b1f3-4113-bbd5-2f5897a6f6e4', 'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 1, '2026-01-28', '00000000-0000-0000-0000-000000000001', 'A', '契約期間なし 2月がいっぱい　3月からで リスト生成とフォーム 8万円', NULL, NULL, NULL, 'ペンタスケアマネジメント株式会社 鈴木五月様 09065321584 suzu@pentascare.com', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd30b00e0-9c9a-432a-8362-f7db0d447593', 'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 2, '2026-01-11', '00000000-0000-0000-0000-000000000001', 'C', '■ 商談サマリー：ペンタスケアマネジメント株式会社 担当：鈴木五月 様  ■ 事業背景・状況  業種に関わらず「介護離職防止研修」を一般企業へ提供している会社。  特に40〜50代の従業員が介護問題で離職するケースが多いため、企業側の備えとして研修を導入したいニーズが高まっている。  介護保険制度は地域差が大きく、企業担当者が理解しきれない部分を支援している。  神奈川県を中心に昨年より本格的に活動開始。  育児・介護両立支援制度を整えている企業、障害福祉関連事業者を主なターゲットとしている。  ■ 組織・営業課題  ケアマネージャーとして在宅支援を行いつつ、営業は鈴木様が単独で対応している状況。  新規開拓リソースが不足しており、展示会・交流会での人脈頼みの営業に限界を感じている。  製造業・介護業界など、介護離職リスクは大きいが営業開拓手法が十分にない。  ■ ニーズ（顕在化している課題）  新規開拓の効率化 　交流会頼りの営業から脱却し、法人開拓を安定的に増やしたい。  リスト精査・ターゲティングの自動化 　業種・規模により導入可能性が異なるため、高精度なリスト作成が欲しい。  問い合わせ獲得の仕組み化 　フォーム営業を自動化し、見込み顧客との接点を継続的に確保したい。  ■ 提案したソリューション  問い合わせフォーム自動送信AI（フォーム営業AI）  企業の総務・人事部に向けた「介護離職防止研修」の案内を自動送信。  忙しい企業担当者へ“負担なく情報提示できる”チャネルを確保。  営業リスト作成AI（リストAI）  採用状況・従業員構成・地域特性に基づくターゲット抽出。  福祉・製造・中堅企業など、導入角度の高い企業を優先度付けしてリスト化。  ■ 導入条件・金額感  初期費用：0円  月額費用：80,000円 （問い合わせフォームAI＋リスト作成AIのセット）  ■ 合意事項  上記2サービスの導入方向で前向きに合意済み。  現在は社内確認フェーズのため、最終判断は後日連絡。  ■ ネクストアクション  1月26日以降に鈴木様へ連絡し、 　・社内検討状況 　・導入スケジュール 　・スタート月の確定 　を確認する。  ■ 連絡先  鈴木五月 様 Email：suzu@pentascare.com  Tel：090-6532-1584', NULL, NULL, NULL, '回答', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c2f024c3-5ad9-48d6-8834-8b3a5a716259', 'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 3, '2026-01-26', NULL, NULL, '不在着信　ラインも送信中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9a261f06-d169-4a59-b76e-6351038182aa', 'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 4, '2026-01-28', '00000000-0000-0000-0000-000000000001', NULL, '直近1カ月〜2ヶ月がかなり忙しいとのことで、 今月申し込みで初期0円なので、そこを検討して連絡もらう', NULL, NULL, NULL, NULL, '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6339ced9-6233-41b3-8a32-26df19c60b0d', 'a2647c4b-4ae2-428b-9b59-8b1b98a3fd6a', 5, '2026-01-28', '00000000-0000-0000-0000-000000000001', 'A', '契約期間なし 2月がいっぱい　3月からで リスト生成とフォーム 8万円', NULL, NULL, NULL, 'ペンタスケアマネジメント株式会社 鈴木五月様 09065321584 suzu@pentascare.com', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b3e6123e-4191-4c08-8eeb-84a8955f38ef', 'ab7045d8-d837-408a-8bcc-6a3f19582b93', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', 'C', 'ライン確認中', NULL, NULL, NULL, '検討結果確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'acdf1020-ee9b-4278-a8cc-b50faf39f1f7', 'ab7045d8-d837-408a-8bcc-6a3f19582b93', 2, '2026-01-12', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜株式会社VOLIC様  商談相手：株式会社VOLIC テーマ：動画企画伴走サービス × AIリスト活用の検討 目的：ターゲット選定と獲得手法の最適化  1. 事業概要と現状課題  VOLIC様は、動画制作・企画伴走型サービスを主力として展開。 お抱えの放送作家をつけ、月次の企画会議を実施しながら、企業ごとにカスタマイズされたコンテンツを制作するモデル。  現状の主要課題  ターゲット企業の明確化が不十分 →「規模200〜1000人」「信頼性・専門性を売りにする企業」が狙い目だが、セグメントが広く、具体的にどの業種だから最優先なのかが不明確。  YouTubeをやったほうがいいと感じつつも、企業側が何を作ればよいかわからない状態 →VOLICが上流から伴走し、設計を行うことで価値が出る。  テレアポの外注費が高騰しており、資金効率が悪い →従来型のアポ獲得は費用対効果に課題。  提携企業（代理店）からの大量送客に見えるのは避けたい →“質の良い出会い”を重視し、ステルスな接点づくりが必要。  2. VOLIC様の強み（価値提供ポイント）  放送作家が専属でつくため、企画の質が高い  月額で企画を継続伴走できる希少モデル  YouTube・Web制作・ウェビナー企画など幅広く対応可能  企業の“専門性”をストーリー化し、独自の文脈で打ち出せる  属人ではなく“組織としての制作体制”があるため安定供給が可能  3. 今後のターゲット候補  VOLIC様が「一番背負いたい（育てたい）層」として明確化したのは以下：  従業員200〜1000人規模の企業  専門性や信頼性が収益源になっている会社  士業（法律・会計・社労士）  コンサルティングファーム  医療・クリニックグループ  専門メーカー（BtoB）  ITベンダー／SaaS企業  YouTubeを活用したいが内製が不可能または方向性が固まらない企業  ※企画から伴走できるVOLIC様独自の強みが最大限活きる市場。  4. 接点の取り方と懸念事項 懸念点  「大量送客型の代理店経由」に見えるとブランド価値が下がるため避けたい  既存のテレアポ費用が高く、継続が難しい  スポーツチーム案件のように“一方的な広報依頼”になるとVOLIC側がメリットを感じにくい  対策案（こちらで提示）  リストAI（初期費用3万円）を活用し、狙い撃ちの接点を作る  ステルスでの1to1アプローチ／必要な企業だけに個別送付  一気に1000社へ送るのではなく、狙いリストを絞り、質で戦う  →VOLIC様のブランド価値を守りながら、費用対効果の良いリード獲得が可能。  5. 今回の結論と次のステップ ■今回の商談結果  初期費用3万円でリストAIをまず活用したいという方向感で前向き。  テレアポではなく、リストからの精度高いアプローチを優先したい意向。  ■次のアクション  VOLIC様の理想顧客像に合わせたターゲット精査 　（200〜1000人規模 × 専門性 × YouTube未活用）  リストAIで候補を抽出し、サンプルリストを提供  VOLIC様にて企画提案しやすい優先業種を再定義  改めて導入可否の最終確認', NULL, NULL, NULL, '検討結果確認', '2026-01-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f40c88d3-f7de-421c-808a-f50edf7e5435', 'ab7045d8-d837-408a-8bcc-6a3f19582b93', 3, '2026-01-20', NULL, NULL, 'ライン確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'be0cd116-332b-4813-bdf7-36409670060f', 'f868a6ce-15c8-4b36-bc1d-52b0aed9307f', 1, '2026-01-23', '00000000-0000-0000-0000-000000000001', 'C', '母親が亡くなってしまったとのことで、 しばらく連絡を控える形となる', NULL, NULL, NULL, '連絡待ち', '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1934d943-653e-447a-bed5-fce7ae5c7689', 'f868a6ce-15c8-4b36-bc1d-52b0aed9307f', 2, '2026-01-12', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー】株式会社 契（ケイ）様 ■ 議題・リクエスト内容  採用自動化AIの事例送付 　→ 具体的な導入事例の共有を依頼。  AIステップアップ研修の無料動画の有無を確認 　→ 無料で閲覧できる範囲の教材を希望。  従業員評価管理システムへの関心 　→ レベシェア（レベニューシェア）モデルでの販売も視野。  ■ 先方企業概要（ヒアリング情報）  社名：株式会社 契（ケイ）  業態：Web制作・映像制作・PR動画制作 → 大手広告代理店が関与する制作物も対応可能  体制：役員3名体制、社員採用は行わずスリムな組織運営  来期売上目標：5億円  将来展開：達成後は海外展開を視野  企業姿勢：「手の届く範囲の幸せを掴む」堅実かつ着実な成長指向  ■ 現在の課題認識（先方）  大手広告代理店の“右腕”ポジションとして制作を担っているが、 直受け案件を増やすための仕組み構築が必要。  ターゲット：母体が大きい企業（大手クライアント）  既存の営業手法は  リファラル中心  Facebook DMやメールを数十件単位で送る → 効率が悪く、アポイント獲得率にも課題  「会いたい企業へ辿り着ける仕組み」 　＝ リード獲得の自動化を求めている。  ■ SoloptiLinkへの期待・ニーズ  フォーム営業AIやAIリスト生成で、 “会いたい企業へ直接アプローチ”できる導線を作りたい。  評価管理システムは社内運用＋外販（レベシェア）の可能性に期待。  採用自動化AIの事例と活用イメージを確認し、社内導入も検討。  ■ 初期導入・料金に関する意向  初期費用：5万円  月額：11万円で導入したい意向。  “今月内の申し込み”で初期費用5万円を希望。  ■ 次回アクション  21日にGちゃんより連絡し、次回商談日程を調整  27日に再度商談の可能性あり（実質的な詰めフェーズ）  事前準備として以下を送付：  採用自動化AIの導入事例  AIステップアップ研修の無料動画リンク  従業員評価管理システムの概要資料  初期5万円/月額11万円プランの見積りと構成  ■ クロージングポイント（次回商談向け）  **「直受け案件を増やしたい」**という明確なニーズ 　→ フォーム営業AIとAIリストで具体的に実現可能  “人を増やさない組織”方針 　→ 自動化AIとの相性が非常に良い  既にメール・SNSでの手動営業を実施 　→ 今の作業がそのまま「自動化」されるメリットが刺さる  来季5億の達成ロードマップにAI導入が必須として提案', NULL, NULL, NULL, '検討状況確認', '2026-01-21'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'cd7586ac-4ae3-47dd-a629-72f1463a5bdd', 'f868a6ce-15c8-4b36-bc1d-52b0aed9307f', 3, '2026-01-23', '00000000-0000-0000-0000-000000000001', 'C', '母親が亡くなってしまったとのことで、 しばらく連絡を控える形となる', NULL, NULL, NULL, '連絡待ち', '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '80ac09c5-509f-46ad-af41-94ff2c0640a0', '7c93aa3b-e78b-4f48-8a48-b8f1759a9741', 1, '2026-01-15', '00000000-0000-0000-0000-000000000002', '代理店A', '営業代行メインではない 代表が営業顧問として12社ほど入っている 従業員もどちらかというとマネジメント代行みたいな感じでクライアントを抱えている 数社トスアップできそうな企業がいると今期からAI化を進めていきたいと言っている企業など 特にAIツールの研修をしていきたい もしも先方が使うなら初期費用は0円と伝えたが導入の話にはならず 先方が売る場合は初期費用10万までは下げられると伝えた 来週北海道に出張だがオンラインで対応できるとのこと 今のクライアントとの付き合い上、先方の看板で売るのは難しいので紹介ベースになるとのこと', NULL, NULL, NULL, '研修の日程調整', NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8d23c3aa-6d53-4b22-8a93-31b2bf00bd22', '7c93aa3b-e78b-4f48-8a48-b8f1759a9741', 2, '2026-01-15', '00000000-0000-0000-0000-000000000002', '代理店A', '営業代行メインではない 代表が営業顧問として12社ほど入っている 従業員もどちらかというとマネジメント代行みたいな感じでクライアントを抱えている 数社トスアップできそうな企業がいると今期からAI化を進めていきたいと言っている企業など 特にAIツールの研修をしていきたい もしも先方が使うなら初期費用は0円と伝えたが導入の話にはならず 先方が売る場合は初期費用10万までは下げられると伝えた 来週北海道に出張だがオンラインで対応できるとのこと 今のクライアントとの付き合い上、先方の看板で売るのは難しいので紹介ベースになるとのこと', NULL, NULL, NULL, '研修の日程調整', NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '16e7b357-5638-41aa-a23e-39963d56ad2f', 'f2a96302-83d9-4ce2-851c-f102a37f840f', 1, '2026-02-05', '00000000-0000-0000-0000-000000000002', '失注', 'リソース不足　代理店としては動けない', NULL, NULL, '成果報酬受けてない', '代理店やるかどうか', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a4572dd0-beca-4299-b3b9-ea9a87a5d417', 'f2a96302-83d9-4ce2-851c-f102a37f840f', 2, '2026-01-16', '00000000-0000-0000-0000-000000000002', 'C', '担当の本田様のみと商談 代理店とかはやってないが 検討すると', NULL, NULL, NULL, '代理店やるかどうか', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7d1b8a4d-e9e3-4a20-ae32-52c650f7d7a5', 'f2a96302-83d9-4ce2-851c-f102a37f840f', 3, '2026-02-05', '00000000-0000-0000-0000-000000000002', '失注', 'リソース不足　代理店としては動けない', NULL, NULL, '成果報酬受けてない', NULL, '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '399a3fcf-0269-4512-a3f5-9df0183fac67', '01286b99-5c07-46e6-a3c6-5ca7c60a95ef', 1, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬を受けていない 商談代行は月40時間で20万～25万ぐらい マネジメント任せられる', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '01070fb9-0762-4694-ae7e-952cea62e3a4', '01286b99-5c07-46e6-a3c6-5ca7c60a95ef', 2, '2026-01-16', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬を受けていない 商談代行は月40時間で20万～25万ぐらい マネジメント任せられる', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0f16dc8a-c79d-4c98-88a5-cd466552ff39', '27534f75-6491-48ea-8c57-87f489d56a7d', 1, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '固定しかやっていない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd69a4987-e05a-4434-823c-4b031008b7dc', '27534f75-6491-48ea-8c57-87f489d56a7d', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '固定しかやっていない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '676d5508-4ab0-459e-b4ab-7344c716166d', 'fb8e19ac-26ff-4c60-b9d2-dbc28785d11a', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '固定化成果か確認した際に検討中という部分が、 非常に印象が悪いとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '00c80986-2603-4a3b-8444-7dc2d9998203', 'fb8e19ac-26ff-4c60-b9d2-dbc28785d11a', 2, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '固定化成果か確認した際に検討中という部分が、 非常に印象が悪いとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e44c7f58-cc45-49a0-aac2-75ae1662493e', '85b8f582-3eb2-4321-956f-82b49a8d8719', 1, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '新電力やNHKの集金などの訪問しかやってない AIはよくわからないので売れる気がしない', NULL, NULL, 'リテラシーNG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4a2fb93f-24a3-4a74-818f-69a7971876bf', '85b8f582-3eb2-4321-956f-82b49a8d8719', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '新電力やNHKの集金などの訪問しかやってない AIはよくわからないので売れる気がしない', NULL, NULL, 'リテラシーNG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6eb123e2-ff00-4a3c-9ac9-238eb5f1bc29', 'c635f076-4599-40ae-89e1-71f2297bb3ee', 1, '2026-01-29', '00000000-0000-0000-0000-000000000002', '失注', 'この会社が動くのはリソースの都合上成果報酬では厳しい 傘下の会社に声かけてみるとのこと', NULL, NULL, '成果報酬受けてない', '導入、代理店の検討結果確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '65acc3c5-8051-4d0c-8843-8daa7d7054b6', 'c635f076-4599-40ae-89e1-71f2297bb3ee', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', 'C', '導入と代理店の両方を検討 AIテレアポ検討していたが時間かかるしスムーズなやりとりができないので困っていた 録音聞いていいねとなっている。 検討している担当に共有すると 初期費用0円になると伝えた ラインでやり取りする', NULL, NULL, NULL, '導入、代理店の検討結果確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8e3a159f-256c-496d-be78-cadc8a48d837', 'c635f076-4599-40ae-89e1-71f2297bb3ee', 3, '2026-01-29', '00000000-0000-0000-0000-000000000002', '失注', 'この会社が動くのはリソースの都合上成果報酬では厳しい 傘下の会社に声かけてみるとのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '77e5f0df-11a6-4dd9-b502-bd1277e74835', 'eb390cd1-9d32-4981-b445-70776e756601', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', '代理店A', '紹介代理店となる', NULL, NULL, NULL, '状況確認', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'eca77c8d-9c21-45da-bb78-5d37be7becbf', 'eb390cd1-9d32-4981-b445-70776e756601', 2, '2026-01-14', '00000000-0000-0000-0000-000000000001', '代理店A', '商談結論  業務委託契約を締結する方針で合意  今後、AQUA∞より複数案件を紹介してもらうパートナー関係として進行  2. 紹介予定の案件（追加情報）  スポーツエンターテイメント株式会社を紹介予定  背景：  「カスタマーリレーション」から独立して事業運営しているとのこと  テレアポを実施している会社（アウトバウンド型の営業活動が前提）  期待値：  テレアポ業務の効率化・商談創出の改善余地があり、当社商材との親和性が高い可能性  3. 商材導入の温度感（フォーム営業AI／リスト生成AI）  問い合わせフォームAI：導入意向あり（ただし、タイミングは少し先）  リスト生成AI：導入意向あり（同じく少し先）  補足論点：  占い系（占い商材・占い案件）をフォーム営業AI／リスト生成AIで獲得することについては、 「会社の見られ方（レピュテーション）に影響が出る可能性がある」という懸念が提示された  一方で、今後は検討していきたい意向もあり、完全否定ではない  4. 次回予定  1月23日：新橋で会食  目的：関係強化＋紹介案件（スポーツエンターテイメント株式会社含む）の具体条件すり合わせ  併せて、フォーム営業AI／リスト生成AIの導入タイミング・適用領域の整理を進める  5. 次アクション（当社側）  業務委託契約の締結に向け、以下を事前整理  業務範囲（紹介のみ／同席／提案・クロージング支援の範囲）  報酬形態（紹介フィー・成果報酬等）と支払条件  守秘義務／競業避止／紹介案件の取り扱いルール  1/23までに、導入検討を前進させるための確認事項を準備  「占い系」についてのレピュテーション懸念の線引き（対象カテゴリ、表現、運用ルール）', NULL, NULL, NULL, '会食　1社テレアポの会社を紹介もらえる', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '503322de-d769-4e59-a74d-e32742e5dfaa', 'eb390cd1-9d32-4981-b445-70776e756601', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', '代理店A', '紹介代理店となる', NULL, NULL, NULL, '状況確認', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9a1f6aa3-7a4d-40bf-b2fb-055952c47848', '158320b7-b8c5-4049-8431-6a53e3340865', 1, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'A', '下記会社名にて登録 タクセル株式会社', NULL, NULL, NULL, '登録', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fbc9ac62-c0d7-431a-a2ae-de569cac5326', '158320b7-b8c5-4049-8431-6a53e3340865', 2, '2026-01-14', '00000000-0000-0000-0000-000000000001', '代理店A', '採用自動化AIとハチドリエージェントの導入検討 代理店にはなりたいとのことで契約書送付', NULL, NULL, NULL, '契約書の内容確認', '2026-01-15'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5cb031af-c742-4907-845e-8fe76bd1a1a6', '158320b7-b8c5-4049-8431-6a53e3340865', 3, '2026-01-23', '00000000-0000-0000-0000-000000000001', '代理店A', 'ラインにて確認中 興味があるところがあれば、繋いで行くとのことで、代理店契約の方の話になる', NULL, NULL, NULL, NULL, '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '08b3507a-4cea-4259-93ad-e96f04ddb98c', '158320b7-b8c5-4049-8431-6a53e3340865', 4, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'A', '下記会社名にて登録 タクセル株式会社', NULL, NULL, NULL, '登録', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '425bfebd-ee44-4cb9-9c4b-0daa91b42d76', '61394ced-2bcd-4fcd-b32e-9a7f99675c80', 1, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '商談冒頭でリソースが無いので人材派遣しかできないとのことで提案もできず終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c439a857-d597-49c4-9596-3f018e3dd185', '61394ced-2bcd-4fcd-b32e-9a7f99675c80', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', '失注', '商談冒頭でリソースが無いので人材派遣しかできないとのことで提案もできず終話', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3c9fca2a-7be7-4b26-9da7-16aaf16d3266', '156617b4-11af-48b0-a1a8-ea257a5fa7ae', 1, '2026-01-21', '00000000-0000-0000-0000-000000000002', '失注', '検討の結果成果報酬はリソース的にも受けられない', NULL, NULL, '成果報酬受けてない', '代理店検討確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3fa69b04-e5f2-4a8a-8627-f317dc0928e8', '156617b4-11af-48b0-a1a8-ea257a5fa7ae', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', 'C', '固定化アポ単価の成果報酬しかやってないか 一度社内に持ち帰って検討するとのこと', NULL, NULL, NULL, '代理店検討確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f376806e-16cd-4df2-a41d-3b786874c2a6', '156617b4-11af-48b0-a1a8-ea257a5fa7ae', 3, '2026-01-21', '00000000-0000-0000-0000-000000000002', '失注', '検討の結果成果報酬はリソース的にも受けられない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd72ba182-7a7a-4cbc-923c-99c28ee64fb7', '3e804e4d-ca31-4ffb-8119-753195d80d48', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', 'C', '不在', NULL, NULL, NULL, '検討状況確認', '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '58578f71-035e-4fb4-91e8-2a39c4f54f67', '3e804e4d-ca31-4ffb-8119-753195d80d48', 2, '2026-01-19', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜株式会社アースリンク（高田様） 1. 商談概要  目的：インサイドセールス代行（営業代行）領域での協業・導入検討に向け、サービス紹介と論点整理を実施  窓口  電話受付：高田様  メール送付先：高田様宛  当日出席者：滝本様／谷川様  2. 相手の状況・ニーズ  インサイドセールス代行の検討として、 代行でアポイント獲得 → 協業して推進の形を視野に入れている。  クライアント構成：大手 3割／中小 7割  「自社事業に取り込めるか（協業・サービス組込み）」の観点で、詳細の打ち合わせ希望。  3. 提案・議論した内容（AIテレアポ関連）  AIテレアポについて紹介。  CTIについて相手側の前提：  Amazon Connectを利用している想定（確認事項として残し）  確認事項：  「どの回線（キャリア/通話回線）を使っているか」  新規開拓に特化した運用ができるか、の観点で整理  4. 主要論点（ボトルネック）  Salesforce連携ができるかが鍵になりそう  連携可否  連携にかかる費用感（どの程度か） → この論点が導入判断に影響する可能性が高い。  5. 費用感（今回出た話）  導入面の費用イメージ：初期費用 5万円（先方の理解/方向性として言及）  併せて 代理店スキームについても検討意向あり。  6. 次回アクション（ToDo）  27日以降に高田様から連絡予定（＝こちらからもフォロー前提）  次回で確認・詰める事項  Salesforce連携可否／連携方式／費用  CTI（Amazon Connect）×回線の利用状況  協業形態（代行範囲・KPI・役割分担・収益/代理店条件）のすり合わせ  目的：検討状況の確認 → 詳細MTG設定', NULL, NULL, NULL, '検討状況確認', '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a9d4f5d4-a047-4214-a46a-59f8b7cf03fe', '3e804e4d-ca31-4ffb-8119-753195d80d48', 3, '2026-01-30', NULL, NULL, '不在', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e743fec4-994c-4290-9aa5-2a43f4d29a35', 'cb116054-51d0-4304-8810-b958eae85b90', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'C', 'メールにて状況確認中', NULL, NULL, NULL, '検討状況確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7ec7a82d-50c9-42b0-8557-ac7df6a86ca2', 'cb116054-51d0-4304-8810-b958eae85b90', 2, '2026-01-15', '00000000-0000-0000-0000-000000000001', 'C', '株式会社YTK　山川 元芳 様 × 株式会社SoloptiLink　Gちゃん  ■ 商談の概要  YTK様より、**「販売パートナーとしての連携」**に強い関心が示され、 特に AIツールを活かした営業代行・商社向け提案スキーム に興味を持っていただいた。  現在、YTK様は複数の商社と既に取引を持っており、 そのネットワークを活かして 自社ではなく“代行業者の立場”で販売を進めたい という意向。  ■ YTK様のニーズ・興味領域  名刺フォローAI（3万円）  問い合わせフォームAI（5万円）  営業リスト生成AI（3万円）  上記3点を自社導入＋代理店販売の両軸で展開したいとの明確な意思あり。  ■ 具体的な期待値  商社や販売店に対して、AIツールを横展開できるかを検証したい  AIツールの性能面を確認し、商社側に刺さる提案スキームを構築したい  パートナーとしての継続的な商談紹介が可能かどうか確認したい  ■ 本日の合意事項  SoloptiLinkより、ツール詳細資料を共有済  YTK側にて社内検討を進め、導入と代理店化の両方を前提に検討  検討期間は1週間を想定としてご案内  ■ 懸念（要フォロー）  Gちゃん側としては「1週間後に返答」と伝えたが、 山川様からは  「必ず連絡します」 と回答があり、日程が明確に切られていない状態。  放置リスクがあるため、こちらから主導したフォローが必須。  ■ ネクストアクション（こちら主導）  1. 3日後：資料送付フォロー  「資料確認できましたか」ではなく “商社向けの提案テンプレを作ったので共有します” のように、価値提供で接触。  2. 7日後：オンライン打合せの再設定依頼  曖昧なまま待たず、 候補日時を3つ提示してオンライン再商談を打診  代理店条件・開始ステップ・ロールモデル事例を提示する  3. 商社向け営業トーク・導入事例の簡易版を先出し  商社への横展開をイメージさせる「即使える台本」をプレゼント  “自分たちがすぐ売れる”と感じる仕掛けを用意する  ■ 次回商談で詰めるべき論点  代理店マージン（標準：30〜40%）  商社向けの営業導線（名刺→フォーム→リストの3点セット）  YTK様の既存クライアントに対する初回テスト導入の流れ  ツールのデモ体験会の開催日程  月間販売目標のコミットメントライン', '検討結果お待ちしてますみたいな終わり方 日付入れない', '補足営業資料・AIテレアポ提案・ソル資料・商材説明資料・契約書 URL全て', NULL, '検討状況確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c97df255-1e2f-4eb4-be36-0892cdf6f02f', 'cb116054-51d0-4304-8810-b958eae85b90', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', NULL, 'メールにて状況確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8f39b277-473e-4df9-a91f-b1f12e15a1cc', '0343c25d-a8fe-4395-a20b-58d4731de036', 1, '2026-01-21', '00000000-0000-0000-0000-000000000001', '失注', '資料が欲しいとのことで、送付を行うが、 成果報酬の案件は受けられないとのこと 太陽光の案件の話は福岡であれば受けられる可能性があるとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '718a959f-7d89-48c0-84af-aa1950805652', '0343c25d-a8fe-4395-a20b-58d4731de036', 2, '2026-01-21', '00000000-0000-0000-0000-000000000001', '失注', '資料が欲しいとのことで、送付を行うが、 成果報酬の案件は受けられないとのこと 太陽光の案件の話は福岡であれば受けられる可能性があるとのこと', 'なし', 'ソル資料・商材説明資料', NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '558be161-f761-4233-b7e0-682ea8bfffb2', '5d27bba1-5da5-4d1f-90bd-feaaff2812d6', 1, '2026-01-21', '00000000-0000-0000-0000-000000000001', '失注', '戦略設計の案件しか受けないとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a0750731-6865-4476-86d3-17657b16b4a1', '5d27bba1-5da5-4d1f-90bd-feaaff2812d6', 2, '2026-01-21', '00000000-0000-0000-0000-000000000001', '失注', '戦略設計の案件しか受けないとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4cdb86cd-fae4-44b3-bb72-ce2ec6532a34', '1cc728b4-df6c-43f2-adbb-1ae742ff18f3', 1, '2026-02-17', '00000000-0000-0000-0000-000000000002', '失注', '株式会社SoloptiLink 樋上様  平素より大変お世話になっております。 SBモバイルサービス株式会社の原田でございます。  先日はお打ち合わせのお時間を頂戴し、誠にありがとうございました。 また、パートナープログラムにつきましてご丁寧にご説明いただき、心より御礼申し上げます。  社内にて慎重に検討を重ねてまいりましたが、誠に恐縮ながら、現時点では本件につきましては見送らせていただく判断となりました。  大変魅力的なご提案をいただいたにもかかわらず、このようなご連絡となりますことをお詫び申し上げます。 今後、状況が整いました際には、改めてご相談させていただく機会がございましたら幸いです。  貴社のますますのご発展を心よりお祈り申し上げます。 引き続き何卒よろしくお願い申し上げます。', NULL, NULL, '成果報酬受けてない', '検討結果確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a6496dde-931d-47b0-bf87-bc21b560d13f', '1cc728b4-df6c-43f2-adbb-1ae742ff18f3', 2, '2026-01-22', '00000000-0000-0000-0000-000000000002', 'C', 'ソフトバンクの子会社 基本固定しか受けてない 検討の余地はあり リスト1万提供可能と伝えた セキュリティ関係が厳しい 商材研修などの質問対応', NULL, NULL, NULL, '検討結果確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a2d0d87d-d696-44a1-8f23-8c8e50f79cb6', '1cc728b4-df6c-43f2-adbb-1ae742ff18f3', 3, '2026-02-17', '00000000-0000-0000-0000-000000000002', '失注', '株式会社SoloptiLink 樋上様  平素より大変お世話になっております。 SBモバイルサービス株式会社の原田でございます。  先日はお打ち合わせのお時間を頂戴し、誠にありがとうございました。 また、パートナープログラムにつきましてご丁寧にご説明いただき、心より御礼申し上げます。  社内にて慎重に検討を重ねてまいりましたが、誠に恐縮ながら、現時点では本件につきましては見送らせていただく判断となりました。  大変魅力的なご提案をいただいたにもかかわらず、このようなご連絡となりますことをお詫び申し上げます。 今後、状況が整いました際には、改めてご相談させていただく機会がございましたら幸いです。  貴社のますますのご発展を心よりお祈り申し上げます。 引き続き何卒よろしくお願い申し上げます。', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'eeaadd05-b164-4e62-a287-3ec024e96c47', 'fd7de116-551c-49d0-ae71-a587ddc29bf6', 1, '2026-01-26', '00000000-0000-0000-0000-000000000002', 'ネタ', 'チャットワークでやり取り 一度趣味レーションして検討 コールセンターやってるのでそこの余剰人員で稼働することが可能かもと', NULL, NULL, NULL, '代理店検討', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3ff921ee-654c-44c7-9001-031fa07c063c', 'fd7de116-551c-49d0-ae71-a587ddc29bf6', 2, '2026-01-26', '00000000-0000-0000-0000-000000000002', 'ネタ', 'チャットワークでやり取り 一度趣味レーションして検討 コールセンターやってるのでそこの余剰人員で稼働することが可能かもと', NULL, NULL, NULL, '代理店検討', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8fb38356-29c0-4830-a6ed-4b2319fb8095', 'fff83ff8-f1ee-46cf-b8f4-53adbb4b2eeb', 1, '2026-01-23', '00000000-0000-0000-0000-000000000001', '代理店A', 'ラインにて確認中', NULL, NULL, NULL, '際商談', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e5a29278-c26a-4ae5-a114-c344b6fb4f42', 'fff83ff8-f1ee-46cf-b8f4-53adbb4b2eeb', 2, '2026-01-16', '00000000-0000-0000-0000-000000000001', '代理店A', '■ 商談サマリー｜マナリード株式会社  企業概要 マナリード株式会社は、人材派遣・人材紹介を主軸としつつ、MA（マーケティングオートメーション）支援を展開している企業。 これまで 1万社以上との商談実績 を持ち、2〜3万件規模の決裁者情報 を保有するなど、経営層ネットワークに強みを持つ。  ■ 事業内容・強み  スポンサー型プラットフォーム運営  企業スポンサーを募り、情報配信・プロモーションの場を提供  インフルエンサー×企業PRのマッチング  SNS施策と連動し、企業の認知拡大を支援  ラジオ・メディア運営  経営者インタビューや事業PRなど、媒体連動型の企画を展開  地方創生関連事業  地域の中小企業支援、採用強化につながる取り組みを実施  人材派遣・人材紹介  経営者層と直接的な接点を持つため、成約率の高い紹介が可能  ■ 今回の商談ポイント（重要）  当初提示されていた 月額60万円の顧問契約 について、 → 顧問費用ゼロ で契約を進めていただける方向で合意。  マナリード社側が保有するネットワークの中から 年商1億〜50億クラスの中小企業 約40社を紹介可能 と明確な協力意向を表明。  商材の導入余地が広く、 AIツールのMA活用・営業自動化・人材採用支援との相性が非常に高い領域。  ■ 次のアクション（合意済み）  再度30分の打ち合わせを設定  商材ラインナップを整理し、マナリード社の紹介先に最適化したパッケージを提示  どの商材をどの業界に振り分けるかの導線設計も行う  商材研修の実施  商談後すぐでも可とのこと（柔軟に対応可能）  研修内容：  各AIツールの価値訴求ポイント  ターゲット別の営業導線  初回提案トーク、クロージング導線確認  収益モデル（ストック・成果報酬）  紹介開始スケジュールの確定  40社の紹介の優先順位付け  業種別の仮シナリオとヒアリング項目を準備  月ベースでの紹介ペースを設定し、KPI管理に落とし込む  ■ 期待できる効果  中小〜中堅企業の意思決定者レベルと直接接点が持てるため、短期での案件創出が狙える  顧問費用なしのため、当社側のリスクは極小  紹介先の規模感が安定しており、AIツール導入の確度が高い  MA×AIの組み合わせにより、既存のマナリード社サービスとも高い補完関係', NULL, NULL, NULL, '際商談', '2026-01-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8c7ea21a-6d4a-416a-9b62-2313a406f411', 'fff83ff8-f1ee-46cf-b8f4-53adbb4b2eeb', 3, '2026-01-23', '00000000-0000-0000-0000-000000000001', NULL, 'ラインにて確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4c8e6386-c0c1-4c04-b402-4b55c30e949e', 'fca90ea1-3831-46d9-ac86-d9034a2e6fed', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'ネタ', '2月5日に際商談 前向きに進捗 次回現場含めて商談', NULL, NULL, NULL, 'リーさん含めて際商談', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8b2a6687-b86b-4b36-ab28-0342fd676881', 'fca90ea1-3831-46d9-ac86-d9034a2e6fed', 2, '2026-01-16', '00000000-0000-0000-0000-000000000001', 'C', '【商談サマリー】  バリュエンスジャパン　井元 信樹 様 × 小貫（SoloptiLink）  ■ 商談概要  バリュエンスジャパンの主力事業である「貴金属買取・オークション（なんぼや）」およびスポーツ関連プロダクトの販売・スポンサー開拓領域における、営業強化・自動化の可能性について意見交換。 特にダンスチームスポンサー獲得の営業活動や、既存の人事コンサル・採用コンサル事業との相乗効果を軸に議論。  ■ 先方の事業・営業状況整理 1. 貴金属関連  「なんぼや」にて買取し、BtoBオークションで販売  オンライン販売も強化  国内登録企業：約4,000社  海外登録企業：約1,500社  海外は拠点メンバーが飛び込みで開拓  国内はインバウンド流入がメインで、営業活動は最小限  2. スポーツ・エンタメ領域  プロ選手が着用したアイテム、イベント使用小道具の販売  ダンスチーム等のスポンサー獲得を支援  出品者・落札企業の開拓も実施  PR効果・マーケティング効果に課題を抱えるスポンサーが多い  3. 人事・採用コンサル領域（副業メンバー中心）  評価制度設計、研修、OJT構築、採用戦略立案  特にZ世代向けの採用支援ニーズが高い  ダンス × 採用コンテンツ（若年層訴求）に強み  BtoC系企業（例：牛丼チェーンなど）向けSNSマーケティング支援  4. 営業体制  営業5名体制（代表：ジーン氏）  メール自動配信AIツールを既に使用（月額5万円）  メールが無い企業には問い合わせフォームからアプローチ  スポンサー獲得営業は成果が出る一方で工数が大きい  ■ 先方の顕在課題  ダンスチームのスポンサー獲得における工数負荷  営業5名では回し切れない領域がある  問い合わせフォーム対応も手作業寄り  PR・マーケ効果に対するスポンサー側の不満  Jリーグとの比較で「リーチ・指標」が弱いと見られがち  数値化・根拠提示が弱いため、反論資料が不足  採用コンサル領域の業務量増大  Z世代向けの採用プロセスが属人化  新規企業開拓が営業力依存になりがち  海外開拓の効率化  飛び込み中心で再現性・効率に課題  ■ SoloptiLinkからの提案方向性（初期検討） ① AIテレサポ（AIテレアポ）の活用  目的：スポンサー開拓・企業向け営業の自動化／効率化  5名営業体制のアウトバウンド業務を自動化  メール × フォーム同時アタックによる到達率向上  スポンサー候補企業の業界分類・確度判断の自動化  営業リスト拡張（企業情報クロール）との連動も可能  ② 採用自動化AIの提供  目的：Z世代向け採用支援の汎用化・ローコスト化  LINE連携で候補者対応を自動化（一次対応・質疑応答）  企業別に求人票要約・候補者適性の自動分析  採用動画コンテンツの自動生成（ダンサー×採用ブランディングと相性◎）  ③ ハチドリエージェント連携  目的：人事コンサル事業での追加収益導線の構築  人材紹介（20代特化）の成功報酬モデルを提供  バリュエンス側のクライアント企業に「採用代行」として提案可能  動画×SNSマーケ支援の入口にしやすい  ④ ダンスチームスポンサー × AI営業の統合モデル  目的：スポンサー側に対する「効果測定の見える化」  AIでSNS露出・PR効果をレポート化  数値根拠に基づく「スポンサー価値の可視化」  既存スポンサーの満足度向上 → 再契約率UP → 紹介連鎖  ■ 今回の商談で決まった方向性  AIテレサポの検討が最優先テーマ → 営業5名体制の生産効率を最大化する目的  人事コンサル企業に対する追加オプションとして  採用自動化AI  ハチドリエージェント の導入可能性が高い  スポンサー開拓の営業プロセス自動化にも適用可  ■ 次回アクション（双方合意）  バリュエンス側  現在使用中のメール自動配信システムの詳細共有  スポンサー候補リスト（ジャンル別）を提供 └ AIテレサポ導入時の試算に使用  SoloptiLink側（Gちゃん）  AIテレサポの「スポンサー獲得向け専用モデル」デモ作成  採用自動化AI＋ハチドリエージェントの提案資料を準備  導入後のKPI設計案を提示（営業数値化モデル）  ■ まとめ（要点）  バリュエンスは、貴金属・オークションの強固な基盤がある一方で 　「スポンサー獲得」「採用支援」「マーケ効果の数値化」がボトルネック。  SoloptiLinkのAIサービス群は 　営業工数削減・効果可視化・採用自動化の3点で強くフィット。  次回は、AIテレサポ導入の「専用チューニング案」を提示し、試験導入を目指す。', NULL, NULL, NULL, '検討状況確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '97bad33e-4ff3-4043-9505-1b4347adcc5c', 'fca90ea1-3831-46d9-ac86-d9034a2e6fed', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'ネタ', '2月5日に際商談 前向きに進捗 次回現場含めて商談', NULL, NULL, NULL, 'リーさん含めて際商談', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0145534b-78be-4d64-8c29-6de39e52873a', 'a35143fd-368c-425c-9cdd-7528d69de593', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', 'C', '代理店契約送付中　AIテレアポ検討確認', NULL, NULL, NULL, '検討状況確認', '2026-01-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f7dbb8a7-3aa3-42f8-b56d-939e08cc4162', 'a35143fd-368c-425c-9cdd-7528d69de593', 2, '2026-01-16', '00000000-0000-0000-0000-000000000001', 'C', '今月内契約しようと思っている 初期費用10万円まで値引き', NULL, NULL, NULL, '検討状況確認', '2026-01-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '35348ab6-20a2-43fc-91b8-495150688912', 'a35143fd-368c-425c-9cdd-7528d69de593', 3, '2026-01-30', '00000000-0000-0000-0000-000000000001', NULL, '代理店契約送付中　AIテレアポ検討確認', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '159580f8-6d1c-4c04-9387-0fe20efbaf60', '398dbfee-8993-47d3-a89c-36b6d831562d', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'C', 'メッセンジャー返信がない状況　2回目中', NULL, NULL, NULL, '検討状況確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b0ee112c-deb2-4272-80ff-c57e685a0bb4', '398dbfee-8993-47d3-a89c-36b6d831562d', 2, '2026-01-17', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 商談背景  約5年ぶりの再接点  現在、問い合わせフォーム送信サービスに強い関心を持っている状況  相手企業・活動概要  地方団体／スポーツクラブ関連  営業体制  福島・京都に営業メンバー在籍  規模：約5名（うち4名稼働想定）  福島県を中心とした活動  福島市を中心に、業種・業界問わずスポンサー営業を実施  チケット販売、スポンサー獲得を軸とした法人営業  スポンサー・ネットワーク状況  福島ユナイテッドFCのスポンサー  福島県内企業を幅広く対象  東京本社・福島工場を持つ製造業なども含む  代表が福島出身の企業が多い  スポンサー層の特徴  40代〜60代中心  福島愛・人物軸（例：三浦和義氏が好きな層）での共感型スポンサー参画  現在の営業手法・課題  帝国データバンクで法人リストを取得中  福島出身企業を抽出  1リスト数百円で見積取得  今後の方針  リストを活用したテレアポ強化  交流会参加・名刺交換によるリード獲得  課題感  名刺・リスト・問い合わせの管理と活用が分断されている  営業効率を高める仕組みが不足  興味・関心のあるAIサービス  問い合わせフォーム送信AI  営業リスト生成AI  名刺フォローAI  テレアポ活用（将来的に検討）  採用自動化AI  採用エージェント連携  AIステップアップ研修  提案内容（合意イメージ）  初期導入プラン  名刺フォローAI  問い合わせフォームAI  営業リスト生成AI → 3点セット：初期費用 5万円  単体導入の場合  問い合わせフォームAIのみ：初期費用 10万円  将来的導入検討  採用自動化AI  エージェント連携  AIステップアップ研修 上記に関しても導入したい内容とのこと  次アクション  1週間後を目安に再連絡　回答を得る  検討状況の確認  導入範囲・優先順位のすり合わせ  初期導入の意思決定フェーズへ移行', NULL, NULL, NULL, '検討状況確認', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a2e18d8d-09ca-4eca-8b75-dde943f089e4', '398dbfee-8993-47d3-a89c-36b6d831562d', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', NULL, 'メッセンジャー返信がない状況　2回目中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '987208d3-9413-4865-ad4c-fbf23a69b291', '687ffa82-e90d-451a-b259-a275f8b02244', 1, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6dfaf86b-f816-444a-bc01-0d155db0b12f', '687ffa82-e90d-451a-b259-a275f8b02244', 2, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8e619f35-0e1d-438b-8cde-04f44a2f9a63', 'a2a68839-68e6-451a-a834-903ac1e3d734', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', '代理店A', '今月中に返信をもらえる状況とのこと 連絡待ち', NULL, NULL, NULL, '研修するかどうか', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '970a5719-9090-41f2-bffe-4daeb8a3a1ba', 'a2a68839-68e6-451a-a834-903ac1e3d734', 2, '2026-01-21', '00000000-0000-0000-0000-000000000002', '代理店A', 'トスアップをやる テレアポの録音聞いて営業代行会社としてかなりショックを受けていた ただ新しい技術にここ最近で一番おもしろい商談だったと トスアップまでなので商材研修が必要ないと思うが 営業代行の立場としてAI商材を知っておかなければいけないと思うので研修受けるかは後日回答', NULL, NULL, NULL, '研修するかどうか', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bf29514e-901e-44bb-b705-5253726b1850', 'a2a68839-68e6-451a-a834-903ac1e3d734', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', NULL, '今月中に返信をもらえる状況とのこと 連絡待ち', NULL, NULL, NULL, NULL, '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '10be3b47-aa22-4be0-8042-5a1e027c2148', '033730d5-1035-43a5-8e25-cba5c129d34a', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', '固定が基本　リスト作成やAIテレアポは気になるが社内的にそれどころじゃない状況とのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e266f773-9a17-49a0-9ef8-128e0f926c4e', '033730d5-1035-43a5-8e25-cba5c129d34a', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', '固定が基本　リスト作成やAIテレアポは気になるが社内的にそれどころじゃない状況とのこと', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a0e8f3c8-45bf-410d-a70b-da0fbcf60748', 'ca4975b0-464c-4e22-8ab9-8aa92d5d56ab', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', 'リソースが足りないので固定でなければ動けない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ae86e8b1-87b4-45ae-8582-6111e2dfe42f', 'ca4975b0-464c-4e22-8ab9-8aa92d5d56ab', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', '失注', 'リソースが足りないので固定でなければ動けない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '32339728-47f1-49b8-9dd7-0220075bf136', '75ee345f-8fd0-4332-b5e8-d63512a41756', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'ネタ', '成果報酬は厳しい 今月人が辞める状況で社長ともう一人しかいないため リスト今自分で作っているので初期費用がなくなるならかなり前向きに考えたい', NULL, NULL, NULL, 'リストＡＩ検討結果', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3d524f38-5953-4d6d-964e-f8798b66c96f', '75ee345f-8fd0-4332-b5e8-d63512a41756', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'ネタ', '成果報酬は厳しい 今月人が辞める状況で社長ともう一人しかいないため リスト今自分で作っているので初期費用がなくなるならかなり前向きに考えたい', NULL, NULL, NULL, 'リストＡＩ検討結果', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a84aafbb-861d-428a-aaef-574e5468fcdd', '5caa33d1-615d-451c-bbaf-620a88eb4271', 1, '2026-01-26', '00000000-0000-0000-0000-000000000002', '代理店A', '登録しておく 一旦資料を見て研修進めるか検討 質問がかなり多い 代理店として動いたときに他代理店とバッティングしたときどうするのか その際にうちで契約してくれたらキャッシュバックするかなどの提案をしていいのか リスト作成は月7000円でかなり精度高いサービスを契約している 倒産した企業の元顧客を抽出するなどができるとのこと  ラインでやりとり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '19b1f82e-6d9b-4a38-8ea8-293ca0b8b0db', '5caa33d1-615d-451c-bbaf-620a88eb4271', 2, '2026-01-26', '00000000-0000-0000-0000-000000000002', '代理店A', '登録しておく 一旦資料を見て研修進めるか検討 質問がかなり多い 代理店として動いたときに他代理店とバッティングしたときどうするのか その際にうちで契約してくれたらキャッシュバックするかなどの提案をしていいのか リスト作成は月7000円でかなり精度高いサービスを契約している 倒産した企業の元顧客を抽出するなどができるとのこと  ラインでやりとり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2dc01a41-e493-43a9-8eaf-05b0088c7333', 'c9b7b7c0-fa51-45fb-aedd-3677cd487e08', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', 'C', '調整連絡中', NULL, NULL, NULL, '要件定義送付', '2026-01-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2c49a2b1-7102-4f12-8ee8-e85570c3b55d', 'c9b7b7c0-fa51-45fb-aedd-3677cd487e08', 2, '2026-01-19', '00000000-0000-0000-0000-000000000001', 'C', '1. 商談概要  相手先：Fulfill 手島康希さん  目的：共同でのWeb/AIシステム開発〜卸販売モデルの検討、ならびに新規集客（リード獲得）強化に向けた方向性合意  結論：SoloptiLinkが要件定義を作成し、それを起点にFulfillが開発を推進する方針で合意  2. 事業モデル（協業スキーム）  開発進行  SoloptiLinkが要件定義を作る  その内容を元にFulfillが開発を進める  費用負担  折半が基本だが、状況により追加負担も可能（小貫側で上乗せ余地あり）  販売形態  3割：開発会社（Fulfill側）  7割：SoloptiLink（卸販売側）  SoloptiLinkは「卸」の立ち位置で、卸値で仕入れて展開する構想  継続収益（サブスク）  月額3万〜5万円想定  価格は「連携するAPI内容次第」で調整  3. Fulfill側の強み・実績（共有事項）  AI開発が主軸で、品質を担保するために人間の工程を残しつつハイクオリティで提供  大手が踏む手順（通常半年）を、約2週間レベルに短縮できる開発プロセスを持つ  過去開発例（他社向け）  OCR機能付きサービス  **不動産コンシェルジュ（AIが案内・対応）**など  4. 市場ニーズ/狙いどころ（議論の中心）  新規集客を増やしたい  「リードが集まる状態を作りたい」という課題感が一致  紹介で回る会社にしたい  Fulfillは過去、光回線（Softbank/AU/Docomo等）をテレアポ販売していた経験あり  現在はWeb/システム開発や、開発したシステムの卸展開を行っている  卸モデルの具体例  社労士向けに「働き方改革」文脈のシステムを20〜30万円で卸している事例あり  SoloptiLinkでも卸対象になるサービスが作れる可能性  5. 補助金・制度活用の示唆（重要論点）  今年4月以降、AI導入補助金で制度名が変わる可能性に言及  「インボイス」「会計サービス」「通常枠」など、補助金対象になり得るプロダクトを作っている状況  サポート会社（支援側）のフィー感  **20%〜**のイメージ  （話題として）インボイス系は「3/2」、通常枠は「50%」等の比率感に言及  6. プロダクト構想（合意した方向性）  既存のSoloptiLink商材である 問い合わせフォームAI × リスト生成AI × 名刺フォローAI を掛け合わせた統合サービスを開発し、  さらにその上に受発注システムを載せることで  インボイス制度との接続（加盟/対応ができる設計）  SoloptiLinkとして高収益で販売可能なサービスに仕立てる方針  役員＋開発責任者とも会話し、この方向性で合意済み  参考として、PDCA高速化の例（AIOの進め方など）にも言及  トップ営業の成功要因共有 → 改善スピード増 -（例示として）ユニクロ柳井氏のフリース戦略のような「勝ち筋の横展開」  7. 次アクション（ToDo）  小貫：要件定義を作成し、Fulfillへ共有  Fulfill：要件定義を元に開発設計・見積・スケジュール提示  関係者：役員/開発責任者を含め、方向性・販売設計（卸条件/サブスク価格/API範囲）を詰める', NULL, NULL, NULL, '要件定義送付', '2026-01-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40f96557-7716-48d6-8e12-55d57757fa08', 'c9b7b7c0-fa51-45fb-aedd-3677cd487e08', 3, '2026-01-30', '00000000-0000-0000-0000-000000000001', NULL, '調整連絡中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e8710aef-b5b6-4840-a474-42344e0b3857', '0ec47f76-f9af-48a7-9f4c-64e9fa66a63f', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店になるとのこと　フォーム回答まち', NULL, NULL, NULL, '検討状況確認', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '44ea7823-1550-4cd6-ab6d-12166d5a8522', '0ec47f76-f9af-48a7-9f4c-64e9fa66a63f', 2, '2026-01-19', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー：ビジネスタンク 1) 先方の提供スキーム（概要）  テレアポは新卒メンバーが実行  獲得した接点を起点に、社内リソースでクロスセルしていく設計  連携形態としては「紹介／トスアップ」を軸に進行  2) トスアップ運用（導線）  トスアップは主に  LINE  Facebook で対応していく想定  3) 料金・契約条件  月額40万円 × 4ヶ月契約が基本（＝合計160万円）  契約条件については下記2点が混在しているため、最終確認が必要  「4ヶ月契約→返金なし」の基本条件  以前は50万円設定だったが、現在は最大半額返金が可能な形も存在  条件：粗利が600万円に届かなければ、最大半額返金  ※返金条件はプラン改定/例外条件の可能性があるため、最終週の確認時に「適用条件・定義（粗利の算定方法／対象期間／証憑）」まで詰めるのが安全です。  4) 川崎さんについて（紹介者情報）  川崎さん紹介案件  バックグラウンド：野村不動産／証券系（文脈上）  強み：企業同士の“お繋ぎ”が得意（アライアンス・紹介起点の推進力）  5) 今後の取り扱い意向  最終的には、貴社側で**「ノック商材」**として取り扱いを検討したい意向  サービス基本資料は送付済み  6) 次アクション（ToDo）  1月最終週に連絡 → 検討状況の確認 → 回答回収  取り扱い主体は、川崎さんの奥様が代表の 「合同会社RYOMA」 になる可能性が高い  その場合：契約主体／請求先／成果定義／運用責任範囲の整理が必要', NULL, NULL, NULL, '検討状況確認', '2026-01-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8b5428ed-841d-4c5d-b136-dd7a3813eada', '0ec47f76-f9af-48a7-9f4c-64e9fa66a63f', 3, '2026-01-26', NULL, NULL, 'メッセンジャーにて検討は月末までかかるとのこと', NULL, NULL, NULL, NULL, '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7b61cd55-18e3-4ff0-9835-660c3aaeda1f', '0ec47f76-f9af-48a7-9f4c-64e9fa66a63f', 4, '2026-01-30', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店になるとのこと　フォーム回答まち', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '226b2b47-72ef-4d7b-a06c-d17547dec3a9', 'd66f34b0-adce-407e-b933-51f2a0be7ee4', 1, '2026-01-20', '00000000-0000-0000-0000-000000000002', '消滅', '弊社のHP確認し力を貸すのは難しいと判断されお断りメールが届きました。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7b32507c-c0bb-432e-a5e4-eb5418558790', 'd66f34b0-adce-407e-b933-51f2a0be7ee4', 2, '2026-01-20', '00000000-0000-0000-0000-000000000002', '消滅', '弊社のHP確認し力を貸すのは難しいと判断されお断りメールが届きました。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4c97a9b2-3d33-4dee-ba75-d9d59c457d75', 'c53e1742-cf7c-4420-a8d8-49e3501d2bde', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'C', 'コールセンター事業の部長と商談 この人は取り扱いたいが社長に一度確認 徳にAIテレアポに興味を示す 商材研修は土曜であれば調整しやすい  この会社の下に営業代行会社が複数いるので パートナーの紹介も可能 その場合は別途報酬体系の打合せが必要 パートナー紹介したらそのパートナーの導入の場合は初期費用0円も可能と伝えた チャットワークでやり取りをする', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0d20c41b-1315-4440-b503-73a237ad3958', 'c53e1742-cf7c-4420-a8d8-49e3501d2bde', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'C', 'コールセンター事業の部長と商談 この人は取り扱いたいが社長に一度確認 徳にAIテレアポに興味を示す 商材研修は土曜であれば調整しやすい  この会社の下に営業代行会社が複数いるので パートナーの紹介も可能 その場合は別途報酬体系の打合せが必要 パートナー紹介したらそのパートナーの導入の場合は初期費用0円も可能と伝えた チャットワークでやり取りをする', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '324fcff6-55e7-4901-b94e-d49f1da3ac63', '166946c2-f594-4133-b2ce-09f3134d7560', 1, '2026-01-26', '00000000-0000-0000-0000-000000000002', 'C', '取り扱いたいが現状のお付き合いある企業さん以外の完全新規に対して同営業するかがイメージできてない 28日の社内会議で検討 導入の可能性もある　初期費用0円提案  ラインでやりとり', NULL, NULL, NULL, '導入、代理店検討', '2026-02-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c3d05e3a-f987-4a03-9653-122638417b2e', '166946c2-f594-4133-b2ce-09f3134d7560', 2, '2026-01-26', '00000000-0000-0000-0000-000000000002', 'C', '取り扱いたいが現状のお付き合いある企業さん以外の完全新規に対して同営業するかがイメージできてない 28日の社内会議で検討 導入の可能性もある　初期費用0円提案  ラインでやりとり', NULL, NULL, NULL, '導入、代理店検討', '2026-02-03'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd5a14ac3-6e8c-4bef-95f6-447002694954', '91c5fce8-af14-41f1-893a-78176e22973d', 1, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '現状が人とのつながりを起点での紹介しか行なっていないとお客さんに話を行なっているため、 問い合わせフォーム営業などを行なってしまうと、守らないことになってしまう,', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a474fcd2-eca3-45ae-a0e7-9f4136655704', '91c5fce8-af14-41f1-893a-78176e22973d', 2, '2026-01-20', '00000000-0000-0000-0000-000000000001', '失注', '現状が人とのつながりを起点での紹介しか行なっていないとお客さんに話を行なっているため、 問い合わせフォーム営業などを行なってしまうと、守らないことになってしまう,', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '59731c7f-bdc8-449b-b113-07965727f6d9', '8536cdff-d298-46a4-9e4f-c6dd83878b6a', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', '代理店A', '取り扱いたいが、商談提供で報酬が発生して成約になればパーセンテージが上がるといった報酬体系でないとと動きづらい　がっつり動けるかは一度検討するとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e0f44812-5333-439a-9df4-f24381cf05da', '8536cdff-d298-46a4-9e4f-c6dd83878b6a', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', '代理店A', '取り扱いたいが、商談提供で報酬が発生して成約になればパーセンテージが上がるといった報酬体系でないとと動きづらい　がっつり動けるかは一度検討するとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8835f6ca-df61-4de9-b55b-02822f6535e3', 'fd2c5b5d-3e34-425c-8db9-920a2127784b', 1, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ea71cb62-420b-4bdf-8dfb-639bd8470fdb', 'fd2c5b5d-3e34-425c-8db9-920a2127784b', 2, '2026-01-22', '00000000-0000-0000-0000-000000000002', '失注', '固定報酬しか受けてない', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '793fd200-f4c6-461c-8948-debb32fe020b', 'e1eb6322-66b1-437a-aa3f-4945318f01b8', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', 'ネタ', 'プリンター買ったがまだ開けられていないとのことで、', NULL, NULL, NULL, 'プリンター使えているか確認', '2026-03-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '53425c5a-2d45-4065-83dd-7abc1c0ffc44', 'e1eb6322-66b1-437a-aa3f-4945318f01b8', 2, '2026-01-21', '00000000-0000-0000-0000-000000000001', 'ネタ', '名刺フォローはいいと思ったが、 今がプリンターを購入するタイミングで、それが購入できれば、名刺フォローも導入したいとのこと', NULL, NULL, NULL, 'プリンター買ったのか確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ad6b6ae4-cb97-4ac4-b027-07836dc5ae4c', 'e1eb6322-66b1-437a-aa3f-4945318f01b8', 3, '2026-02-09', '00000000-0000-0000-0000-000000000001', NULL, 'プリンター買ったがまだ開けられていないとのことで、', NULL, NULL, NULL, 'プリンター使えているか確認', '2026-03-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'cb33c975-8a10-48cf-b242-fe1db14daca6', '66b97efe-28d2-47b6-9d7f-8e3b9878812f', 1, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'C', '回線の営業代行をやっている　300名ぐらいアポインターを抱えており AIテレアポ導入したいとのこと 役員で入ってる別の会社にも話をしてみるとのこと 1～2週間検討するとのこと 初期費用値下げできる話はしていない', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'db1542b2-5a2d-476a-b4ba-3e9c14b813cd', '66b97efe-28d2-47b6-9d7f-8e3b9878812f', 2, '2026-01-23', '00000000-0000-0000-0000-000000000002', 'C', '回線の営業代行をやっている　300名ぐらいアポインターを抱えており AIテレアポ導入したいとのこと 役員で入ってる別の会社にも話をしてみるとのこと 1～2週間検討するとのこと 初期費用値下げできる話はしていない', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '64f63cc6-9186-4a40-ab32-304d3ebc6ea4', '220385f5-0dce-4cc9-915b-32b90ae261c4', 1, '2026-01-27', '00000000-0000-0000-0000-000000000002', 'ネタ', '代理店の検討 商材研修なども話済み 導入の話にはならず チャットワークでのやりとり', NULL, NULL, NULL, '検討結果確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '37a19d1a-e1dd-415c-a6e5-805044cc64ff', '220385f5-0dce-4cc9-915b-32b90ae261c4', 2, '2026-01-27', '00000000-0000-0000-0000-000000000002', 'ネタ', '代理店の検討 商材研修なども話済み 導入の話にはならず チャットワークでのやりとり', NULL, NULL, NULL, '検討結果確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '130cd588-ff81-484e-a509-a3b822448318', 'ef6b7555-ef89-433c-b159-09ad802876b8', 1, '2026-01-22', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  会社名：株式会社エリシオ ご担当者：松野 公一 様  1. 現状・背景  本業：帽子メーカー  事業形態は BtoB特化  実態としては「服屋だが帽子専門」という立ち位置  課題感：  帽子を取り扱う企業自体が少なく、市場が限定的  自社営業だけではリーチに限界がある  2. これまでの取り組み  営業代行を導入  現在も稼働中  成果・対応面ともに 満足度は高い  一方で、  市場構造上、スケールに課題  帽子以外の軸での展開余地を模索中  3. 関心・検討中のコンテンツ／テーマ  「ジャストスライド」  「ファシロ」の内容  「セールスコア」  複数コンテンツを保有する中で、 どの局面・どの状況で活用できるかを確認したいというスタンス  4. 今後の重点テーマ（3月以降） 建築設計事務所向けサービス  対象：建築設計者・設計事務所  提供価値：  税務的メリットがあるサービス  検討事項：  ターゲットリストの作成  問い合わせフォームAIの導入  名刺AIの導入  資料作成AI：  非常に関心あり  正式リリース後に改めて詳細説明を希望  5. 今後のアクションプラン  2月第1週  改めてこちらから連絡  目的  具体的な商談（再商談）を設定  建築設計向けサービスを軸に、  AI導入範囲  実行スケジュール  役割分担 を具体化する  6. 総評（所感）  営業代行の成功体験があり、外部リソース活用への理解度は高い  「帽子 × BtoB」というニッチ領域での経験を活かしつつ、 建築×税務×AIという新たな成長軸に現実的な関心を示している  次回商談では、  「なぜ今AIなのか」  「どこまで任せられるのか」 を明確に示すことで、意思決定が進む可能性が高い', NULL, NULL, NULL, '資料AI出来次第　回答', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'df9cf63b-2bd5-457c-a974-be2e84ebb58b', 'ef6b7555-ef89-433c-b159-09ad802876b8', 2, '2026-01-22', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  会社名：株式会社エリシオ ご担当者：松野 公一 様  1. 現状・背景  本業：帽子メーカー  事業形態は BtoB特化  実態としては「服屋だが帽子専門」という立ち位置  課題感：  帽子を取り扱う企業自体が少なく、市場が限定的  自社営業だけではリーチに限界がある  2. これまでの取り組み  営業代行を導入  現在も稼働中  成果・対応面ともに 満足度は高い  一方で、  市場構造上、スケールに課題  帽子以外の軸での展開余地を模索中  3. 関心・検討中のコンテンツ／テーマ  「ジャストスライド」  「ファシロ」の内容  「セールスコア」  複数コンテンツを保有する中で、 どの局面・どの状況で活用できるかを確認したいというスタンス  4. 今後の重点テーマ（3月以降） 建築設計事務所向けサービス  対象：建築設計者・設計事務所  提供価値：  税務的メリットがあるサービス  検討事項：  ターゲットリストの作成  問い合わせフォームAIの導入  名刺AIの導入  資料作成AI：  非常に関心あり  正式リリース後に改めて詳細説明を希望  5. 今後のアクションプラン  2月第1週  改めてこちらから連絡  目的  具体的な商談（再商談）を設定  建築設計向けサービスを軸に、  AI導入範囲  実行スケジュール  役割分担 を具体化する  6. 総評（所感）  営業代行の成功体験があり、外部リソース活用への理解度は高い  「帽子 × BtoB」というニッチ領域での経験を活かしつつ、 建築×税務×AIという新たな成長軸に現実的な関心を示している  次回商談では、  「なぜ今AIなのか」  「どこまで任せられるのか」 を明確に示すことで、意思決定が進む可能性が高い', NULL, NULL, NULL, '資料AI出来次第　回答', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5d97e488-9232-4060-90d9-857891d69a21', '9cd20791-276a-402c-bfa5-9bd73822a0f0', 1, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'AIの導入を考えてないので お試しもやらない', NULL, NULL, 'AIはNG', '検討結果確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3d67985f-8518-4bd4-8a38-21ce116fdfe1', '9cd20791-276a-402c-bfa5-9bd73822a0f0', 2, '2026-01-27', '00000000-0000-0000-0000-000000000002', 'ネタ', 'AIテレアポが気になる 1日でもいいのでトライアルをしたい 代理店も可能だがまずは売るために自社で使ってみて売り方のイメージをつかみたい AIテレアポは色々聞いたが、リストがたくさん無いとだめなのと 複雑な商材だと合わないのがネック だが録音を聞いてよさそうとはなっている', NULL, NULL, NULL, '検討結果確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'abdc2014-fdcb-4855-9300-23c4d514e12b', '9cd20791-276a-402c-bfa5-9bd73822a0f0', 3, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'AIの導入を考えてないので お試しもやらない', NULL, NULL, 'AIはNG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd2152a50-2fa2-407f-9605-7d39c75b59a7', 'c05b26b5-22b2-4b97-a0be-435bc4f893c3', 1, '2026-01-22', '00000000-0000-0000-0000-000000000001', 'ネタ', '初期費用10万円 商材一覧の内容と、パートナープログラムの資料を送付する 2月中に検討の回答を行いたいとのことで、 連絡がなければ検討は進んでいないとのことで、 2月後半に状況確認を行う 生成AIリスト、問い合わせフォーム営業の部分を検討していきたいとのこと  改めて連絡くる状況', NULL, NULL, NULL, '検討状況確認', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2d1e3c0b-6c34-4cb1-adb4-1b0bbfd56763', 'c05b26b5-22b2-4b97-a0be-435bc4f893c3', 2, '2026-01-22', '00000000-0000-0000-0000-000000000001', 'ネタ', '初期費用10万円 商材一覧の内容と、パートナープログラムの資料を送付する 2月中に検討の回答を行いたいとのことで、 連絡がなければ検討は進んでいないとのことで、 2月後半に状況確認を行う 生成AIリスト、問い合わせフォーム営業の部分を検討していきたいとのこと  改めて連絡くる状況', NULL, NULL, NULL, '検討状況確認', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ae780eb0-02fb-4244-8bb4-eb9e8cf35e66', '8e843d6f-687d-493e-aada-39012b716603', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', '代理店A', 'ラインにて検討状況確認中', NULL, NULL, NULL, '契約書状況確認', '2026-01-29'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '53c8b354-6393-4b75-a387-8847c37961ff', '8e843d6f-687d-493e-aada-39012b716603', 2, '2026-01-22', '00000000-0000-0000-0000-000000000001', '代理店A', '最終的に全て説明を行い、 代理店契約も送ってくださいとのこと 2社複合機の会社で、テレアポをガツガツやっている会社があるため、 そこを紹介して欲しいとのこと', NULL, NULL, NULL, '契約書状況確認', '2026-01-29'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '01c43283-8859-4aa8-881e-1faebc880682', '8e843d6f-687d-493e-aada-39012b716603', 3, '2026-01-30', '00000000-0000-0000-0000-000000000001', NULL, 'ラインにて検討状況確認中', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '394d5a7f-c11a-4308-ad10-6d9555e6e17b', 'b4979004-7539-431a-bbdb-a23bc9342ccd', 1, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'AIテレアポは導入しないということになった 直近で大量架電するところもない', NULL, NULL, NULL, '検討結果確認', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7f0ec124-5043-4a46-bec6-5c10ac47bc5f', 'b4979004-7539-431a-bbdb-a23bc9342ccd', 2, '2026-01-27', '00000000-0000-0000-0000-000000000002', 'ネタ', '代理店の検討 AIテレアポ気になっていた 人員的に動けるとしたら4月以降になる その辺も含めて2週間の検討時間が欲しい', NULL, NULL, NULL, '検討結果確認', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '989474cc-0adc-4754-9d9a-2449f6693d74', 'b4979004-7539-431a-bbdb-a23bc9342ccd', 3, '2026-02-20', '00000000-0000-0000-0000-000000000002', '失注', 'AIテレアポは導入しないということになった 直近で大量架電するところもない', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f7da2ffc-40db-44ce-8161-3a2cda37e3f2', '57a8b144-edf1-4656-b91f-9828909f5f4d', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店にはなる 一通り説明も行い、大元の情報mの提供済み 改めて2週間後に再度面談し、販売していけそうなのか確認する', NULL, NULL, NULL, '法人設立のメールアドレス確認', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '92a3f941-9901-47ba-816c-b9afd5155d3f', '57a8b144-edf1-4656-b91f-9828909f5f4d', 2, '2026-01-23', '00000000-0000-0000-0000-000000000001', 'C', '川崎さん紹介 契約書関係送付 業務委託契約予定  最終的に、リスト生成とフォーム送信の部分で導入検討 初期費用5万円   内容的には、非常に導入したいという状況となっている', NULL, NULL, NULL, '今日中に代理店などの返答を行う', '2026-01-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0397c103-99ca-47df-b803-0444fd4b16ba', '57a8b144-edf1-4656-b91f-9828909f5f4d', 3, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'ネタ', NULL, NULL, NULL, NULL, '法人設立のメールアドレス確認', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '86533269-8a11-40da-8f80-18fc3f77226a', '57a8b144-edf1-4656-b91f-9828909f5f4d', 4, '2026-02-09', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店にはなる 一通り説明も行い、大元の情報mの提供済み 改めて2週間後に再度面談し、販売していけそうなのか確認する', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ca9bcf93-0bcc-4c90-8176-979b4cb02576', '942f2098-9c1e-4f1e-8beb-bf2e3b735609', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店確定+2月5日に会うため、そこで詳しく今後の進め方を決定', NULL, NULL, NULL, '商材研修', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fb998230-5944-46ff-9835-2b560959b769', '942f2098-9c1e-4f1e-8beb-bf2e3b735609', 2, '2026-01-23', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社sopital 伊藤様） 1. 企業・現状フェーズ  会社名：株式会社sopital  担当者：伊藤様  組織規模：N-1（創業後80名規模まで拡大）  現状戦略フェーズ：  現在はオペレーション構築フェーズを優先  今年度から本格的な事業・営業拡張フェーズへ移行  2. サービス関心領域  関心テーマ：  実用性重視（「使えるなら使いたい」スタンス）  新規リード獲得手段に強い関心  具体ニーズ：  新規リード紹介  アウトバウンド営業支援  将来的には以下を一体で検討：  リスト生成  問い合わせフォーム営業  営業人材採用（営業マン獲得）  3. ターゲット顧客像  企業規模：  中小企業  年商：1億〜10億円レンジ（特に5億〜10億が中心想定）  組織特性：  営業組織が未構築  営業専任1名体制、もしくは営業機能が組織化されていない企業  4. 導入検討スコープ  導入検討領域：  リスト生成支援  問い合わせフォーム営業支援  営業人材採用支援 → 上記3領域を統合型支援モデルとして導入検討を進める方針  5. 条件・費用  初期費用：5万円  6. 次回アクション  商材研修実施  日時：30日 15:00〜16:00  目的：  サービス理解の深化  実運用イメージの具体化  導入可否判断材料の整理  7. 連絡先  電話番号：090-1245-7504  8. 戦略的示唆（補足メモ）  sopital社は「組織拡張フェーズ前夜」に位置  単発支援モデルよりも、  営業基盤構築 × リード創出 × 人材獲得 を一体設計するスケール型営業モデルの方がフィット度が高い  「営業組織が存在しない企業層」特化モデルは差別化要因になり得る', NULL, NULL, NULL, '商材研修', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2e8a3ba4-8c9c-40ef-bd1d-81c78b294cd4', '942f2098-9c1e-4f1e-8beb-bf2e3b735609', 3, '2026-01-30', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店確定+2月5日に会うため、そこで詳しく今後の進め方を決定', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4daac6b1-d605-40ae-a2b3-789767c9affc', 'efd867f2-5870-41de-a07c-fe7b6426cf58', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', '代理店A', '周りにまだ確認ができていないとのこと 改めて、連絡し、周りへの確認状況を確認する', NULL, NULL, NULL, 'どうなったのか確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'db35c1c6-e89d-4577-a1ca-a72d663e7473', 'efd867f2-5870-41de-a07c-fe7b6426cf58', 2, '2026-01-24', '00000000-0000-0000-0000-000000000001', 'C', '# 商談サマリー  ## 対象企業  株式会社レイズ 藤岡様  ---  ## 新規リード獲得手法  * 交流会 * 申請会 * 紹介経由（交流会・人脈ベース）  ### 現状構造  * 新規リードは**交流会・紹介中心**で創出 * 紹介経由の比率が高く、**獲得数にムラが発生**  ---  ## 商談・成約構造  * 月間商談件数：**50〜100件** * ご提案件数：**約10件前後／月** * 想定成約可能数：**月10〜20件規模** * 成約率：ご提案フェーズまでの歩留まり型モデル  ---  ## ターゲット顧客  ### 基本属性  * 固定収入がある人 * 自分で稼いでいる人 * 扶養に入っている層も含む  ➡「収入構造が安定している個人全般」が対象  ---  ## 提供価値・サービス領域  ### 経営コンサルティング  * 財務起点ではなく**経営視点のコンサルティング** * ご紹介ベースでの案件流入  ### 紹介チャネル  * フランチャイズ新規加盟店 * 士業からの紹介 * 社長ネットワーク経由  ---  ## 競争優位性（強み）  * 法人・個人の両面対応が可能 * 銀行出身の経歴    * 格付け・審査・融資構造理解   * 課長職経験 * 銀行員視点で通る資料設計能力    * 審査ロジックに適合するドキュメント作成力  ➡ **金融機関対応力 × 経営コンサル視点のハイブリッド型ポジション**  ---  ## 組織戦略・成長モデル  * 営業人員を雇わずに事業拡大 * 紹介ベースの拡張モデル * 人的スケーラビリティに依存しない成長設計  ---  ## 現状課題  * 紹介ベースのため**リード創出の再現性が低い** * 流入数の変動が激しく、安定成長モデルが未構築  ---  ## 方針・構想  * FP領域    * BtoCイメージが強いため、ブランディング整理が必要 * 公式LINE運用：**行わない方針**  ---  ## 今後の戦略構想  * 初期費用0円モデルの構築 * **名刺フォローAI導入予定** * OEM契約モデル構想    * 仕組み提供型ビジネスモデルへの転換  ---  ## 戦略整理キーワード  * 紹介依存モデル → 仕組み化モデル * 属人営業 → システム営業 * 人脈拡張 → データ駆動型リード創出 * コンサル個業 → プラットフォーム化  ---  ## 総括  現在は**人脈・紹介ドリブン型モデル**で一定の成果を出しているが、 成長の天井は「紹介の再現性」に依存。  今後は、  * AI活用 * OEMモデル * 初期費用ゼロ設計 * 営業レス構造  を軸にした、  **非属人型・仕組み化・スケーラブルモデルへの転換フェーズ**に入る構想段階。', NULL, NULL, NULL, '検討状況確認　周りに聞いてみて反応はどうだったか 反応が良ければ契約に至る', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b1ebb668-975a-4b9c-a8ae-fce1d3139f68', 'efd867f2-5870-41de-a07c-fe7b6426cf58', 3, '2026-02-09', '00000000-0000-0000-0000-000000000001', '代理店A', '周りにまだ確認ができていないとのこと 改めて、連絡し、周りへの確認状況を確認する', NULL, NULL, NULL, 'どうなったのか確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '098d4846-8a59-4962-ae72-f304708238a7', 'a32f35d8-7240-4ffe-8fe3-f3138afbc369', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', '失注', '導入は見送りたいと連絡あり', NULL, NULL, NULL, '検討状況確認', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '138cb03c-c1c5-403c-8f4f-2ebf67a7be6e', 'a32f35d8-7240-4ffe-8fe3-f3138afbc369', 2, '2026-01-24', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー（STARSPARK × 吉成ゆい様） 1. 接点・背景  イベント：STARSPARK主催 オフライン交流会  対象：吉成ゆい様  目的：集客・営業手法構築、事業導入検討  2. 現状の営業活動 ① リスト営業  リスト購入 → テレアポ実施  結果：反応ゼロ（アポ獲得なし）  メール施策：100通配信  成果：実質的反応なし  ② Hot Pepper × Instagram抽出営業  抽出条件：  ホットペッパー掲載  単価高め  Instagram運用あり  成果：  10件アプローチ → アポ獲得  訪問商談実施  課題：  先方予算不足により導入見送り  3. ターゲット定義（現時点）  主要ターゲット属性  Instagram運用中の事業者  高単価業態（Hot Pepper掲載）  集客課題を内在している事業者  →「インスタ運用事業者」が明確なターゲットセグメント  4. フェーズ認識（事業ステージ）  事業開始：10月スタート  現フェーズ：  導入拡大フェーズではない  生活費確保フェーズ（キャッシュフロー安定化段階）  優先順位：  収益確保  事業基盤構築  事業導入・拡張フェーズは未到達  5. 意向整理  導入判断：  現時点では「導入フェーズではない」との認識  スタンス：  事業導入：現段階では見送り  ただし、 👉 「代理店としての参画意向あり」  今後の関係性：  代理店化を前提とした関係構築・検討フェーズへ移行  6. 総合評価（戦略視点）  現状は「導入顧客」ではなく、 「将来代理店候補」ポジション  即時LTV最大化対象ではなく、  将来の販売チャネル拡張要員  リファラル/代理店網構築の種  7. 次アクション設計（推奨） 戦略的対応案  代理店設計モデル提示  初期費用なし型  成果報酬連動型  営業代行モデル  インスタ運用代行連動モデル  フェーズ別関係構築  現在：情報提供フェーズ  中期：代理店化設計フェーズ  将来：導入・事業連携フェーズ  リレーション戦略  月次接点設計  情報共有型関係性構築  将来参画を前提とした育成モデル  8. ステータス定義（CRM用）  案件区分：代理店候補  温度感：中（関係構築フェーズ）  導入確度：低（現時点）  代理店化確度：中〜高（意向あり）  フェーズ：育成・関係構築フェーズ', NULL, NULL, NULL, '検討状況確認', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e8884757-737b-4670-8769-80460b77381c', 'a32f35d8-7240-4ffe-8fe3-f3138afbc369', 3, '2026-02-09', '00000000-0000-0000-0000-000000000001', '失注', '導入は見送りたいと連絡あり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e7820adf-47cd-4370-9cf1-96ef7971e952', '1e0a6ee8-dfda-4839-944e-45bfcc03be2f', 1, '2026-01-28', '00000000-0000-0000-0000-000000000001', '代理店A', '商談議事録｜戦略整理ドキュメント  企業名：東海ビジネスサービス株式会社 担当者：難波 伸敏 様 メール：nobutoshi.namba@tokai-bs.co.jp  商談テーマ：サイバーセキュリティ事業における営業モデル構築／リード獲得戦略 実施日：— 次回商談予定日：2026年1月28日 導入開始想定：2026年2月〜  人物背景  難波様：昨年転職  前職：キヤノン（Canon）  現在ミッション：サイバーセキュリティ領域の事業拡大推進  取扱商材領域  サイバーセキュリティ  UTM  脆弱性診断  その他複数セキュリティ関連商材  事業方針・戦略目的  中小企業向けサイバーセキュリティ導入支援の拡大  中小企業リードの安定的獲得  営業効率の最大化  代理店網構築による事業スケール化  現状組織構造  営業体制：約5名  中小企業向け低価格帯商材設計  人数制約により営業効率が構造的に悪化  現状課題構造 ① リード獲得構造  テレコール施策を検討中  ホットリード約10社のヒアリング実施済  ② 定義・構造的課題  「ホットリード」の定義が曖昧  即商談移行可能リードが少ない  中小企業側のニーズ顕在化が不明確  営業人数制約によりナーチャリング（育成型営業）が不可能  即商談型モデル以外が成立しない組織構造  ③ テレコール施策の構造的問題  テレコール＝育成型リード前提モデル  現体制ではROI不成立  工数過多 × 成約率低下リスク  再現性・スケーラビリティに課題  戦略転換の方向性 検討モデル ① 新規テレコール継続  効率性：低  再現性：低  スケール性：低  ② 代理店営業モデル（主軸戦略候補）  代理店獲得に注力  営業活動を「自社営業」から「構造営業」へ転換  既存顧客基盤を持つ企業との連携モデル構築  既存事業 × サイバーセキュリティのクロスセル構造形成  代理店戦略の目的  商談創出の外部化  営業リソースのレバレッジ化  即商談リードの安定供給  スケーラブルな営業基盤構築  自社営業依存構造からの脱却  直近の意思決定事項 条件面  今週中申込：初期費用10万円プラン適用  今月中申込：条件優遇枠あり  スケジュール  1月28日商談：導入モデル決定の可能性あり  2月：実運用開始フェーズ想定  意思決定論点整理（1月28日商談の本質論点） 表面的論点  どの施策を導入するか  本質的論点  どの営業構造を構築するか  直販モデル vs 代理店連携モデル  営業内製型 vs 営業外部化型  人的リソース依存型 vs 構造レバレッジ型  戦略整理サマリー 現状構造  営業人数制約  育成型リードモデル不適合  低単価商材構造  中小企業市場特性（ニーズ顕在化が遅い）  👉 直接営業モデルは非スケーラブル  最適構造  代理店営業モデル  パートナー連携型構造  商談創出の外部化  営業構造のレバレッジ化  スケーラブル営業基盤構築  次アクション  代理店モデル設計資料の確認  導入モデル比較検討  1月28日商談にて営業構造モデル決定  2月開始に向けた準備フェーズ移行', NULL, NULL, NULL, '検討状況の確認', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '97f07be3-1dfc-4c05-a920-553923e0d24e', '1e0a6ee8-dfda-4839-944e-45bfcc03be2f', 2, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'C', '商談議事録 基本情報  企業名：東海ビジネスサービス株式会社  担当者：難波 伸敏 様  メール：nobutoshi.namba@tokai-bs.co.jp  商談テーマ：サイバーセキュリティ事業における営業モデル構築／リード獲得戦略  実施日：—  次回商談予定日：1月28日  導入開始想定：2026年2月〜  人物背景  難波様：昨年転職  前職：キヤノン（Canon）  サイバーセキュリティ領域での事業拡大を推進中  取扱商材領域  サイバーセキュリティ  UTM  脆弱性診断  その他複数商材ラインナップ  事業方針・目的  中小企業向けサイバーセキュリティ導入支援の拡大  多くの中小企業リードの獲得  営業効率の最大化  代理店網構築による事業スケール  現状の組織構造  営業人数：約5名体制  中小企業向け価格設計は低価格帯  人数に対して営業効率が悪化している構造  現状の課題 ① リード獲得構造  テレコール施策を検討  ホットリード10社程度ヒアリング実施済  ② 課題点  「ホットリード」の定義が曖昧  即商談に移行可能なリードが少ない  中小企業側のニーズが不明確なケースが多い  営業人数が少ないため、  ナーチャリング（育成型営業）が不可能  即商談型モデルでないと回らない構造  ③ テレコール施策の構造的問題  テレコール＝育成型リード前提モデル  現体制ではROIが合わない  工数過多 × 成約率低下リスク  戦略転換の方向性 検討モデル  新規テレコール継続 　→ 効率・再現性に課題あり  代理店営業モデル（主軸戦略） 　→ 代理店獲得に注力 　→ 営業活動を「自社営業」から「構造営業」へ転換 　→ 既存顧客基盤を持つ企業との連携モデル構築  代理店戦略の目的  商談創出の外部化  営業リソースのレバレッジ化  即商談リードの安定供給  サイバーセキュリティ × 既存事業のクロスセル構造形成  スケーラブルな営業基盤構築  直近の意思決定事項 条件面  今週中申込：  初期費用：10万円プラン適用  今月中申込：  条件優遇枠あり  スケジュール  1月28日商談：  導入モデル決定の可能性あり  2月：  実運用開始フェーズ想定  意思決定論点（28日商談の論点整理） 表面的論点  どの施策を導入するか  本質的論点  どの営業構造を構築するか  直販モデルか  代理店連携モデルか  営業内製型か  営業外部化型か  戦略整理まとめ  現状構造：  営業人数制約  育成型リード不可  低単価商材構造  中小企業市場特性（ニーズ顕在化が遅い）  → 直接営業モデルは非スケーラブル  最適構造：  代理店営業モデル  パートナー連携型構造  商談創出の外部化  営業構造のレバレッジ化  次アクション  代理店モデル設計資料の確認  導入モデル比較検討  28日商談にて営業構造モデル決定  2月開始に向けた準備フェーズ移行', NULL, NULL, NULL, '14時際商談', '2026-01-28'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd45b5c93-7233-46a2-8a20-e7f2a32a774e', '1e0a6ee8-dfda-4839-944e-45bfcc03be2f', 3, '2026-01-28', '00000000-0000-0000-0000-000000000001', '代理店A', '商談議事録｜戦略整理ドキュメント  企業名：東海ビジネスサービス株式会社 担当者：難波 伸敏 様 メール：nobutoshi.namba@tokai-bs.co.jp  商談テーマ：サイバーセキュリティ事業における営業モデル構築／リード獲得戦略 実施日：— 次回商談予定日：2026年1月28日 導入開始想定：2026年2月〜  人物背景  難波様：昨年転職  前職：キヤノン（Canon）  現在ミッション：サイバーセキュリティ領域の事業拡大推進  取扱商材領域  サイバーセキュリティ  UTM  脆弱性診断  その他複数セキュリティ関連商材  事業方針・戦略目的  中小企業向けサイバーセキュリティ導入支援の拡大  中小企業リードの安定的獲得  営業効率の最大化  代理店網構築による事業スケール化  現状組織構造  営業体制：約5名  中小企業向け低価格帯商材設計  人数制約により営業効率が構造的に悪化  現状課題構造 ① リード獲得構造  テレコール施策を検討中  ホットリード約10社のヒアリング実施済  ② 定義・構造的課題  「ホットリード」の定義が曖昧  即商談移行可能リードが少ない  中小企業側のニーズ顕在化が不明確  営業人数制約によりナーチャリング（育成型営業）が不可能  即商談型モデル以外が成立しない組織構造  ③ テレコール施策の構造的問題  テレコール＝育成型リード前提モデル  現体制ではROI不成立  工数過多 × 成約率低下リスク  再現性・スケーラビリティに課題  戦略転換の方向性 検討モデル ① 新規テレコール継続  効率性：低  再現性：低  スケール性：低  ② 代理店営業モデル（主軸戦略候補）  代理店獲得に注力  営業活動を「自社営業」から「構造営業」へ転換  既存顧客基盤を持つ企業との連携モデル構築  既存事業 × サイバーセキュリティのクロスセル構造形成  代理店戦略の目的  商談創出の外部化  営業リソースのレバレッジ化  即商談リードの安定供給  スケーラブルな営業基盤構築  自社営業依存構造からの脱却  直近の意思決定事項 条件面  今週中申込：初期費用10万円プラン適用  今月中申込：条件優遇枠あり  スケジュール  1月28日商談：導入モデル決定の可能性あり  2月：実運用開始フェーズ想定  意思決定論点整理（1月28日商談の本質論点） 表面的論点  どの施策を導入するか  本質的論点  どの営業構造を構築するか  直販モデル vs 代理店連携モデル  営業内製型 vs 営業外部化型  人的リソース依存型 vs 構造レバレッジ型  戦略整理サマリー 現状構造  営業人数制約  育成型リードモデル不適合  低単価商材構造  中小企業市場特性（ニーズ顕在化が遅い）  👉 直接営業モデルは非スケーラブル  最適構造  代理店営業モデル  パートナー連携型構造  商談創出の外部化  営業構造のレバレッジ化  スケーラブル営業基盤構築  次アクション  代理店モデル設計資料の確認  導入モデル比較検討  1月28日商談にて営業構造モデル決定  2月開始に向けた準備フェーズ移行', NULL, NULL, NULL, '検討状況の確認', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a6a04320-0c36-483e-9907-dfa8131a41e1', '841d5fef-47a6-45be-8fd7-5107b2c830a4', 1, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'C', '代理店契約はすすめている状況で、 最終的に契約まで対応していくとのこと 改めて商材研修の日程調整 大元の情報も共有済み このまま提案できるのかを確認する', NULL, NULL, NULL, '検討結果回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f0817cbc-10b5-4c58-ac24-57d7e3811c0b', '841d5fef-47a6-45be-8fd7-5107b2c830a4', 2, '2026-01-26', '00000000-0000-0000-0000-000000000002', '代理店A', '代理店やる リストAIも導入したい 他のAIツールも導入するか検討したいので資料送付 トスアップもクロージングも クロージングだけもできる  リストAIだけでも見せて説明 この企業自体フォーム営業もしてる チャットワークでやり取り', NULL, NULL, NULL, '商材研修', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd18e4b9c-9593-4547-9c71-daadde227c23', '841d5fef-47a6-45be-8fd7-5107b2c830a4', 3, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'C', '代理店契約はすすめている状況で、 最終的に契約まで対応していくとのこと 改めて商材研修の日程調整 大元の情報も共有済み このまま提案できるのかを確認する', NULL, NULL, NULL, '検討結果回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8e36299e-527b-416b-bf4a-f2e2f94d9921', '4411209e-83cd-4210-a7b9-3b657b8909e9', 1, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', 'まだ検討が進んでいない状況で、確認して連絡するとのこと', NULL, NULL, NULL, '回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5ac3b9a6-9f83-48e2-a788-ab4c9c1409c4', '4411209e-83cd-4210-a7b9-3b657b8909e9', 2, '2026-01-26', '00000000-0000-0000-0000-000000000001', 'B', '商談サマリー 企業名  情報システムコンサルティング株式会社  商材概要 ① がんの検査キット ② 血のサプリメント  上記2商材を組み合わせた販売モデルで展開  想定販売価格：3,800円（税込想定）  時系列整理 2月3日（節分以降）  初回連絡  「前向きにやる方向」で検討する意向を確認  2月4日  再度連絡  正式回答の取得  提供資料  価格：8万円の資料提供  目的：  事業モデル理解  販売戦略設計  代理店展開設計  先方の意向・方針  最終的に代理店化を希望  今後の展開方針：  水産会社の代理店展開  請求書発行システムの代理店展開  複数商材×複数代理店モデルによるスケール戦略  契約スキーム案 営業支援契約  初期費用：0円  月額費用：8万円  契約内容  営業リスト提供  フォーム営業支援  営業オペレーション構築  代理店開拓導線設計  契約形態  リスト提供＋フォーム営業の業務委託契約  代理店化を前提とした中長期パートナーシップモデル  戦略的評価  本案件は単一商材販売モデルではなく、 「代理店ネットワーク構築 × 商材ポートフォリオ展開」型モデルへの発展性が高い。  単発取引ではなく、  継続課金モデル（月額8万円）  複数商材横展開  代理店構造のレイヤー化  によるストック型収益構造を形成可能。  次アクション  8万円資料の正式提供  営業支援契約条件の文書化  代理店モデル設計書作成  フォーム営業リスト設計  水産会社・請求書システムの代理店戦略設計  ポジショニング整理  本案件は以下モデルに該当：  BtoB×代理店構築型 × サブスクリプション営業支援モデル  単なる営業代行ではなく、 事業構造設計 × 流通設計 × 収益モデル設計を含む戦略案件。', NULL, NULL, NULL, '回答', '2026-02-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '920bd2ad-ef75-4ce0-9ddf-fa30b400d856', '4411209e-83cd-4210-a7b9-3b657b8909e9', 3, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'C', '代理店にはなる フォームAIとリストAIの話を聞き、細かいところで引っかかっていたが、 いいと感じるとのことで、今週末で回答 全ての資料は送っている状況', NULL, NULL, NULL, '回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '58984cd3-e5da-4c63-878b-80ef232af4f7', '4411209e-83cd-4210-a7b9-3b657b8909e9', 4, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', 'まだ検討が進んでいない状況で、確認して連絡するとのこと', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '18fe5bb2-548c-4cdf-9a72-ba2db017f464', '380d5f3f-ac07-48f0-9453-7c036cb53920', 1, '2026-01-26', '00000000-0000-0000-0000-000000000001', '代理店A', '商談議事録 / 事業検討メモ 商談先  会社名：エネセーブ株式会社  担当者：清塚 達士 氏  技術・開発体制  開発形態：オフショア開発  開発スタイル：AI駆動開発  使用技術：Claude Code  要件定義／設計／開発を一気通貫で実施  開発スピード：  1月単月で約6サービス開発実績  開発中・構想中サービス ① AI翻訳サービス  リアルタイム翻訳機能  日本語音声入力 → 翻訳表示  音声内容を解析し、  関連技術情報をリアルタイムで画面表示  ナレッジサポート型UI  ② Sora2（不動産業界向け）  不動産事業者向けAI支援サービス  業務効率化・顧客対応支援を想定  ③ AIライター  AIコンテンツ生成系サービス  マーケティング／営業支援用途想定  現状の事業ステータス（2月中旬時点）  AI受託開発：実績なし  SaaSサービス：未リリース  事業フェーズ：  技術基盤構築完了  プロダクト創出フェーズ  事業モデル確立前段階  協業検討内容 協業モデル案  レベニューシェア型モデルでの合意  初期投資負担を抑制  成果連動型収益分配  長期的事業スケール前提モデル  方針  単発案件型ではなく  **事業共創型モデル（共同事業化）**を志向  今後の進行方針 ① 商材内容の再定義  協業前提のプロダクトテーマ選定  市場性／収益性／スケーラビリティ重視  BtoB SaaS or AI業務支援モデルを軸に検討  ② 会社設立タイミング  3月：新会社設立予定  ③ 次回アクション  3月の会社設立タイミングに合わせて再商談  議題：  商材コンセプト確定  ビジネスモデル設計  収益分配スキーム設計  役割分担整理  戦略的位置づけ（内部整理用）  エネセーブ社：  技術開発力  AI駆動開発基盤  プロダクト量産能力  当方側：  事業設計力  市場戦略設計  マネタイズ設計  営業戦略／アライアンス構築  → 「技術 × 事業設計 × 販路戦略」統合モデル構築が可能  商談評価（戦略観点）  強み：  開発スピード  AIネイティブ開発体制  要件定義〜実装の短距離化  リスク：  実績不足  マーケット検証不足  収益モデル未確立  結論：  単発取引：非推奨  共同事業モデル：高適合  投資型関係構築：有効', NULL, NULL, NULL, '際商談の訴求 3月で', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9726f5ba-b7ee-4ed4-a1aa-886df1a74e8d', '380d5f3f-ac07-48f0-9453-7c036cb53920', 2, '2026-01-26', '00000000-0000-0000-0000-000000000001', '代理店A', '商談議事録 / 事業検討メモ 商談先  会社名：エネセーブ株式会社  担当者：清塚 達士 氏  技術・開発体制  開発形態：オフショア開発  開発スタイル：AI駆動開発  使用技術：Claude Code  要件定義／設計／開発を一気通貫で実施  開発スピード：  1月単月で約6サービス開発実績  開発中・構想中サービス ① AI翻訳サービス  リアルタイム翻訳機能  日本語音声入力 → 翻訳表示  音声内容を解析し、  関連技術情報をリアルタイムで画面表示  ナレッジサポート型UI  ② Sora2（不動産業界向け）  不動産事業者向けAI支援サービス  業務効率化・顧客対応支援を想定  ③ AIライター  AIコンテンツ生成系サービス  マーケティング／営業支援用途想定  現状の事業ステータス（2月中旬時点）  AI受託開発：実績なし  SaaSサービス：未リリース  事業フェーズ：  技術基盤構築完了  プロダクト創出フェーズ  事業モデル確立前段階  協業検討内容 協業モデル案  レベニューシェア型モデルでの合意  初期投資負担を抑制  成果連動型収益分配  長期的事業スケール前提モデル  方針  単発案件型ではなく  **事業共創型モデル（共同事業化）**を志向  今後の進行方針 ① 商材内容の再定義  協業前提のプロダクトテーマ選定  市場性／収益性／スケーラビリティ重視  BtoB SaaS or AI業務支援モデルを軸に検討  ② 会社設立タイミング  3月：新会社設立予定  ③ 次回アクション  3月の会社設立タイミングに合わせて再商談  議題：  商材コンセプト確定  ビジネスモデル設計  収益分配スキーム設計  役割分担整理  戦略的位置づけ（内部整理用）  エネセーブ社：  技術開発力  AI駆動開発基盤  プロダクト量産能力  当方側：  事業設計力  市場戦略設計  マネタイズ設計  営業戦略／アライアンス構築  → 「技術 × 事業設計 × 販路戦略」統合モデル構築が可能  商談評価（戦略観点）  強み：  開発スピード  AIネイティブ開発体制  要件定義〜実装の短距離化  リスク：  実績不足  マーケット検証不足  収益モデル未確立  結論：  単発取引：非推奨  共同事業モデル：高適合  投資型関係構築：有効', NULL, NULL, NULL, '際商談の訴求 3月で', '2026-02-23'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '73f9a6a5-8a76-490a-b5c8-852c272667d2', '673fd53d-bb4b-4949-9e4a-d895d2e6c46f', 1, '2026-01-27', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（AI研修・営業支援連携） 登場人物  小貫 太秀（AI営業支援・AIコール自動化）  1日2,000〜5,000件のコールが可能なAI営業支援を提供  既存利用企業の継続率100％  近藤さん（株式会社AIパートナーズ）  AI研修・営業代行事業を展開  平田さん（紹介者）  商談目的  AI研修事業の拡販  営業支援領域との連携による受注創出モデルの構築  両社の強みを活かした役割分担型スキームの検討  近藤さん側（AIパートナーズ）の状況・課題 事業領域  AI研修  営業代行（アウトバウンド中心）  現状の課題  AI研修単体では受注に直結しづらい  実際の受注は「営業支援案件」に付随して発生するケースが多い  AI研修を本格的にスケールさせるには、20名規模以上の体制構築が必要となる構造的課題  組織・経営テーマ  売上成長  採用強化  営業支援の現行モデル（AIパートナーズ） 手法  テレアポ  インサイドセールス  SNS営業  フォーム営業  特徴  アウトバウンド型営業が強み  現在は**人による架電（人的コール体制）**が中心  業界実績  製造業  広告業界  M&A関連  ※ 基本的に固定型の営業支援契約モデル  提案内容（既存提案） フォーム営業ツール  初期費用：5万円  月額費用：5万円  → すでに提案済み  フォローアップアクション  1週間〜2週間後に検討状況確認のフォロー実施予定  連携ポテンシャル（構造的整理） 小貫側の強み  AIによる超大量コール自動化（2,000〜5,000件/日）  継続率100％のプロダクト品質  人的リソース非依存モデル  近藤側の強み  AI研修ノウハウ  営業代行オペレーション  多業界の営業支援実績  戦略的シナジー案  AIコール基盤 × AI研修 × 営業支援の統合モデル  「営業支援起点 → AI研修導入」という導線設計  AI研修単体販売モデルから営業基盤連動型モデルへの転換', NULL, NULL, NULL, '検討状況確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '04311a09-3bc4-4c86-baf6-149112084714', '673fd53d-bb4b-4949-9e4a-d895d2e6c46f', 2, '2026-01-27', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（AI研修・営業支援連携） 登場人物  小貫 太秀（AI営業支援・AIコール自動化）  1日2,000〜5,000件のコールが可能なAI営業支援を提供  既存利用企業の継続率100％  近藤さん（株式会社AIパートナーズ）  AI研修・営業代行事業を展開  平田さん（紹介者）  商談目的  AI研修事業の拡販  営業支援領域との連携による受注創出モデルの構築  両社の強みを活かした役割分担型スキームの検討  近藤さん側（AIパートナーズ）の状況・課題 事業領域  AI研修  営業代行（アウトバウンド中心）  現状の課題  AI研修単体では受注に直結しづらい  実際の受注は「営業支援案件」に付随して発生するケースが多い  AI研修を本格的にスケールさせるには、20名規模以上の体制構築が必要となる構造的課題  組織・経営テーマ  売上成長  採用強化  営業支援の現行モデル（AIパートナーズ） 手法  テレアポ  インサイドセールス  SNS営業  フォーム営業  特徴  アウトバウンド型営業が強み  現在は**人による架電（人的コール体制）**が中心  業界実績  製造業  広告業界  M&A関連  ※ 基本的に固定型の営業支援契約モデル  提案内容（既存提案） フォーム営業ツール  初期費用：5万円  月額費用：5万円  → すでに提案済み  フォローアップアクション  1週間〜2週間後に検討状況確認のフォロー実施予定  連携ポテンシャル（構造的整理） 小貫側の強み  AIによる超大量コール自動化（2,000〜5,000件/日）  継続率100％のプロダクト品質  人的リソース非依存モデル  近藤側の強み  AI研修ノウハウ  営業代行オペレーション  多業界の営業支援実績  戦略的シナジー案  AIコール基盤 × AI研修 × 営業支援の統合モデル  「営業支援起点 → AI研修導入」という導線設計  AI研修単体販売モデルから営業基盤連動型モデルへの転換', NULL, NULL, NULL, '検討状況確認', '2026-02-05'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9e1a6a56-4b4e-447e-b734-d95224a26a58', 'c4e1c135-5658-4078-bf69-693f3a80eb73', 1, '2026-01-28', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店になりますと 契約書の送付と、紹介スキームの構築', NULL, NULL, NULL, '状況確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5edaa37a-067a-4ebb-81fa-efec5bbece00', 'c4e1c135-5658-4078-bf69-693f3a80eb73', 2, '2026-01-28', '00000000-0000-0000-0000-000000000001', '代理店A', '代理店になりますと 契約書の送付と、紹介スキームの構築', NULL, NULL, NULL, '状況確認', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7b8add67-c597-42f8-a644-5116a86c7f6f', '77e2bbec-2805-4282-b98e-c58355e5a2cd', 1, '2026-01-28', '00000000-0000-0000-0000-000000000001', 'A', '【商談先】 株式会社シュッチョーWifi 古川 智大 様  【関係性】 約15年の付き合い うち約9年間は日本国内でのビジネス関係  【商談テーマ】 ・営業の最新トレンド ・営業仕組み化（オペレーション設計） ・コスト構造（費用対効果・ROI観点） ・出張Wi-Fi事業における営業戦略設計  【営業状況の現状整理】 ・月間アポイント数：限定的 ・顧客セグメントが大抽象レベルで分離されている状態 ・新規営業：日本国内で単発的に実施（1回ベース） ・DM施策：役員層宛への送付が中心 ・テレアポ：リード獲得までに「待機（大気）」が必要な構造  【導入内容】 ・申込フォームAI 　初期費用：50,000円 　月額費用：50,000円  【利用開始日】 ・2026年2月9日 申込 ・2026年2月9日より利用開始  ──────────────────── 【追加申込情報】  ■会社名：ペンタスケアマネジメント株式会社 ■担当者名：鈴木 五月 様 ■電話番号：090-6532-1584 ■メールアドレス：suzu@pentascare.com  ※上記内容にて申込受付済みのため、ご対応をお願いいたします。', NULL, NULL, NULL, '対応', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bb9e14c0-dd15-43bd-82f1-3ce4fcf14015', '77e2bbec-2805-4282-b98e-c58355e5a2cd', 2, '2026-01-28', '00000000-0000-0000-0000-000000000001', 'A', '【商談先】 株式会社シュッチョーWifi 古川 智大 様  【関係性】 約15年の付き合い うち約9年間は日本国内でのビジネス関係  【商談テーマ】 ・営業の最新トレンド ・営業仕組み化（オペレーション設計） ・コスト構造（費用対効果・ROI観点） ・出張Wi-Fi事業における営業戦略設計  【営業状況の現状整理】 ・月間アポイント数：限定的 ・顧客セグメントが大抽象レベルで分離されている状態 ・新規営業：日本国内で単発的に実施（1回ベース） ・DM施策：役員層宛への送付が中心 ・テレアポ：リード獲得までに「待機（大気）」が必要な構造  【導入内容】 ・申込フォームAI 　初期費用：50,000円 　月額費用：50,000円  【利用開始日】 ・2026年2月9日 申込 ・2026年2月9日より利用開始  ──────────────────── 【追加申込情報】  ■会社名：ペンタスケアマネジメント株式会社 ■担当者名：鈴木 五月 様 ■電話番号：090-6532-1584 ■メールアドレス：suzu@pentascare.com  ※上記内容にて申込受付済みのため、ご対応をお願いいたします。', NULL, NULL, NULL, '対応', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'efc7caa5-cc98-4dbf-a2f5-3bd9254c9450', '2d2890a1-5fbd-4b3c-b17c-623f843ac1d6', 1, '2026-02-05', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬は基本やってないが もしも紹介できそうであればトスアップすると', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a701f7bb-da4f-4871-9713-69d59bea7db2', '2d2890a1-5fbd-4b3c-b17c-623f843ac1d6', 2, '2026-02-05', '00000000-0000-0000-0000-000000000002', '失注', '成果報酬は基本やってないが もしも紹介できそうであればトスアップすると', NULL, NULL, '成果報酬受けてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '31dc0524-1998-43bf-93b8-d85edb1abfea', '6f1ab8ed-10c1-4c00-8d4e-86305cbf688d', 1, '2026-02-22', '00000000-0000-0000-0000-000000000001', '代理店A', '研修を行い、都度ラインで紹介を行ってもらえる流れとなる 改めて、AIテレアポの営業代行は非常に良いのではないかと話になっている', NULL, NULL, NULL, '状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '23861ff4-756e-4d78-a7ab-06428a328d69', '6f1ab8ed-10c1-4c00-8d4e-86305cbf688d', 2, '2026-01-29', '00000000-0000-0000-0000-000000000001', '代理店A', '# 商談サマリー 問い合わせフォーム営業はアイドマの20万のツールで行っている  ## 基本情報  * **企業名**：株式会社ワールドクラフト * **担当者**：小宮様 / 山口様 / 窪田様 * **企業属性**：20期のIT・Web系企業 * **規模**：30名以上 * **領域**：建築／ITサポート／新電力関連／Web  ---  ## 商談ステータス  * **代理店A**：申し込み予定 * **フォロー予定**：1〜2週間後に検討状況の確認連絡 * **方向性**：    * OEM提携   * 代理店提携     → 中長期的な戦略パートナー化を視野に入れた協業モデル  ---  ## 現状課題  ### AIテレアポ導入状況  * AIテレアポ：    * **金額面で導入ハードルが高い**   * **架電スクリプト未確定** * 現在の動き：    * アイドマと連携し、スクリプト設計フェーズ  ### 営業・マーケティング体制  * 新電力関連分野：    * テレアポ   * リード獲得営業 * 使用ツール：    * セールスクラウド   * マークワン * マーケティング：    * マーケファン株式会社   * ステップメール運用  ---  ## ニーズ・関心領域  * **コスト削減支援** * **IT担当者のアシスタント業務支援** * **ITサポート業務の外部化・効率化** * **良質商材があればOEM・代理店として取り扱いたい意向**  ---  ## 提携モデル検討イメージ  ### ① OEMモデル  * 自社ブランド化 * ワールドクラフト経由での再販モデル * 代理店網拡張型モデル  ### ② 代理店モデル  * 商材提供型 * ツール提供＋営業支援型  ---  ## テレアポスクリプト設計の論点  現在のテーマ軸：  * 節税 * 社内ITサポート * 業務効率化 * コスト削減  ▶ **スクリプト方針が未確定で揺れている状態**  ---  ## 提供構想  * **ツール提供型モデル** * 月額想定：**約20万円** * 提供価値：    * 業務自動化   * ITサポート効率化   * 営業生産性向上  ---  ## 今後アクション  1. 1〜2週間後のフォローコール 2. OEM/代理店モデルの構造整理資料作成 3. スクリプト設計方針の戦略整理 4. 価格設計（20万円モデル）の価値設計再構築 5. 導入障壁（AIテレアポ・コスト・運用）の構造分解  ---  ## 商談総括  単なる「ツール導入」ではなく、 **"営業構造の再設計パートナー"**としてのポジション取りが最適。  * OEM連携 * 代理店連携 * 営業基盤構築支援 * IT業務支援  を統合した **"事業共創モデル"** が現実解。  > プロダクト売りではなく、構造売りのフェーズに入っている商談。', NULL, NULL, NULL, '代理店の状況確認', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5981625b-0bdf-4fec-8c92-98b94f4feab6', '6f1ab8ed-10c1-4c00-8d4e-86305cbf688d', 3, '2026-02-22', '00000000-0000-0000-0000-000000000001', '代理店A', '研修を行い、都度ラインで紹介を行ってもらえる流れとなる 改めて、AIテレアポの営業代行は非常に良いのではないかと話になっている', NULL, NULL, NULL, '状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7dee59a8-e92b-4ea4-a7ac-1d75ab3c9da6', '4a024c8b-b4d4-4b29-992b-2375abced66f', 1, '2026-01-29', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談内容整理（サマリー） 会議概要  テーマ：AI活用・システム統合戦略検討会議  主題：事業部単位AI導入の分散状態から、グループ横断のAI統合・データ統合・業務自動化への移行設計  参加者：  小貫太秀  teicalo_nishi  光明興業 関係者  対象企業：光明興業グループ（テンポスホールディングス含む上場企業グループ構造）  現状整理（As-Is） 経営・組織構造  執行役レベルではAI投資推進方針は明確  ただし全社横断の推進責任者不在  業務は事業部単位で個別最適化  本社機能による統合推進体制が未構築  システム・データ環境  Google Workspace：約200名規模で利用  各事業部が独自にAI導入  Gemini（有料版）  Claude  GPT系  kintoneでデータベース乱立  決済システム：自社開発  Gmailで業者連携  会議議事録：録音機ベース  採用対応：無人自動応答あり  データ管理：スプレッドシート中心  二重入力なし設計（Meta／LINEステップ／SNS／販促ツール連携）  業務課題構造  点のDX（Point DX）状態  個別最適化は進行  全体最適化は未整理  課題の所在自体が未構造化  情報共有はチャット中心  部長層は横断可視化可能  現場は部門横断しない  事業部間の数値クロス分析ニーズは低い  ただし取引先情報の一元管理ニーズは高い  重要課題テーマ ① AI・データ統合戦略  AIツールが分散導入（Gemini／Claude／GPT）  データ統合の必要性は認識されているが、  「何を統合すべきか」が未定義  統合の目的設計が未整理  ② ナレッジマネジメント  社内に20年分の知見・成功事例・教育ノウハウが分散蓄積  現状：  検索不能  構造化されていない  属人化状態  AIナレッジDB化の必要性が顕在化  ③ シフト管理の構造的問題  福祉施設等におけるシフト設計：  作成に3日かかる  既製システムは適合せず  営業データ・業務データと連動していない  アサインシフト×業務シフトの統合自動化がテーマ化  ④ データ資本経営の概念整理  光明興業の経営思想：  信頼資本（従業員同士）  関係資本（取引先）  文化資本  知識・知恵資本  共感資本 → これらをデータ資本としてAI管理する構想  経営目標・方針  目的：利益率向上 × 業務効率化 × 顧客満足度向上  中期目標：  社員年収 +2,000,000円  確実ライン +600,000円  理念経営ベース  「顧客が喜ぶ」  「社員満足度」  「業務効率性」  討議テーマ システム統合思想  データ統合は「目的ドリブン」で行うべき  無差別統合は非効率  BtoC事業領域はデータ一元化が合理的  BtoB／事業部横断は必要統合領域のみ設計  AI活用方向性  AIは「ツール」ではなく「経営インフラ」  部門AI → 統合AIアーキテクチャへの進化  NotebookLM等のAI活用の検討  Zoom AI要約の活用  次のステップ（アクション整理） 小貫太秀  アサインシフト × 営業データ × 業務データ統合モデル設計  AIシフト自動設計構想の具体化  年収+2,000,000円構想 × AI導入効果を数値化した提案書作成  ナレッジ管理AI（20年分データの検索・構造化システム）構想設計  佐藤氏開発の需要予測・在庫発注AIのシフト管理転用検討  teicalo_nishi  CRM・営業データ・シフトデータ統合の技術調査  システム連携アーキテクチャ設計整理  大阪技術チーム（CTO含む）との事例連携  Zoom AI議事録整理・共有  光明興業  取引先データ・関係資本の一元管理構想検討  各事業部に対し：  年収向上計画  利益率改善計画  AI活用案の提出指示  部門別構想の集約・経営戦略統合  戦略構造整理（本質）  現状構造：  部門最適AI × 部門最適データ × 部門最適業務設計  目指す構造：  経営戦略AI基盤 × 統合データ基盤 × 業務自動設計基盤  商談の戦略的意義  本商談は単なるAI導入検討ではなく、  「AI導入」ではなく 「AI経営構造化」への移行フェーズ  DX → AX（AI Transformation）  部門DX → 経営AIアーキテクチャ  ツール導入 → 経営OS化  業務効率化 → 人的資本価値最大化モデル  への転換点に位置づく戦略会議。', NULL, NULL, NULL, '佐藤さんと打ち合わせ', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7733df58-447e-49c0-aca8-09eec8bc8cf0', '4a024c8b-b4d4-4b29-992b-2375abced66f', 2, '2026-01-29', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談内容整理（サマリー） 会議概要  テーマ：AI活用・システム統合戦略検討会議  主題：事業部単位AI導入の分散状態から、グループ横断のAI統合・データ統合・業務自動化への移行設計  参加者：  小貫太秀  teicalo_nishi  光明興業 関係者  対象企業：光明興業グループ（テンポスホールディングス含む上場企業グループ構造）  現状整理（As-Is） 経営・組織構造  執行役レベルではAI投資推進方針は明確  ただし全社横断の推進責任者不在  業務は事業部単位で個別最適化  本社機能による統合推進体制が未構築  システム・データ環境  Google Workspace：約200名規模で利用  各事業部が独自にAI導入  Gemini（有料版）  Claude  GPT系  kintoneでデータベース乱立  決済システム：自社開発  Gmailで業者連携  会議議事録：録音機ベース  採用対応：無人自動応答あり  データ管理：スプレッドシート中心  二重入力なし設計（Meta／LINEステップ／SNS／販促ツール連携）  業務課題構造  点のDX（Point DX）状態  個別最適化は進行  全体最適化は未整理  課題の所在自体が未構造化  情報共有はチャット中心  部長層は横断可視化可能  現場は部門横断しない  事業部間の数値クロス分析ニーズは低い  ただし取引先情報の一元管理ニーズは高い  重要課題テーマ ① AI・データ統合戦略  AIツールが分散導入（Gemini／Claude／GPT）  データ統合の必要性は認識されているが、  「何を統合すべきか」が未定義  統合の目的設計が未整理  ② ナレッジマネジメント  社内に20年分の知見・成功事例・教育ノウハウが分散蓄積  現状：  検索不能  構造化されていない  属人化状態  AIナレッジDB化の必要性が顕在化  ③ シフト管理の構造的問題  福祉施設等におけるシフト設計：  作成に3日かかる  既製システムは適合せず  営業データ・業務データと連動していない  アサインシフト×業務シフトの統合自動化がテーマ化  ④ データ資本経営の概念整理  光明興業の経営思想：  信頼資本（従業員同士）  関係資本（取引先）  文化資本  知識・知恵資本  共感資本 → これらをデータ資本としてAI管理する構想  経営目標・方針  目的：利益率向上 × 業務効率化 × 顧客満足度向上  中期目標：  社員年収 +2,000,000円  確実ライン +600,000円  理念経営ベース  「顧客が喜ぶ」  「社員満足度」  「業務効率性」  討議テーマ システム統合思想  データ統合は「目的ドリブン」で行うべき  無差別統合は非効率  BtoC事業領域はデータ一元化が合理的  BtoB／事業部横断は必要統合領域のみ設計  AI活用方向性  AIは「ツール」ではなく「経営インフラ」  部門AI → 統合AIアーキテクチャへの進化  NotebookLM等のAI活用の検討  Zoom AI要約の活用  次のステップ（アクション整理） 小貫太秀  アサインシフト × 営業データ × 業務データ統合モデル設計  AIシフト自動設計構想の具体化  年収+2,000,000円構想 × AI導入効果を数値化した提案書作成  ナレッジ管理AI（20年分データの検索・構造化システム）構想設計  佐藤氏開発の需要予測・在庫発注AIのシフト管理転用検討  teicalo_nishi  CRM・営業データ・シフトデータ統合の技術調査  システム連携アーキテクチャ設計整理  大阪技術チーム（CTO含む）との事例連携  Zoom AI議事録整理・共有  光明興業  取引先データ・関係資本の一元管理構想検討  各事業部に対し：  年収向上計画  利益率改善計画  AI活用案の提出指示  部門別構想の集約・経営戦略統合  戦略構造整理（本質）  現状構造：  部門最適AI × 部門最適データ × 部門最適業務設計  目指す構造：  経営戦略AI基盤 × 統合データ基盤 × 業務自動設計基盤  商談の戦略的意義  本商談は単なるAI導入検討ではなく、  「AI導入」ではなく 「AI経営構造化」への移行フェーズ  DX → AX（AI Transformation）  部門DX → 経営AIアーキテクチャ  ツール導入 → 経営OS化  業務効率化 → 人的資本価値最大化モデル  への転換点に位置づく戦略会議。', NULL, NULL, NULL, '佐藤さんと打ち合わせ', '2026-02-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a0472ee5-7714-4f5a-a8d3-a120ba715138', '41d414f6-fa18-43da-8e73-a84040ad0bcd', 1, '2026-01-30', '00000000-0000-0000-0000-000000000001', 'A', '契約を行うとのことで、 代理店契約などの申し込みを進める', NULL, NULL, NULL, '回答', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd6914a4d-6524-4f9e-94e3-8d406cdb0975', '41d414f6-fa18-43da-8e73-a84040ad0bcd', 2, '2026-01-29', '00000000-0000-0000-0000-000000000001', 'A', '商談議事録｜株式会社ステイドリーム × SoloptiLink 1. 契約・導入合意事項 ■ フォーム営業AI導入  初期費用：5万円  月額費用：5万円  利用目的：  フォーム営業によるリード獲得  BPO・人材支援・研修・AI面接商材の導線構築  ステータス：合意済み  ■ 代理店提携  採用ツール（AI面接／AI選考系）の販売代理店化  採用領域商材の販売連携を進行予定  2. 株式会社ステイドリームの事業構造（整理） ① 人材支援・教育事業  20代若手向け転職サポート  企業からの依頼ベース支援  当初は無償支援モデルで運用  若手教育研修・実演型研修  マネジメント層向け研修提供（※難易度高め市場）  人材採用支援事業  採用導線設計  教育 × 採用 × 定着支援の統合モデル志向  ② BPO・DX支援  BPO事業  RPA導入支援  AI活用業務支援  月30時間単位で業務発注可能モデル  ③ AI面接・AI選考システム（POCフェーズ） ■ 機能構造  AI面談  動画面接  テキストチャット型面接  Google Drive連携管理  面接内容の：  自動要約  自動評価  スコアリング  出力フォーマット指定可能  管理画面上で合否スコア表示  ■ 運用構造  日程調整不要（24時間対応）  タイムレックス連携可能  人の予定に依存しない面接設計  再受験可能（やり直しOK）  夜間面接対応  ■ 学習モデル  初期データ蓄積フェーズ  20〜30件の面接データ蓄積でスコア精度向上  点数基準によるフィルタリング設計  AI＋人面接のハイブリッド運用推奨  AI面接推奨率：約80%  3. 導入実績・現状フェーズ  案内開始：11月下旬〜  導入企業数：7〜8社  現状：全社POCフェーズ  契約形態：年間契約モデル前提  開始時期：1月本格運用開始  4. サービス課題・リスク要因 ■ 技術・環境面  通信環境問題（スマホ面接時の電波不良）  離脱リスク（動画停止・通信断）  ■ 心理的障壁  AI面接への抵抗感（特定世代）  応募→面接転換率低下リスク  ■ リテラシー課題  ITリテラシー低層企業での運用難易度  5. ビジネスモデル設計 ■ エンタープライズ向け  初期契約：年間契約  年間費用：60万円（=月5万円）  従量課金：1面接あたり約3,000円  ■ SME向け（検討モデル）  月額1万円プラン  従量課金：1面接あたり約1,000円想定  6. 並走支援モデル  導入初期の並走支援  3ヶ月間の運用伴走型支援  数十万円規模の並走フィー設計  位置づけ  「ツール提供」ではなく「運用設計支援型SaaS」  7. SoloptiLink連携構造（戦略的価値） ■ フォーム営業AI × AI面接の統合導線 フォーム営業AI 　↓ 人材採用リード獲得 　↓ AI面接システム導入提案 　↓ 並走支援モデル 　↓ 年間契約SaaS化  ■ 営業モデル進化  AIテレアポ × フォーム営業 × AI面接  「AI採用オペレーション自動化モデル」構築可能  8. 戦略評価（経営視点） 強み  POC段階で実装済みプロダクト  AI面接 × BPO × RPA × 教育の統合構造  エンタープライズ・SME両対応モデル  年間契約 × 従量課金モデル（LTV設計）  ポテンシャル  HR SaaS化  採用DXプラットフォーム化  AI面接データ基盤ビジネス展開  評価データ資産化  9. 今後の戦略示唆（Gちゃん向け） 実務戦略としての勝ち筋  フォーム営業AIを入口商材化  AI面接をLTV商材化  並走支援を高粗利収益化  代理店モデルで拡張  HRオペレーションSaaS化  これ、正直な話―― **「AI面接 × フォーム営業 × BPO × 並走支援」**の組み合わせは、 “単なるツール販売”じゃなくて、  採用オペレーション自動化モデル（AI Recruiting OS）  として設計すれば、ストック型収益 × データ資産 × プラットフォーム化まで見えます。  営業的にも構造が美しいです：  入口：フォーム営業AI（低単価・導入しやすい）  中核：AI面接SaaS（月額＋従量）  収益：並走支援（高粗利）  拡張：代理店モデル（スケーラブル）  「売れる構造をしている」商談内容です。', NULL, NULL, NULL, '回答', '2026-01-30'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bfc23b28-6339-423e-a483-444afb3cb036', '41d414f6-fa18-43da-8e73-a84040ad0bcd', 3, '2026-01-30', '00000000-0000-0000-0000-000000000001', NULL, '契約を行うとのことで、 代理店契約などの申し込みを進める', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '612e2e33-3e7b-485c-9444-edfd04ac9cc0', 'cca6deda-13f9-4321-8d00-45f4bd4486e3', 1, '2026-02-06', '00000000-0000-0000-0000-000000000002', '失注', '具体的には、サービス申込にあたりクレジットカードの登録が必要であること、 ならびに早期退職に関する返金規定がないことについて、 当社の契約方針・稟議上、前例がなく承認を得ることができませんでした。', NULL, NULL, '使いこなせない', '検討結果確認', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e7fdff0e-2e7b-43d9-9ad0-aaec22b70f15', 'cca6deda-13f9-4321-8d00-45f4bd4486e3', 2, '2026-02-05', '00000000-0000-0000-0000-000000000002', 'C', '社内で検討 東京のSREが優先度が高い　 京都や大阪もエンジニアが欲しい  エージェント使っていて毎月合計100めいぐらいの推薦もらっているが書類が通らないのが課題  社内で検討して回答', NULL, NULL, NULL, '検討結果確認', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b0efadca-d4b2-4263-9f4d-18aeec72296e', 'cca6deda-13f9-4321-8d00-45f4bd4486e3', 3, '2026-02-06', '00000000-0000-0000-0000-000000000002', '失注', '具体的には、サービス申込にあたりクレジットカードの登録が必要であること、 ならびに早期退職に関する返金規定がないことについて、 当社の契約方針・稟議上、前例がなく承認を得ることができませんでした。', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'aa2d9bf5-37d6-49dd-9484-c380bf9757ce', '6a8a0994-5c2e-481c-b26e-91592e1fdbda', 1, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー  商材：ハチドリAI（AGT） 先方：税理士法人 川邑・中 合同会計事務所 ご担当者：岩本様  1. 商談目的  採用活動における現状整理  採用効率改善に向けたAI活用（採用自動化AI／ハチドリAIエージェント）の検討可否確認  2. 採用状況（As-Is）  採用フェーズ：現在も採用活動中  採用区分：中途採用がメイン  採用ターゲット  会計事務所での実務経験者  簿記2級保有者  雇用形態  正社員  パート採用も検討可能  3. 現在の採用手法・課題  人材紹介会社  すでにエージェント契約あり  成果報酬：年収の約30%  求人媒体  複数媒体に掲載  無料媒体中心  応募・成果状況  応募数：月4〜5名程度  CPA（費用対効果）を意識して運用  紹介経由  応募者紹介は「1件単位」で発生  4. 課題認識（To-Beの方向性）  採用活動が  媒体・エージェント依存  工数がかかる割に母集団形成が限定的  採用の「自動化」「効率化」余地があると認識  5. 提案内容（検討中）  導入検討商材  採用自動化AI  ハチドリAIエージェント  期待効果  採用業務の省力化  応募者獲得〜初期対応の自動化  エージェント依存度の低減  6. 費用感・条件  初期費用：5万円  検討期間：2週間  2週間あれば、導入可否の回答が可能とのこと  7. ネクストアクション  対応内容  2週間後に岩本様へ再度連絡  検討結果（導入有無）の確認  想定日程  商談日から約2週間後', NULL, NULL, NULL, '検討結果を確認n', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '923f9191-cb7b-4678-84fb-99e8c24e6b8d', '6a8a0994-5c2e-481c-b26e-91592e1fdbda', 2, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー  商材：ハチドリAI（AGT） 先方：税理士法人 川邑・中 合同会計事務所 ご担当者：岩本様  1. 商談目的  採用活動における現状整理  採用効率改善に向けたAI活用（採用自動化AI／ハチドリAIエージェント）の検討可否確認  2. 採用状況（As-Is）  採用フェーズ：現在も採用活動中  採用区分：中途採用がメイン  採用ターゲット  会計事務所での実務経験者  簿記2級保有者  雇用形態  正社員  パート採用も検討可能  3. 現在の採用手法・課題  人材紹介会社  すでにエージェント契約あり  成果報酬：年収の約30%  求人媒体  複数媒体に掲載  無料媒体中心  応募・成果状況  応募数：月4〜5名程度  CPA（費用対効果）を意識して運用  紹介経由  応募者紹介は「1件単位」で発生  4. 課題認識（To-Beの方向性）  採用活動が  媒体・エージェント依存  工数がかかる割に母集団形成が限定的  採用の「自動化」「効率化」余地があると認識  5. 提案内容（検討中）  導入検討商材  採用自動化AI  ハチドリAIエージェント  期待効果  採用業務の省力化  応募者獲得〜初期対応の自動化  エージェント依存度の低減  6. 費用感・条件  初期費用：5万円  検討期間：2週間  2週間あれば、導入可否の回答が可能とのこと  7. ネクストアクション  対応内容  2週間後に岩本様へ再度連絡  検討結果（導入有無）の確認  想定日程  商談日から約2週間後', NULL, NULL, NULL, '検討結果を確認n', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8b9c4264-48bd-4991-a232-bbef96310fff', '59197a3d-1ad2-4c56-b65c-e19d99fbf94e', 1, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'A', '商談内容サマリー  企業名：東海ニチユ株式会社 ご担当者：鋤柄 嘉幸 様 TEL：052-352-4161  ① 現状の採用・紹介状況  既存でメンテナンス特化の人材エージェントを活用中  紹介自体はあるものの、 **「現状大きく増やしたい状況ではない」**との認識  既存チャネルで一定の充足感あり  ② 今後の導入・検討サービス  ハチドリAIエージェント → 最終的に申込実施予定との意思表示あり  期待値：  適性人材の抽出精度  営業職採用の効率化  マッチ度重視の紹介  ③ 採用ターゲット  職種：営業職（増員方針）  求める人物像  愛知県在住が大前提  地元志向が強い人材  新規開拓ができる行動力  保守的気質の地域性に適応できる人  適性に合った人材のみ紹介希望  ④ 現在の採用チャネル  ■ 新卒  マイナビ  ■ 中途  エンゲージ  プレミアムプラン利用  更新継続中  ■ エージェント  既存契約あり  ■ その他  媒体は今後増加検討余地あり  ⑤ 営業体制・手法  営業エリア：愛知県限定  営業スタイル：訪問営業中心  テレアポ：実施なし  リスト：既に保有・整備済み  ⑥ 関心・ニーズ  名刺フォローの自動化 → 名刺フォローAI／CRM連携系システムにも関心あり  ニーズ背景：  訪問営業比率が高い  接点後フォローの効率化  取りこぼし防止  総合評価（温度感）  ハチドリAIエージェント：導入前向き（申込予定）  採用強化：営業職に限定的ニーズ  エージェント追加：慎重姿勢  AI活用：フォロー領域に関心高', NULL, NULL, NULL, '申し込み確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '91ce7816-fa38-433f-9950-d4f2ae2a33bd', '59197a3d-1ad2-4c56-b65c-e19d99fbf94e', 2, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'A', '商談内容サマリー  企業名：東海ニチユ株式会社 ご担当者：鋤柄 嘉幸 様 TEL：052-352-4161  ① 現状の採用・紹介状況  既存でメンテナンス特化の人材エージェントを活用中  紹介自体はあるものの、 **「現状大きく増やしたい状況ではない」**との認識  既存チャネルで一定の充足感あり  ② 今後の導入・検討サービス  ハチドリAIエージェント → 最終的に申込実施予定との意思表示あり  期待値：  適性人材の抽出精度  営業職採用の効率化  マッチ度重視の紹介  ③ 採用ターゲット  職種：営業職（増員方針）  求める人物像  愛知県在住が大前提  地元志向が強い人材  新規開拓ができる行動力  保守的気質の地域性に適応できる人  適性に合った人材のみ紹介希望  ④ 現在の採用チャネル  ■ 新卒  マイナビ  ■ 中途  エンゲージ  プレミアムプラン利用  更新継続中  ■ エージェント  既存契約あり  ■ その他  媒体は今後増加検討余地あり  ⑤ 営業体制・手法  営業エリア：愛知県限定  営業スタイル：訪問営業中心  テレアポ：実施なし  リスト：既に保有・整備済み  ⑥ 関心・ニーズ  名刺フォローの自動化 → 名刺フォローAI／CRM連携系システムにも関心あり  ニーズ背景：  訪問営業比率が高い  接点後フォローの効率化  取りこぼし防止  総合評価（温度感）  ハチドリAIエージェント：導入前向き（申込予定）  採用強化：営業職に限定的ニーズ  エージェント追加：慎重姿勢  AI活用：フォロー領域に関心高', NULL, NULL, NULL, '申し込み確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2fe44c60-b74d-454e-bfea-0a6b5c158fa3', '63caafbd-68ca-4bf5-9c76-9e9e7048fdf1', 1, '2026-02-03', '00000000-0000-0000-0000-000000000002', '失注', '現状面接対応の人材がいないので導入しても意味がない 新卒は困っていない 中途の関西営業所　営業人材が不足している', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bb019ac0-bf34-4dfe-bdab-c6920d691785', '63caafbd-68ca-4bf5-9c76-9e9e7048fdf1', 2, '2026-02-03', '00000000-0000-0000-0000-000000000002', '失注', '現状面接対応の人材がいないので導入しても意味がない 新卒は困っていない 中途の関西営業所　営業人材が不足している', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd99bdd10-8e11-44cd-a70f-2c259620b7de', '448a5ae0-f175-4de6-8f15-ba23b8121670', 1, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'ネタ', '1契約10万円の、旅費規定管理サービス 営利が300万円以上の節税興味のあるかた ユーチューバー、顧問業のおじさん、COO代行、  会食、外食で10万円　週3〜4回 外泊で5万円  今と同じ生活で7万円でる   上記のAIサービスを取り扱っている状況なので、 採用系を行っているため、サービスの親和性は高いとのことで、 改めて、代理店検討を行うことに 2週間後に連絡しどうするのかかくにん', NULL, NULL, NULL, '検討状況確認', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2e1cc7af-40e5-4438-83d3-51a3115e8a4c', '448a5ae0-f175-4de6-8f15-ba23b8121670', 2, '2026-02-02', '00000000-0000-0000-0000-000000000001', 'ネタ', '1契約10万円の、旅費規定管理サービス 営利が300万円以上の節税興味のあるかた ユーチューバー、顧問業のおじさん、COO代行、  会食、外食で10万円　週3〜4回 外泊で5万円  今と同じ生活で7万円でる   上記のAIサービスを取り扱っている状況なので、 採用系を行っているため、サービスの親和性は高いとのことで、 改めて、代理店検討を行うことに 2週間後に連絡しどうするのかかくにん', NULL, NULL, NULL, '検討状況確認', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6658585a-1f10-466d-8e4e-6ca044f13ef3', '62e88798-4435-43b2-9c64-4d077dfa3ab7', 1, '2026-02-02', '00000000-0000-0000-0000-000000000001', '代理店A', '商談内容サマリー 概要  主催実績：96回  代理店数：約230社  事業特性：  プラットフォーム側で求人開拓に特化  人材紹介・採用支援を主軸とした人材系ビジネス  関係者  小貫広吉  ささいも（関係者）  料金・報酬モデル  面談単価：1面談あたり 3万円  成果報酬率：エンドユーザー売上の 30〜35%  希望：成果報酬中心ではなく、固定報酬型への移行を志向  ターゲット企業  採用活動が活発で、年間10〜20名以上を採用している企業  社内リソースが逼迫しており、採用業務の外注ニーズが高い企業  採用意欲が高い企業におけるマッチ率：約90%  強み・実績  3期目／社員16名体制  今期：15名採用実績  社内転職・リファラル支援に強み  候補者サポートに自信（定着・満足度面）  紹介可能候補者数：月間 1,500〜2,000名  接点企業数：230社へ同時送信・アプローチ可能  組織の意思決定・実行スピードが速い  オペレーション状況  フォーム営業は実施中だが、 開拓後の契約オペレーションに課題が残っている  ただし、半年以内に改善見込みとの認識  今後の方向性  最終的に代理店契約を締結する意向  採用代行・人材支援を行う複数企業の紹介（送客）を予定  中長期的には、  固定報酬モデル  代理店ネットワーク拡張 を軸にスケールを狙う方針', NULL, NULL, NULL, '検討結果回答', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fae2dcc3-e173-42a2-b0ff-6e4ed9f5b26a', '62e88798-4435-43b2-9c64-4d077dfa3ab7', 2, '2026-02-02', '00000000-0000-0000-0000-000000000001', '代理店A', '商談内容サマリー 概要  主催実績：96回  代理店数：約230社  事業特性：  プラットフォーム側で求人開拓に特化  人材紹介・採用支援を主軸とした人材系ビジネス  関係者  小貫広吉  ささいも（関係者）  料金・報酬モデル  面談単価：1面談あたり 3万円  成果報酬率：エンドユーザー売上の 30〜35%  希望：成果報酬中心ではなく、固定報酬型への移行を志向  ターゲット企業  採用活動が活発で、年間10〜20名以上を採用している企業  社内リソースが逼迫しており、採用業務の外注ニーズが高い企業  採用意欲が高い企業におけるマッチ率：約90%  強み・実績  3期目／社員16名体制  今期：15名採用実績  社内転職・リファラル支援に強み  候補者サポートに自信（定着・満足度面）  紹介可能候補者数：月間 1,500〜2,000名  接点企業数：230社へ同時送信・アプローチ可能  組織の意思決定・実行スピードが速い  オペレーション状況  フォーム営業は実施中だが、 開拓後の契約オペレーションに課題が残っている  ただし、半年以内に改善見込みとの認識  今後の方向性  最終的に代理店契約を締結する意向  採用代行・人材支援を行う複数企業の紹介（送客）を予定  中長期的には、  固定報酬モデル  代理店ネットワーク拡張 を軸にスケールを狙う方針', NULL, NULL, NULL, '検討結果回答', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b193c623-d90f-42b1-b2d7-0b905afdff4b', 'f96634b2-b031-4731-b77c-40feb6df8310', 1, '2026-02-03', '00000000-0000-0000-0000-000000000001', '失注', '最終的に名前を確認できれなければ、導入難しいとのことで失注', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c097b827-b358-4178-afb5-b66e802a9bd3', 'f96634b2-b031-4731-b77c-40feb6df8310', 2, '2026-02-03', '00000000-0000-0000-0000-000000000001', '失注', '最終的に名前を確認できれなければ、導入難しいとのことで失注', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'acbd7857-8653-4452-a87f-db0d7bbfd803', '6829d74e-19e5-4b69-923c-d01fc226fa65', 1, '2026-02-10', '00000000-0000-0000-0000-000000000002', '失注', '他社サービスを導入することとなった', NULL, NULL, NULL, 'フォーム営業導入結果', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '08e16fe6-8912-4598-afc3-25c6c44e2604', '6829d74e-19e5-4b69-923c-d01fc226fa65', 2, '2026-02-05', '00000000-0000-0000-0000-000000000002', 'C', 'ニーズバンクの無料登録者数を増やしたい 現状 交流会ベースで1回10～20人ぐらいに営業している →効率悪い  目標は今年で1000件 →アプローチ数を増やす必要がある  フォーム営業を提案 →初期費用ネック　10万に下げたら導入したい  フォーム営業でとサイトのリンクと登録用のリンクを張り付ける運用', NULL, NULL, NULL, 'フォーム営業導入結果', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b9303288-67c5-4b07-9f51-1574cb7b1845', '6829d74e-19e5-4b69-923c-d01fc226fa65', 3, '2026-02-10', '00000000-0000-0000-0000-000000000002', '失注', '他社サービスを導入することとなった', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0b2608d0-a4df-4767-a7ae-e5a464ec48f1', '8ed5d527-ae96-4d06-8d9b-695b507c682e', 1, '2026-02-12', '00000000-0000-0000-0000-000000000002', 'A', 'ハチドリエージェント 1か月お試しでやる', NULL, NULL, NULL, '検討結果確認', '2026-02-10'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'af250677-914f-4207-b0bb-348935a89756', '8ed5d527-ae96-4d06-8d9b-695b507c682e', 2, '2026-02-05', '00000000-0000-0000-0000-000000000002', 'C', '成果報酬だし1か月お試しでやってみるのはあり エージェント使っているが月1.2名とかの推薦  仙台の施工管理や設計が欲しい  推薦された人との面接設定などはやってくれないのかというネック また、3名の保証についても条件マッチしてるだけで応募してるわけではないのはネックとなっていた 次の月、火で回答', NULL, NULL, NULL, '検討結果確認', '2026-02-10'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f9354867-0ca8-4b39-b002-9c8f8cb0b7cb', '8ed5d527-ae96-4d06-8d9b-695b507c682e', 3, '2026-02-12', '00000000-0000-0000-0000-000000000002', 'A', 'ハチドリエージェント 1か月お試しでやる', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '978fa409-13aa-4dfc-a006-379ffda5926e', '659c13be-207e-42a6-bfbd-97e828e3f29d', 1, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'A', 'ハチドリAIエージェントの導入を行うとのこと 商談サマリー  企業名：株式会社トモエシステム 担当者名：村上 博一 様 連絡先：090-6300-4104 商談日時：13:10〜 商談獲得経路：ハチドリAIエージェント経由  1. 導入検討サービス  ハチドリAIエージェント  最終的に導入意向あり（前向き）  採用領域の強化を目的として検討・合意  2. 採用ニーズ整理 新卒採用  理系人材  電気系エンジニア  海外事業展開を見据えた人材  中途採用  SCM（サプライチェーンマネジメント）知見保有者  営業人材  電気工事士資格保有者  採用方針  営業人材は継続的に募集  新卒・中途の両軸で母集団形成  3. 事業・組織背景  建機メーカー関連ビジネス  顧客プロジェクト単位で業務が進行  サプライヤー新規開拓ニーズあり  海外新規エリア開拓を推進中  4. 営業・組織課題 営業面  新規開拓は限定的  既存顧客プロジェクト推進が中心  サプライヤー開拓は必要  マネジメント・育成面  プロジェクト情報共有が不十分  部下育成が体系化されていない  OJT依存（背中を見て育つ文化）  教育・指導の再現性に課題  5. ハチドリAIエージェント導入期待値  想定される導入目的：  理系・技術人材の母集団形成  海外展開を見据えた人材確保  営業組織の人員拡充  SCM人材のピンポイント採用  採用プロセス効率化  6. 今後の営業展開示唆（内部向け）  アップセル／クロスセル余地あり  採用自動化AI  営業育成AI  ナレッジ共有システム  KPIマネジメント  プロジェクト管理AI  特に以下テーマは刺さりやすい：  「背中を見て育つ」からの脱却  技術×営業のハイブリッド育成  海外展開人材の早期確保  サプライヤー開拓支援  7. 次回アクション  導入フロー整理  求人要件詳細ヒアリング  ターゲットペルソナ設計  配信媒体／スカウト戦略設計  海外人材可否確認', NULL, NULL, NULL, '導入確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '59e49b42-931b-4d78-af28-c667f1e42573', '659c13be-207e-42a6-bfbd-97e828e3f29d', 2, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'A', 'ハチドリAIエージェントの導入を行うとのこと 商談サマリー  企業名：株式会社トモエシステム 担当者名：村上 博一 様 連絡先：090-6300-4104 商談日時：13:10〜 商談獲得経路：ハチドリAIエージェント経由  1. 導入検討サービス  ハチドリAIエージェント  最終的に導入意向あり（前向き）  採用領域の強化を目的として検討・合意  2. 採用ニーズ整理 新卒採用  理系人材  電気系エンジニア  海外事業展開を見据えた人材  中途採用  SCM（サプライチェーンマネジメント）知見保有者  営業人材  電気工事士資格保有者  採用方針  営業人材は継続的に募集  新卒・中途の両軸で母集団形成  3. 事業・組織背景  建機メーカー関連ビジネス  顧客プロジェクト単位で業務が進行  サプライヤー新規開拓ニーズあり  海外新規エリア開拓を推進中  4. 営業・組織課題 営業面  新規開拓は限定的  既存顧客プロジェクト推進が中心  サプライヤー開拓は必要  マネジメント・育成面  プロジェクト情報共有が不十分  部下育成が体系化されていない  OJT依存（背中を見て育つ文化）  教育・指導の再現性に課題  5. ハチドリAIエージェント導入期待値  想定される導入目的：  理系・技術人材の母集団形成  海外展開を見据えた人材確保  営業組織の人員拡充  SCM人材のピンポイント採用  採用プロセス効率化  6. 今後の営業展開示唆（内部向け）  アップセル／クロスセル余地あり  採用自動化AI  営業育成AI  ナレッジ共有システム  KPIマネジメント  プロジェクト管理AI  特に以下テーマは刺さりやすい：  「背中を見て育つ」からの脱却  技術×営業のハイブリッド育成  海外展開人材の早期確保  サプライヤー開拓支援  7. 次回アクション  導入フロー整理  求人要件詳細ヒアリング  ターゲットペルソナ設計  配信媒体／スカウト戦略設計  海外人材可否確認', 'ハチドリAIエージェントの資料とURLのみ送付', NULL, NULL, '導入確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7bc8a196-9e5a-4c61-b060-2f25b1428f4f', '451d8873-21cb-454d-9ee6-2fe015008e03', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'B', 'インバウンド案件 BtoBで利用を行っていきたいとのことで、 改めて際商談の依頼が来た 20日14:30商談 電話をかけて欲しいのと、', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'bd595752-597b-4363-84bf-37ded0898332', '451d8873-21cb-454d-9ee6-2fe015008e03', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'B', 'インバウンド案件 BtoBで利用を行っていきたいとのことで、 改めて際商談の依頼が来た 20日14:30商談 電話をかけて欲しいのと、', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c30a3f9e-c2f6-481f-a0f6-2c7c1ab84bbb', 'bae70fcc-0076-496f-adb0-141517815cef', 1, '2026-02-06', '00000000-0000-0000-0000-000000000002', 'A', 'システムエンジニアが欲しい ハチドリエージェント導入する クレジット払い可能かは怪しいとのこと', NULL, NULL, NULL, '申込書回収', '2026-02-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fd42da28-4c89-4202-bd91-e8193ce484f5', 'bae70fcc-0076-496f-adb0-141517815cef', 2, '2026-02-06', '00000000-0000-0000-0000-000000000002', 'A', 'システムエンジニアが欲しい ハチドリエージェント導入する クレジット払い可能かは怪しいとのこと', NULL, NULL, NULL, '申込書回収', '2026-02-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '63901f9f-8897-402a-9c91-c2de8033b22e', '14f3b01e-a962-4b1b-89f9-eff8d44e8fb4', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレパオのサービスはグループ会社で、歯科医院ターゲットに営業を行っている企業があるため、 そこで利用可否を検討している状況 再度商談を行った結果、反応としてはどっちつかずの状況で終わり、 少しリスクのある点に懸念を感じている状況 改めて、翌週の会議にて、利用を行うのか否かを会議にかけて、決定する状況となる 来週に連絡し検討状況を確認する 初期費用は50万円の正の提示のため、この値引きの話が来る可能性があるため、こちらから伝える', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8c014ce3-636e-40f9-b3a7-d3a69948d9e6', '14f3b01e-a962-4b1b-89f9-eff8d44e8fb4', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレパオのサービスはグループ会社で、歯科医院ターゲットに営業を行っている企業があるため、 そこで利用可否を検討している状況 再度商談を行った結果、反応としてはどっちつかずの状況で終わり、 少しリスクのある点に懸念を感じている状況 改めて、翌週の会議にて、利用を行うのか否かを会議にかけて、決定する状況となる 来週に連絡し検討状況を確認する 初期費用は50万円の正の提示のため、この値引きの話が来る可能性があるため、こちらから伝える', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'e4496821-6eca-4e2d-9cc0-9271265cede2', '91abddbc-a61d-410e-8033-ecd3c810bd73', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー 初期10万円まで値引き 企業名：エシカルライフ株式会社 ご担当者：縄野 政彰 様 回答期限：11日（来週中に検討結果回答予定）  ① 事業・思想背景（先方理解）  事業領域：  ヘルスケア／メディカル／ウェルネス領域  「人の健康」「社会全体の健全性」を重視  思想・理念：  日本伝統文化の価値観（相手を許す・調和）をベース  CSR / CSVを重視した事業思想  主力プロダクト思想：  「痩せてボケないゼリー」  若返り・健康維持をコンセプト  想定ユーザー層：  子育て世代  小学生・幼児を持つ家庭  高齢者・予防医療層  ② 現在の販売・流通状況  販売チャネル：  ライブコマース（ママ層インフルエンサー）  既に「売る側のママさんコミュニティ」が存在  特徴的な流通モデル：  ママさんによるライブ販売が流入経路として機能  共感型・ストーリー型の販売が強い  組織内活用アイデア：  社員向け配布 → 福利厚生としての活用可能性あり  大手企業への福利厚生提案余地  ③ 想定BtoB・社会実装領域  福利厚生用途：  大手企業の社員向け健康支援  公共・準公共領域：  自衛隊（健康維持・予防医療文脈）  CSR / CSV文脈：  健康×社会貢献の文脈での導入余地  ④ 先方のニーズ・関心点  販売代理店ニーズ：  積極的に「販売代理店として動けるパートナー」を探している  営業・採用・DX領域への関心：  営業支援  採用支援  Lシンク含む仕組み化ツール  今回の対応内容：  営業／採用／Lシンク関連の情報を全て送付予定  ⑤ 当社からの次アクション  送付対応（即時）  営業支援資料  採用支援資料  Lシンク概要資料 → 一括送信  来週アクション  11日以降、検討結果のヒアリング  以下いずれかの方向性を明確化  代理店提携  福利厚生向けBtoBモデル構築  Lシンク導入（自社 or 代理店活用）  ⑥ 戦略的所感（社内向けメモ）  相性が良いポイント  ママ層×共感×ライブコマース＝LTVが高い  福利厚生・CSR文脈での法人提案に展開可能  次の一手  「代理店＋福利厚生BtoB」の二軸設計が有望  ママ販売員×企業福利厚生のハイブリッドモデル構築余地あり', NULL, NULL, NULL, '回答', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2ee421ff-503e-426d-98b4-5cb5490ef9e8', '91abddbc-a61d-410e-8033-ecd3c810bd73', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー 初期10万円まで値引き 企業名：エシカルライフ株式会社 ご担当者：縄野 政彰 様 回答期限：11日（来週中に検討結果回答予定）  ① 事業・思想背景（先方理解）  事業領域：  ヘルスケア／メディカル／ウェルネス領域  「人の健康」「社会全体の健全性」を重視  思想・理念：  日本伝統文化の価値観（相手を許す・調和）をベース  CSR / CSVを重視した事業思想  主力プロダクト思想：  「痩せてボケないゼリー」  若返り・健康維持をコンセプト  想定ユーザー層：  子育て世代  小学生・幼児を持つ家庭  高齢者・予防医療層  ② 現在の販売・流通状況  販売チャネル：  ライブコマース（ママ層インフルエンサー）  既に「売る側のママさんコミュニティ」が存在  特徴的な流通モデル：  ママさんによるライブ販売が流入経路として機能  共感型・ストーリー型の販売が強い  組織内活用アイデア：  社員向け配布 → 福利厚生としての活用可能性あり  大手企業への福利厚生提案余地  ③ 想定BtoB・社会実装領域  福利厚生用途：  大手企業の社員向け健康支援  公共・準公共領域：  自衛隊（健康維持・予防医療文脈）  CSR / CSV文脈：  健康×社会貢献の文脈での導入余地  ④ 先方のニーズ・関心点  販売代理店ニーズ：  積極的に「販売代理店として動けるパートナー」を探している  営業・採用・DX領域への関心：  営業支援  採用支援  Lシンク含む仕組み化ツール  今回の対応内容：  営業／採用／Lシンク関連の情報を全て送付予定  ⑤ 当社からの次アクション  送付対応（即時）  営業支援資料  採用支援資料  Lシンク概要資料 → 一括送信  来週アクション  11日以降、検討結果のヒアリング  以下いずれかの方向性を明確化  代理店提携  福利厚生向けBtoBモデル構築  Lシンク導入（自社 or 代理店活用）  ⑥ 戦略的所感（社内向けメモ）  相性が良いポイント  ママ層×共感×ライブコマース＝LTVが高い  福利厚生・CSR文脈での法人提案に展開可能  次の一手  「代理店＋福利厚生BtoB」の二軸設計が有望  ママ販売員×企業福利厚生のハイブリッドモデル構築余地あり', NULL, NULL, NULL, '回答', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0d5369b5-1858-46b0-a9ec-8aef6a5e13a1', '91abddbc-a61d-410e-8033-ecd3c810bd73', 3, '2026-02-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5d5af6da-a2c4-4247-9994-e03ad5c6f403', '35c7ca8e-0b4e-4842-8f5c-0cd29933b3dd', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（記録用） ■ 商談先①：佐藤利音 様  テーマ：フォーム営業（フォーム送信）の活用検討  現状・要望  フォーム送信を利用した営業手法に関心あり  初期費用は 0円 を前提に検討したい意向  最終的には「フォーム営業を継続的に利用する」イメージ  現在は 検討結果待ち のステータス  ポイント整理  初期費用ゼロは心理的ハードルが低く、導入フックとして有効  成果報酬型 or 月額低額スタートの設計が刺さりやすい  「どの程度のリード数が見込めるか」の定量提示が次アクション  ステータス  検討中（フォロー必要）  ■ 商談先②：影山 様  バックグラウンド  自衛隊 幹部候補生  フランス・イタリアでのワーキング経験あり  営業領域は幅広く経験  認識・評価  サービスラインナップが揃っている点を評価  既に 数社への導入提案を検討・推奨できる状態  営業の基本スタンスは 「リストを作成 → 数を打つ → サービスリードを獲得」  ■ 提案・検討サービス：メンタルヘルス領域  提供イメージ  ウェビナー施策を起点にしたリード獲得  内容：  ストレスチェック  クーポン提供  参加者限定の「組織診断」  フォーム営業で潜在層へリーチ → ウェビナー誘導  実績・示唆  既に 3社導入実績あり  対象は toCビジネスを展開する企業  組織拡大フェーズ（従業員50名以上）で  メンタル不調が顕在課題として浮上  エンゲージメント低下が経営課題化しやすい  課題認識  メンタル不調は「顕在ニーズ」よりも 潜在ニーズ  数値での課題可視化（ストレスチェック・組織診断）が有効  社内貢献度・エンゲージメント向上が導入後の価値訴求ポイント  ■ 商談全体の示唆（戦略的整理）  フォーム営業 × メンタルヘルスは相性が良い → 潜在層への大量接触 → ウェビナーで顕在化  「初期費用ゼロ」「まずはリード獲得のみ」という設計が刺さる  50名以上の成長企業を明確にターゲット化すべき  次回は  想定リード数  ウェビナー参加率  導入企業のBefore / After を数値で提示できるとクロージングが早い', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '35c3770b-0469-4638-bd1f-a138d53aba2a', '35c7ca8e-0b4e-4842-8f5c-0cd29933b3dd', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（記録用） ■ 商談先①：佐藤利音 様  テーマ：フォーム営業（フォーム送信）の活用検討  現状・要望  フォーム送信を利用した営業手法に関心あり  初期費用は 0円 を前提に検討したい意向  最終的には「フォーム営業を継続的に利用する」イメージ  現在は 検討結果待ち のステータス  ポイント整理  初期費用ゼロは心理的ハードルが低く、導入フックとして有効  成果報酬型 or 月額低額スタートの設計が刺さりやすい  「どの程度のリード数が見込めるか」の定量提示が次アクション  ステータス  検討中（フォロー必要）  ■ 商談先②：影山 様  バックグラウンド  自衛隊 幹部候補生  フランス・イタリアでのワーキング経験あり  営業領域は幅広く経験  認識・評価  サービスラインナップが揃っている点を評価  既に 数社への導入提案を検討・推奨できる状態  営業の基本スタンスは 「リストを作成 → 数を打つ → サービスリードを獲得」  ■ 提案・検討サービス：メンタルヘルス領域  提供イメージ  ウェビナー施策を起点にしたリード獲得  内容：  ストレスチェック  クーポン提供  参加者限定の「組織診断」  フォーム営業で潜在層へリーチ → ウェビナー誘導  実績・示唆  既に 3社導入実績あり  対象は toCビジネスを展開する企業  組織拡大フェーズ（従業員50名以上）で  メンタル不調が顕在課題として浮上  エンゲージメント低下が経営課題化しやすい  課題認識  メンタル不調は「顕在ニーズ」よりも 潜在ニーズ  数値での課題可視化（ストレスチェック・組織診断）が有効  社内貢献度・エンゲージメント向上が導入後の価値訴求ポイント  ■ 商談全体の示唆（戦略的整理）  フォーム営業 × メンタルヘルスは相性が良い → 潜在層への大量接触 → ウェビナーで顕在化  「初期費用ゼロ」「まずはリード獲得のみ」という設計が刺さる  50名以上の成長企業を明確にターゲット化すべき  次回は  想定リード数  ウェビナー参加率  導入企業のBefore / After を数値で提示できるとクロージングが早い', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '448dfbe6-f2fe-4f58-af60-e68b8e833123', '6de4a2c7-6d71-49a6-88e9-b0e607a757c3', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', '代理店A', '商談サマリー（記録用） ■ 商談先  株式会社ainak 五十嵐 洋介 様  ① 技術・プロダクト関連の論点 ■ パスワード処理・開発可否  「パスワード処理」が技術的に可能かどうかを検討・開発テーマとして議論  実現できれば仮想通貨マイニング用途にも転用可能との示唆あり  現時点では  技術的な可否確認  セキュリティ・法的観点の整理 が必要な段階  👉 結論 技術資料を確認した上で、実装可否と事業転用可能性を判断するフェーズ。  ② 代理店契約・提携に関する話  今後、資料を受領予定  その資料をもとに  代理店契約の条件  収益分配モデル  営業範囲 を含めて詳細協議予定  代理店契約の内容確認が次の重要アクション  👉 なお、  サービス内容によっては営業代行もセットで導入したい意向あり  ただし、導入判断までには一定の検討時間が必要  ③ 会社・マーケティング基盤  創業14年目の会社  LP集客は ロックオンマーケティングを活用  ④ 広告プロダクト概要（強み） ■ データ活用・ターゲティング  GPSベースでの高度なターゲティングが可能  東京大学に出入りしている人  夜の飲み屋に行っている層  物件データ連動  築年数  家賃帯 などでもセグメント可能  ■ URL指定型広告  特定のURLを閲覧したユーザーをターゲットに広告配信  非常にピンポイントなリターゲティングが可能  ■ インバウンド対応  外国人旅行者のスマートフォン特定が可能  インバウンド向け広告配信にも対応  ⑤ 広告費・成果指標 ■ Web広告（クリック課金）  1クリック：約100円  最低出稿：  10万円＝約1,000クリック  手数料：20%  実質費用目安：14万円〜  収益分配イメージ：折半  買い切り型の設計も可能  ■ 数値実績  表示回数：約28万回  クリック率（CTR）：  平均 0.35%  高い場合 1%前後  コンバージョン率（CVR）：約0.3%  想定CV数：1〜5件程度  ⑥ オフライン施策（富裕層向け）  富裕層向けポスティングが可能 （通常は難しいセグメント）  最低ロット：1万部  費用感：15万〜20万円  ⑦ 想定ターゲット業種  不動産  パーソナルジム （高単価・LTV型ビジネスとの相性が良い）  ⑧ 契約プラン例（サブスク型）  3ヶ月契約  初期費用：5万円  月額：10万円  代理店報酬：20%', NULL, NULL, NULL, '代理店の件', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3adced6b-5692-480f-91e0-15fdcc5f0b40', '6de4a2c7-6d71-49a6-88e9-b0e607a757c3', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', '代理店A', '商談サマリー（記録用） ■ 商談先  株式会社ainak 五十嵐 洋介 様  ① 技術・プロダクト関連の論点 ■ パスワード処理・開発可否  「パスワード処理」が技術的に可能かどうかを検討・開発テーマとして議論  実現できれば仮想通貨マイニング用途にも転用可能との示唆あり  現時点では  技術的な可否確認  セキュリティ・法的観点の整理 が必要な段階  👉 結論 技術資料を確認した上で、実装可否と事業転用可能性を判断するフェーズ。  ② 代理店契約・提携に関する話  今後、資料を受領予定  その資料をもとに  代理店契約の条件  収益分配モデル  営業範囲 を含めて詳細協議予定  代理店契約の内容確認が次の重要アクション  👉 なお、  サービス内容によっては営業代行もセットで導入したい意向あり  ただし、導入判断までには一定の検討時間が必要  ③ 会社・マーケティング基盤  創業14年目の会社  LP集客は ロックオンマーケティングを活用  ④ 広告プロダクト概要（強み） ■ データ活用・ターゲティング  GPSベースでの高度なターゲティングが可能  東京大学に出入りしている人  夜の飲み屋に行っている層  物件データ連動  築年数  家賃帯 などでもセグメント可能  ■ URL指定型広告  特定のURLを閲覧したユーザーをターゲットに広告配信  非常にピンポイントなリターゲティングが可能  ■ インバウンド対応  外国人旅行者のスマートフォン特定が可能  インバウンド向け広告配信にも対応  ⑤ 広告費・成果指標 ■ Web広告（クリック課金）  1クリック：約100円  最低出稿：  10万円＝約1,000クリック  手数料：20%  実質費用目安：14万円〜  収益分配イメージ：折半  買い切り型の設計も可能  ■ 数値実績  表示回数：約28万回  クリック率（CTR）：  平均 0.35%  高い場合 1%前後  コンバージョン率（CVR）：約0.3%  想定CV数：1〜5件程度  ⑥ オフライン施策（富裕層向け）  富裕層向けポスティングが可能 （通常は難しいセグメント）  最低ロット：1万部  費用感：15万〜20万円  ⑦ 想定ターゲット業種  不動産  パーソナルジム （高単価・LTV型ビジネスとの相性が良い）  ⑧ 契約プラン例（サブスク型）  3ヶ月契約  初期費用：5万円  月額：10万円  代理店報酬：20%', NULL, NULL, NULL, '代理店の件', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c952b545-82ac-4974-ae77-609d98903aa8', '0b32a1b1-15c8-4d32-be58-8ba01eacbd01', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', '代理店A', '商談内容サマリー  企業名：ツナムグデザイン ご担当者：鈴木 伸聡 様 商談テーマ：代理店提携・サービス導入検討・今後の連携方針  1. 決定事項（確定事項）  代理店提携：確定  当社商材の代理店として参画することが決定  改めて代理店向け資料一式を送付  商材研修（オンライン想定）を実施予定  2. 導入検討中のサービス  フォームAI等の当社サービス  サービス内容・価値については高評価  導入意向はあるが、タイミングは少し先  現時点では情報収集・理解フェーズ  3. 鈴木様側の事業方針・スタンス  ホームページ営業を起点  直接売り込みではなく、 ウェビナー誘導 → 受け皿経由での獲得を重視  4月からコミュニティ立ち上げ予定  IT系経営者を中心としたコミュニティ  単なるSEO・マーケ手法の教育ではない  4. コミュニティ・教育方針の特徴  対象：  IT系の経営者  既に一定レベルで事業運営ができている層  提供価値：  マーケティングの「ノウハウ」ではなく 「選択と判断」にフォーカス  戦略・戦術レベルでの意思決定を磨く思想  既に成果を出している経営者の思考整理・高度化が主目的  5. 今後のアクション  当社側：  代理店向け資料一式の送付  商材研修日程の調整・実施  中長期：  コミュニティ立ち上げ後の動きを見ながら フォームAI等の導入再提案  ウェビナー×受け皿モデルとの連携余地を継続検討', NULL, NULL, NULL, '回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f86ccd58-3d49-43cb-8869-65df4011ec89', '0b32a1b1-15c8-4d32-be58-8ba01eacbd01', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', '代理店A', '商談内容サマリー  企業名：ツナムグデザイン ご担当者：鈴木 伸聡 様 商談テーマ：代理店提携・サービス導入検討・今後の連携方針  1. 決定事項（確定事項）  代理店提携：確定  当社商材の代理店として参画することが決定  改めて代理店向け資料一式を送付  商材研修（オンライン想定）を実施予定  2. 導入検討中のサービス  フォームAI等の当社サービス  サービス内容・価値については高評価  導入意向はあるが、タイミングは少し先  現時点では情報収集・理解フェーズ  3. 鈴木様側の事業方針・スタンス  ホームページ営業を起点  直接売り込みではなく、 ウェビナー誘導 → 受け皿経由での獲得を重視  4月からコミュニティ立ち上げ予定  IT系経営者を中心としたコミュニティ  単なるSEO・マーケ手法の教育ではない  4. コミュニティ・教育方針の特徴  対象：  IT系の経営者  既に一定レベルで事業運営ができている層  提供価値：  マーケティングの「ノウハウ」ではなく 「選択と判断」にフォーカス  戦略・戦術レベルでの意思決定を磨く思想  既に成果を出している経営者の思考整理・高度化が主目的  5. 今後のアクション  当社側：  代理店向け資料一式の送付  商材研修日程の調整・実施  中長期：  コミュニティ立ち上げ後の動きを見ながら フォームAI等の導入再提案  ウェビナー×受け皿モデルとの連携余地を継続検討', NULL, NULL, NULL, '回答', '2026-02-06'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd8f9b2f9-cd11-4fab-b6e1-19b5f83ebba0', '2d285d5d-3ea0-404c-b14e-c37510f57475', 1, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜プロモーション／代理店＋フォームAI検討 ① 商談結論・ステータス  検討内容  代理店契約への参加  フォームAI（DM自動送信）の導入  意思決定タイミング  今週末に社内検討  1週間後に再連絡し、最終回答を確認  ② 先方の事業内容（整理）  タレント・モデル育成事業  若手表現者（モデル／タレント）の発掘・育成・支援  自社サービス「VOZEL」等を運営  プロモーション企画・運営  ブランド・タレントの露出機会設計〜実行  イベント企画・運営  文化／エンタメ領域のイベント設計・実施  物販事業  アパレル・雑貨の直販／プロモーション連動販売  不動産賃貸事業  収益不動産の保有・運用  広告・SNSマーケティング支援  SNS・デジタルチャネルを活用した集客・認知施策  ③ 現在の強み・アセット  芸能事務所との提携実績  エイベックス  ホリプロ  案件数：約300件  アーティスト育成の実績  平成ソング系アーティスト  ロードオブメジャーのリーダーが講師として関与  企業向けPRへの転用  アーティスト・タレントが企業商材をPR  求人案件の場合：  企業に入り込み → 動画コンテンツを納品  ④ 提供可能なプロモーションメニュー  動画制作・活用  動画制作費：15万〜20万円  ショート動画として広告・SNS運用に展開  二次利用可能  広告運用  制作動画を起点にSNS広告・ショート動画配信  タレント起用型PR  商品・サービスの信頼性／話題性を強化  ⑤ 今後の開拓方針  ターゲット  30〜40代の経営者層  狙い方  N8Nを活用したDM自動送信  フォームAIを使った効率的なアウトリーチ  目的  経営者との直接接点創出  プロモーション／求人／広告案件の獲得  ⑥ 次アクション（ToDo）   代理店条件・資料を先方へ送付   フォームAI（DM自動送信）の具体仕様・活用イメージ共有   1週間後にフォロー連絡 → 意思決定確認', NULL, NULL, NULL, '回答', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '513d9767-cacd-4553-aaf0-3137dea03813', '2d285d5d-3ea0-404c-b14e-c37510f57475', 2, '2026-02-04', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー｜プロモーション／代理店＋フォームAI検討 ① 商談結論・ステータス  検討内容  代理店契約への参加  フォームAI（DM自動送信）の導入  意思決定タイミング  今週末に社内検討  1週間後に再連絡し、最終回答を確認  ② 先方の事業内容（整理）  タレント・モデル育成事業  若手表現者（モデル／タレント）の発掘・育成・支援  自社サービス「VOZEL」等を運営  プロモーション企画・運営  ブランド・タレントの露出機会設計〜実行  イベント企画・運営  文化／エンタメ領域のイベント設計・実施  物販事業  アパレル・雑貨の直販／プロモーション連動販売  不動産賃貸事業  収益不動産の保有・運用  広告・SNSマーケティング支援  SNS・デジタルチャネルを活用した集客・認知施策  ③ 現在の強み・アセット  芸能事務所との提携実績  エイベックス  ホリプロ  案件数：約300件  アーティスト育成の実績  平成ソング系アーティスト  ロードオブメジャーのリーダーが講師として関与  企業向けPRへの転用  アーティスト・タレントが企業商材をPR  求人案件の場合：  企業に入り込み → 動画コンテンツを納品  ④ 提供可能なプロモーションメニュー  動画制作・活用  動画制作費：15万〜20万円  ショート動画として広告・SNS運用に展開  二次利用可能  広告運用  制作動画を起点にSNS広告・ショート動画配信  タレント起用型PR  商品・サービスの信頼性／話題性を強化  ⑤ 今後の開拓方針  ターゲット  30〜40代の経営者層  狙い方  N8Nを活用したDM自動送信  フォームAIを使った効率的なアウトリーチ  目的  経営者との直接接点創出  プロモーション／求人／広告案件の獲得  ⑥ 次アクション（ToDo）   代理店条件・資料を先方へ送付   フォームAI（DM自動送信）の具体仕様・活用イメージ共有   1週間後にフォロー連絡 → 意思決定確認', NULL, NULL, NULL, '回答', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f60246d1-a482-4adb-a839-fb68cd815b94', 'cc459cbe-7248-4173-835a-fc0e4dfa8b0d', 1, '2026-02-06', '00000000-0000-0000-0000-000000000002', '代理店A', '人材開発のコンサルをやっている その中でクライアントに売れそう この会社は紹介の仕組みで営業は十分できていると', NULL, NULL, NULL, '商材研修日程調整', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '28bcd4fd-61f7-432c-b43c-daaa4bd4d03a', 'cc459cbe-7248-4173-835a-fc0e4dfa8b0d', 2, '2026-02-06', '00000000-0000-0000-0000-000000000002', '代理店A', '人材開発のコンサルをやっている その中でクライアントに売れそう この会社は紹介の仕組みで営業は十分できていると', NULL, NULL, NULL, '商材研修日程調整', '2026-02-12'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '27afaf94-ac57-49e4-8ac3-d4008eebf4f5', 'b2a34612-8de8-45a8-a20b-44e6b8caba51', 1, '2026-02-10', '00000000-0000-0000-0000-000000000002', 'A', 'ハチドリエージェントを導入 新潟県というエリアと技術職で本当に3人も紹介できるのかとのこと  現在の活動は採用媒体(マイナビ、リクナビ、DODA、ハローワーク) エージェントも年に1.2人ぐらいの推薦となっている', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40fa0902-f198-43ff-8ffe-826ac9272bea', 'b2a34612-8de8-45a8-a20b-44e6b8caba51', 2, '2026-02-10', '00000000-0000-0000-0000-000000000002', 'A', 'ハチドリエージェントを導入 新潟県というエリアと技術職で本当に3人も紹介できるのかとのこと  現在の活動は採用媒体(マイナビ、リクナビ、DODA、ハローワーク) エージェントも年に1.2人ぐらいの推薦となっている', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4e0f9487-cc3b-4311-a2bc-0107cd2237fe', 'd085cbff-9ac4-4e9d-b482-cd5bb690a0bd', 1, '2026-02-12', '00000000-0000-0000-0000-000000000002', 'A', '本日中に申し込む', NULL, NULL, NULL, '申込書回収', '2026-02-10'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1ec86668-65c6-4417-b9af-a49fb6a27f11', 'd085cbff-9ac4-4e9d-b482-cd5bb690a0bd', 2, '2026-02-09', '00000000-0000-0000-0000-000000000002', 'A', '【ヒアリング内容】  新卒・中途ともに採用中  中途採用職種  データサイエンティスト（エンジニア系）：最大ボリューム  営業職  営業アシスタント  人事職  採用エリア  メイン：東京  営業職のみ大阪支社立ち上げメンバー募集あり  大阪支社は2026年末頃設立予定（前後の可能性あり）  入社後1〜数年は東京勤務、その後大阪転勤想定  採用スピード・方針  直近で積極的に増員したい意向  採用手法  データサイエンティスト：求人広告中心でも母集団形成できている  営業職：人材紹介（エージェント）依存度が高い  その他職種：求人広告＋人材紹介を併用  人材紹介経由の状況（営業職）  月間約90名の推薦あり  日次ベースで継続的に紹介が入っている  営業職の業務内容  新規開拓が中心  一気通貫型営業（担当企業を持ち、年数経過で既存フォロー比率増）  【課題】  営業職採用は人材紹介への依存度が高く、紹介手数料が高額  現状：30〜35％以上が一般的  エージェント数を増やしており、管理・比較が煩雑になりがち  条件面（人柄・カルチャーフィット等）をどこまでマッチングに反映できるか不安あり  【提案サービス】  ハチドリAIエージェント  種別：成果報酬型 人材紹介サービス（AIマッチング型）  概要：  初期費用・固定費なし  採用決定時のみ成果報酬発生  複数人材紹介会社とAIでマッチング  コミュニケーションツール（メール等）で候補者推薦  参考補足（合意・認識事項として重要な点のみ）  現行エージェント手数料（30〜35％以上）より低水準である点は評価  成果報酬型であれば、基本的に契約を進める方針  【次回アクション】  OptiLink／ライトアップ側  サービス詳細URLおよび申込書をメールで送付  支払い方法は銀行振込対応で案内  データアナリティクスラボ側  申込書内容の確認・対応  募集条件（既存求人票ベース＋必要に応じて補足条件）を共有予定  未確認・今後確認事項  実際に紹介される人材の質・マッチ度合い（導入後に判断）  営業向けAIツール活用可否は営業部判断のため現時点では未検討', NULL, NULL, NULL, '申込書回収', '2026-02-10'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '654adcc8-8090-4422-9a62-3e7bfebfd8e7', 'd085cbff-9ac4-4e9d-b482-cd5bb690a0bd', 3, '2026-02-12', '00000000-0000-0000-0000-000000000002', NULL, '本日中に申し込む', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f713b503-3908-4bd2-a840-dd105cb5a7b2', '819e3142-6e4b-4a96-b25e-64c4ecc66e6f', 1, '2026-02-09', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】  採用状況：営業職・納品/配達系（拠点/エリアは岡山県内、倉敷で営業1名を検討していた経緯あり）  現在の採用手段：自社採用サイト中心。媒体はあまり使っていない  試した/利用中：Indeed PLUS（営業提案を受けた）、Airワーク（無料〜1万円程度の提案で作り直し実施）、自治体系の地域サイト  人材紹介（中途）は未導入。新卒は今年、スポーツ系に特化した紹介（1人100万円前後イメージ）を「どんな人が来るか見たい」目的で今週話を進める予定  応募状況：営業職は応募が非常に少ない（直近は昨年12月に1件。Airワーク経由）  採用難易度の肌感：配達/納品系は採用できている（昨年3名採用：倉敷1名＋他2名）。営業は難しい認識  営業職の内容：新規開拓ではなくルート営業  社内意思決定：役員4名。採用費用に抵抗感が強い役員が2名ほどいる。人事系の会議が毎月2回あり、そこで協議  【課題】  営業職の応募が少なく、採用チャネル拡張が必要だが、有料施策の稟議が通りづらい  有料求人媒体は「不確実性（費用をかけても採れない）」がネックで先送りになりやすい（昨年11月頃に倉敷営業の媒体提案→検討中のまま時期逸失し見送り）  人材紹介は「採用できたら確実に費用発生」だが、年収の約3割水準の費用感が社内で了承されるか不透明  早期退職時の返金/保証がない場合、社内で懸念が強く出る可能性（“桜がいるのでは”のような不信感も出やすい）  【提案サービス】  ハチドリAIエージェント（人材紹介/成果報酬型）  料金：採用決定時に年収の27%（初期費用・固定費なし）  条件/特徴：毎日3名の推薦を保証（求人票をAIに学習させマッチング→Slack/LINE/Google Chat/メール等で通知）  留意点：早期退職に対する返金/補償はなし（リスクとして先方が懸念）  【次回アクション】  当社（樋上）：提案資料をメール送付  先方（河原様）：来週実施予定の人事系会議（週内2回）で本サービスを提案・共有  伝え方のポイント：①成果報酬で「採用するまで費用0」②まずは“人材を見るだけ”でも可能（比較材料になる）③推薦数が多い点  当社（樋上）：来週末を目安に会議後の検討結果をフォロー（導入可否/懸念点の回収）', NULL, NULL, NULL, '検討状況確認', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '873bd539-ba8c-43d4-9ec8-bb00f10ceac9', '819e3142-6e4b-4a96-b25e-64c4ecc66e6f', 2, '2026-02-09', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】  採用状況：営業職・納品/配達系（拠点/エリアは岡山県内、倉敷で営業1名を検討していた経緯あり）  現在の採用手段：自社採用サイト中心。媒体はあまり使っていない  試した/利用中：Indeed PLUS（営業提案を受けた）、Airワーク（無料〜1万円程度の提案で作り直し実施）、自治体系の地域サイト  人材紹介（中途）は未導入。新卒は今年、スポーツ系に特化した紹介（1人100万円前後イメージ）を「どんな人が来るか見たい」目的で今週話を進める予定  応募状況：営業職は応募が非常に少ない（直近は昨年12月に1件。Airワーク経由）  採用難易度の肌感：配達/納品系は採用できている（昨年3名採用：倉敷1名＋他2名）。営業は難しい認識  営業職の内容：新規開拓ではなくルート営業  社内意思決定：役員4名。採用費用に抵抗感が強い役員が2名ほどいる。人事系の会議が毎月2回あり、そこで協議  【課題】  営業職の応募が少なく、採用チャネル拡張が必要だが、有料施策の稟議が通りづらい  有料求人媒体は「不確実性（費用をかけても採れない）」がネックで先送りになりやすい（昨年11月頃に倉敷営業の媒体提案→検討中のまま時期逸失し見送り）  人材紹介は「採用できたら確実に費用発生」だが、年収の約3割水準の費用感が社内で了承されるか不透明  早期退職時の返金/保証がない場合、社内で懸念が強く出る可能性（“桜がいるのでは”のような不信感も出やすい）  【提案サービス】  ハチドリAIエージェント（人材紹介/成果報酬型）  料金：採用決定時に年収の27%（初期費用・固定費なし）  条件/特徴：毎日3名の推薦を保証（求人票をAIに学習させマッチング→Slack/LINE/Google Chat/メール等で通知）  留意点：早期退職に対する返金/補償はなし（リスクとして先方が懸念）  【次回アクション】  当社（樋上）：提案資料をメール送付  先方（河原様）：来週実施予定の人事系会議（週内2回）で本サービスを提案・共有  伝え方のポイント：①成果報酬で「採用するまで費用0」②まずは“人材を見るだけ”でも可能（比較材料になる）③推薦数が多い点  当社（樋上）：来週末を目安に会議後の検討結果をフォロー（導入可否/懸念点の回収）', NULL, NULL, NULL, '検討状況確認', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '654f93c1-b3cf-4e5b-bccc-e648e19afaef', '91bea770-96b7-40c4-a72d-ed6440baff2f', 1, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・中途採用：営業職／経理職を募集中 ・募集エリア：本社（神田・東京）。経理＝東京、営業＝東京＋横浜・大阪 ・採用手法：エージェント、ダイレクトリクルーティング、リファラルを併用 ・エージェント推薦数：直近1ヶ月（経理）で合計約43名 ・営業活動：地主向けに連絡先を調べてテレアポする運用あり（テレアポを全くしないスタイルではない） ・AI活用：営業領域でのAI導入は現状なし ・今後検討：技術職（建築設計、施工管理）の採用ニーズが社内で出てきている  【課題】 ・候補者接点は「増えるなら増えるに越したことない」（面談機会を増やしたい） ・営業職は「用地仕入れ営業（不動産）」の経験者が見つかりにくく、ピンポイント要件で母集団形成が難しい ・長期利用時の候補者重複／供給継続性に懸念（半年～1年利用だと重複可能性がある旨の回答あり） ・導入にあたり社内のコンプラチェック／契約関連の事前確認フローが必須  【提案サービス】 ・AIハチドリAIエージェント（採用向けAI活用型の人材紹介サービス） ・（補足で言及のみ）営業向けAIツール群（リスト作成、テレアポ、フォーム営業 等）  【次回アクション】 ・（先方）サービス資料を受領後、社内でコンプラ・契約周りの確認を実施 ・（先方）必要資料（会社資料等）の要求リストをメール返信で送付 ・（当方）必要資料を準備し返送 ・（先方）結論目安：今月末までに申込可否（申込まで）判断できる想定', NULL, NULL, NULL, '検討結果', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '465f40ca-b96b-4bef-821b-14a4a4195b5b', '91bea770-96b7-40c4-a72d-ed6440baff2f', 2, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・中途採用：営業職／経理職を募集中 ・募集エリア：本社（神田・東京）。経理＝東京、営業＝東京＋横浜・大阪 ・採用手法：エージェント、ダイレクトリクルーティング、リファラルを併用 ・エージェント推薦数：直近1ヶ月（経理）で合計約43名 ・営業活動：地主向けに連絡先を調べてテレアポする運用あり（テレアポを全くしないスタイルではない） ・AI活用：営業領域でのAI導入は現状なし ・今後検討：技術職（建築設計、施工管理）の採用ニーズが社内で出てきている  【課題】 ・候補者接点は「増えるなら増えるに越したことない」（面談機会を増やしたい） ・営業職は「用地仕入れ営業（不動産）」の経験者が見つかりにくく、ピンポイント要件で母集団形成が難しい ・長期利用時の候補者重複／供給継続性に懸念（半年～1年利用だと重複可能性がある旨の回答あり） ・導入にあたり社内のコンプラチェック／契約関連の事前確認フローが必須  【提案サービス】 ・AIハチドリAIエージェント（採用向けAI活用型の人材紹介サービス） ・（補足で言及のみ）営業向けAIツール群（リスト作成、テレアポ、フォーム営業 等）  【次回アクション】 ・（先方）サービス資料を受領後、社内でコンプラ・契約周りの確認を実施 ・（先方）必要資料（会社資料等）の要求リストをメール返信で送付 ・（当方）必要資料を準備し返送 ・（先方）結論目安：今月末までに申込可否（申込まで）判断できる想定', NULL, NULL, NULL, '検討結果', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1f4be9af-b606-4d85-b8e3-783ace581bee', '84869aed-f615-4d60-98e1-8943f65bef72', 1, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 2月中申し込みで初期費用15万円と伝えている 企業名：株式会社東伸社 担当者：鈴木様  1. 商談結論（現時点ステータス）  フォームAI  リスト生成AI  名刺フォローAI  上記 3サービスすべてに興味関心あり。 最終的には フル活用を前提とした導入検討 の意向。  → 改めて東伸社様向けに最適化した形で再商談を実施予定。  ネクストアクション  1週間後〜2週間後を目安に連絡  検討状況の確認および具体導入範囲のすり合わせ  2. 事業概要・現状  印刷・営業・発送関連事業を展開  業界歴：約25年  長年の顧客基盤あり  3. 現在の営業手法  主軸は以下2点：  リストアップ営業  既存顧客・取引先からの紹介（リファラル）  ただし実態としては：  紹介経由が大半  紹介の精度に課題あり  新規開拓力が弱い構造  4. 課題認識 ① 新規開拓の弱さ  フル新規の開発型営業が未確立  印刷・発送特化のテレアポ実績が不足  ② テレアポ外注の失敗経験  過去にA社・S社へ委託  ただし印刷業界理解が浅く成果出ず  現在は利用停止状態（関係は継続も距離あり）  ③ アポ品質の低さ  展示会名刺・紹介案件中心  商談温度感が低い  「今日は何の件ですか？」レベルの案件あり → 事前ナーチャリング不足  5. リード獲得チャネル（現状）  展示会名刺交換  紹介・リファラル  業界ネットワーク  一定成果はあるものの：  再現性が低い  スケールしない  商談化率が不安定  6. 今後強化したい営業領域 ① コスト課題系企業  印刷コスト削減  発送コスト削減 に課題を持つ企業へのアプローチ  ② 事業立ち上げ企業  新規事業を検討中  印刷・発送スキーム未整備  ③ DX推進企業  デジタル化を進めたい  ただしシステム活用が不十分  運用設計が組めていない  7. デジタルシフト構想  以下領域に関心あり：  LINE公式アカウント活用  Lステップ運用  紙→デジタル配信移行  業界紙・新聞のデジタル化  特に：  印刷・発送だけでなく、デジタル配信まで完結させたい  という構想あり。  8. ターゲット業界構想  通販業界  小売業界  業界新聞・業界誌関連  紙×デジタルのハイブリッド展開を想定。  9. AI活用ニーズ整理 領域        ニーズ フォームAI        フル新規開拓チャネル構築 リスト生成AI        精度の高いターゲット抽出 名刺フォローAI        展示会・紹介リードのナーチャリング 全体        開発型営業モデル構築 10. 導入初期（1ヶ月目）で求める成果  優先KPI：  印刷コスト課題企業のアポ獲得  発送コスト課題企業のアポ獲得  DX検討企業のリード創出  11. 提案方向性（整理）  今後の提案設計としては：  ① 新規開拓基盤構築  フォームAI  リスト生成AI  ② 名刺資産の再活用  名刺フォローAI  展示会リードナーチャリング  ③ DX文脈営業支援  紙→デジタル移行提案  LINE / Lステップ連携  12. 商談温度感  興味関心：高  導入意欲：中〜高  検討フェーズ：情報収集後半  「まずは話を聞きたい」ではなく 「どう使うかを検討したい」フェーズ。', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b1b26974-c636-4677-ad7a-69ff833c21ad', '84869aed-f615-4d60-98e1-8943f65bef72', 2, '2026-02-06', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 2月中申し込みで初期費用15万円と伝えている 企業名：株式会社東伸社 担当者：鈴木様  1. 商談結論（現時点ステータス）  フォームAI  リスト生成AI  名刺フォローAI  上記 3サービスすべてに興味関心あり。 最終的には フル活用を前提とした導入検討 の意向。  → 改めて東伸社様向けに最適化した形で再商談を実施予定。  ネクストアクション  1週間後〜2週間後を目安に連絡  検討状況の確認および具体導入範囲のすり合わせ  2. 事業概要・現状  印刷・営業・発送関連事業を展開  業界歴：約25年  長年の顧客基盤あり  3. 現在の営業手法  主軸は以下2点：  リストアップ営業  既存顧客・取引先からの紹介（リファラル）  ただし実態としては：  紹介経由が大半  紹介の精度に課題あり  新規開拓力が弱い構造  4. 課題認識 ① 新規開拓の弱さ  フル新規の開発型営業が未確立  印刷・発送特化のテレアポ実績が不足  ② テレアポ外注の失敗経験  過去にA社・S社へ委託  ただし印刷業界理解が浅く成果出ず  現在は利用停止状態（関係は継続も距離あり）  ③ アポ品質の低さ  展示会名刺・紹介案件中心  商談温度感が低い  「今日は何の件ですか？」レベルの案件あり → 事前ナーチャリング不足  5. リード獲得チャネル（現状）  展示会名刺交換  紹介・リファラル  業界ネットワーク  一定成果はあるものの：  再現性が低い  スケールしない  商談化率が不安定  6. 今後強化したい営業領域 ① コスト課題系企業  印刷コスト削減  発送コスト削減 に課題を持つ企業へのアプローチ  ② 事業立ち上げ企業  新規事業を検討中  印刷・発送スキーム未整備  ③ DX推進企業  デジタル化を進めたい  ただしシステム活用が不十分  運用設計が組めていない  7. デジタルシフト構想  以下領域に関心あり：  LINE公式アカウント活用  Lステップ運用  紙→デジタル配信移行  業界紙・新聞のデジタル化  特に：  印刷・発送だけでなく、デジタル配信まで完結させたい  という構想あり。  8. ターゲット業界構想  通販業界  小売業界  業界新聞・業界誌関連  紙×デジタルのハイブリッド展開を想定。  9. AI活用ニーズ整理 領域        ニーズ フォームAI        フル新規開拓チャネル構築 リスト生成AI        精度の高いターゲット抽出 名刺フォローAI        展示会・紹介リードのナーチャリング 全体        開発型営業モデル構築 10. 導入初期（1ヶ月目）で求める成果  優先KPI：  印刷コスト課題企業のアポ獲得  発送コスト課題企業のアポ獲得  DX検討企業のリード創出  11. 提案方向性（整理）  今後の提案設計としては：  ① 新規開拓基盤構築  フォームAI  リスト生成AI  ② 名刺資産の再活用  名刺フォローAI  展示会リードナーチャリング  ③ DX文脈営業支援  紙→デジタル移行提案  LINE / Lステップ連携  12. 商談温度感  興味関心：高  導入意欲：中〜高  検討フェーズ：情報収集後半  「まずは話を聞きたい」ではなく 「どう使うかを検討したい」フェーズ。', NULL, NULL, NULL, '検討状況確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '00ca759e-174f-4e3a-8e3d-5376ca1ae1e1', 'ccb211ad-ea1e-407e-a10a-63a250dc8028', 1, '2026-02-09', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社アスドリーム／オオタ様）  獲得経路： ハチドリエージェント（AGT） 実施日： 2026/02/07 商材／テーマ： 採用（ハチドリAIエージェント）、Lシンク、採用自動化AI、業務効率化（入金消し込み・仕分け）  1. 現状・課題（Pain）  ① 入金消し込み業務が最大のボトルネック  月 約2億円規模 の入金消し込みが発生  入金の種類が 約100種類 に分かれており、照合・仕分けが非常に煩雑  「ここが一番困っている」と明言  ② 人材採用も常時発生しており、運用を楽にしたい  採用は継続的に実施（年齢レンジも広い：新卒〜77歳まで取りに行く方針）  営業人材も増やしたい意向あり  来場客対応など現場オペレーションも抱えている  ③ 過去に改善トライ → 失敗経験あり（実現ハードルへの警戒）  約2年前 に船井総研側で改善を試みたが、  必要情報（集めるデータ）が多すぎて難航し頓挫  そのため「また情報収集地獄になるならやりたくない」ニュアンスあり  2. 採用領域の反応（Needs / Fit）  ハチドリエージェントへの不満点（導入障壁）  「3人の中から探す手間が面倒」  “面談できる人材だけ教えて欲しい” スタンス  スカウトしてくれないならやらない と強めに発言  こちらから「当社は企業側が面談相手を最終選定する運用。ニーズ適合は面談で判断が確実なので、候補ピックアップまで支援し、最終判断は企業側で」という説明は実施済み  実績面の関心  実績を気にされていたため、  「採用単価が 25%下がった 事例」を共有済み（刺さりは一定あり）  プロダクト別温度感  Lシンク：使えそう（前向き）  採用自動化AI：固定費がかかるのでやりたくない（否定的）  3. 事業/業務オペレーション（補足メモ）  「車検のラインでやり取り」など、現場ライン業務が存在（詳細要確認）  「100項目仕分け」「ネジの仕分け、1円〜」など、  多品目・低単価・仕分け系の管理が発生している可能性（業務設計ヒアリングが必要）  求人媒体（要確認を含む）  バイトル：月3万円  「ヂューだ 3枚」：表記不明（要確認）  「スカウト報酬 年収の4者ぐらい」：恐らく年収の一定割合（要確認）  「えーzぇいんと」：媒体/サービス名不明（要確認）  4. 提案方針（SoloptiLink側の打ち手）  最優先提案テーマ：入金消し込みの業務自動化／仕分けDX  先方の最大課題が“採用”よりも 入金消し込み（100種類） にあるため、  「経理オペのボトルネック解消」 を主軸に提案を再設計するのが勝ち筋  船井総研時に頓挫した理由が「必要情報が多すぎた」なので、  収集項目を最小化し、段階導入（PoC→範囲拡張）で再提案するのが鍵  採用は“ついでに効率化”ポジション  Lシンクは前向きなので、  採用の固定費が増えない形（運用負担を減らす）で再提案  「スカウトしないならやらない」発言があるため、  “運用としてどこまで当社がスカウト代行するか”の再定義が必要  もしくは、先方の運用負担が減る“面談確度の高い候補だけ提示”の設計に寄せる  5. 次アクション（ToDo）  入金消し込みの現状ヒアリング項目を最小限で提示し、実現性を確認  例：入金データ形式、消し込み先のキー、例外パターン、100種類の分類ルールの有無、既存会計/販売管理システム 等  船井総研時の「集める情報が多すぎて無理だった」ポイントを具体的に特定  “やる／やらない”判断会を設定し、提案の叩き台を持ち込む  採用はサブ提案として、  Lシンク導入イメージ、運用負担、スカウト要望（どこまで代行が必要か）を再確認', NULL, NULL, NULL, '日程調整進捗確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fbca3ea6-ca7e-47bc-ad62-10ff318e27ee', 'ccb211ad-ea1e-407e-a10a-63a250dc8028', 2, '2026-02-09', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー（株式会社アスドリーム／オオタ様）  獲得経路： ハチドリエージェント（AGT） 実施日： 2026/02/07 商材／テーマ： 採用（ハチドリAIエージェント）、Lシンク、採用自動化AI、業務効率化（入金消し込み・仕分け）  1. 現状・課題（Pain）  ① 入金消し込み業務が最大のボトルネック  月 約2億円規模 の入金消し込みが発生  入金の種類が 約100種類 に分かれており、照合・仕分けが非常に煩雑  「ここが一番困っている」と明言  ② 人材採用も常時発生しており、運用を楽にしたい  採用は継続的に実施（年齢レンジも広い：新卒〜77歳まで取りに行く方針）  営業人材も増やしたい意向あり  来場客対応など現場オペレーションも抱えている  ③ 過去に改善トライ → 失敗経験あり（実現ハードルへの警戒）  約2年前 に船井総研側で改善を試みたが、  必要情報（集めるデータ）が多すぎて難航し頓挫  そのため「また情報収集地獄になるならやりたくない」ニュアンスあり  2. 採用領域の反応（Needs / Fit）  ハチドリエージェントへの不満点（導入障壁）  「3人の中から探す手間が面倒」  “面談できる人材だけ教えて欲しい” スタンス  スカウトしてくれないならやらない と強めに発言  こちらから「当社は企業側が面談相手を最終選定する運用。ニーズ適合は面談で判断が確実なので、候補ピックアップまで支援し、最終判断は企業側で」という説明は実施済み  実績面の関心  実績を気にされていたため、  「採用単価が 25%下がった 事例」を共有済み（刺さりは一定あり）  プロダクト別温度感  Lシンク：使えそう（前向き）  採用自動化AI：固定費がかかるのでやりたくない（否定的）  3. 事業/業務オペレーション（補足メモ）  「車検のラインでやり取り」など、現場ライン業務が存在（詳細要確認）  「100項目仕分け」「ネジの仕分け、1円〜」など、  多品目・低単価・仕分け系の管理が発生している可能性（業務設計ヒアリングが必要）  求人媒体（要確認を含む）  バイトル：月3万円  「ヂューだ 3枚」：表記不明（要確認）  「スカウト報酬 年収の4者ぐらい」：恐らく年収の一定割合（要確認）  「えーzぇいんと」：媒体/サービス名不明（要確認）  4. 提案方針（SoloptiLink側の打ち手）  最優先提案テーマ：入金消し込みの業務自動化／仕分けDX  先方の最大課題が“採用”よりも 入金消し込み（100種類） にあるため、  「経理オペのボトルネック解消」 を主軸に提案を再設計するのが勝ち筋  船井総研時に頓挫した理由が「必要情報が多すぎた」なので、  収集項目を最小化し、段階導入（PoC→範囲拡張）で再提案するのが鍵  採用は“ついでに効率化”ポジション  Lシンクは前向きなので、  採用の固定費が増えない形（運用負担を減らす）で再提案  「スカウトしないならやらない」発言があるため、  “運用としてどこまで当社がスカウト代行するか”の再定義が必要  もしくは、先方の運用負担が減る“面談確度の高い候補だけ提示”の設計に寄せる  5. 次アクション（ToDo）  入金消し込みの現状ヒアリング項目を最小限で提示し、実現性を確認  例：入金データ形式、消し込み先のキー、例外パターン、100種類の分類ルールの有無、既存会計/販売管理システム 等  船井総研時の「集める情報が多すぎて無理だった」ポイントを具体的に特定  “やる／やらない”判断会を設定し、提案の叩き台を持ち込む  採用はサブ提案として、  Lシンク導入イメージ、運用負担、スカウト要望（どこまで代行が必要か）を再確認', NULL, NULL, NULL, '日程調整進捗確認', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '907462a1-5c8f-47de-93a5-d933702d1775', '3aab2e0a-edcd-4968-8db2-f1378bbb8cd9', 1, '2026-02-12', '00000000-0000-0000-0000-000000000001', 'A', '営業代行案件を依頼したいとのことで、 12日に顔合わせを行う', NULL, NULL, NULL, '会議状況確認', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '8788284a-0a54-4f1a-b018-4705a5cd1652', '3aab2e0a-edcd-4968-8db2-f1378bbb8cd9', 2, '2026-02-07', '00000000-0000-0000-0000-000000000001', 'C', '商談内容サマリー ① 総論（温度感・意思決定状況）  最終的に アイドマ・ホールディングス と比較した上で、断然 株式会社SoloptiLink の営業代行を推したい との評価。  火曜日の社内会議にて 全力で推進・プッシュ予定。  サービス評価は非常に高く、前向きな検討フェーズ。  会議後に正式なフィードバック・連絡をもらう予定。  ② 想定契約プラン  契約プランは以下2択で検討中  月額 50万円プラン  月額 65万円プラン  ③ 資料送付・連絡先  担当メール k-sano@forval.co.jp  送付資料  アイドマ比較資料  AIテレアポ資料  ④ 先方事業構想・スケール戦略 全国展開構想  将来的に 全国拠点すべてで同様の新規開拓を実施したい 方針。  全拠点で新規顧客獲得の仕組みを統一したいニーズあり。  大型事業構想  月額 6万円サービス を軸に、  15,000社契約 を形成し、  売上100億円規模 を目指す構想。  背景課題  中小企業の困りごとデータが体系的に存在していない。  行政・民間ともに実態データ不足。  施策  15,000社ネットワーク構築。  中小企業実態データの収集。  そのデータを基にソリューション提案。  産学連携  大学と連携しているため、  社会的インパクトの大きいプロジェクトへ発展可能性あり。  研究・分析データを顧客提案にも活用予定。  ⑤ 新規事業・営業課題 社内ベンチャー背景  新規開拓特化の社内ベンチャー事業を推進中。  ただし現状は新規獲得が伸び悩み。  業界背景  情報通信業界  光通信系の流れを汲むビジネスモデル  現在の課題  経営コンサル寄りになりすぎ、  新規営業の実働が弱体化。  解決方針  テストマーケティングから着手可能。  DX切り口一本での営業展開を検討。  ⑥ ターゲット業界  重点ターゲットは以下：  介護・福祉  建設工事  運送・物流  警備業  製造メンテナンス  イベント人材派遣  企業規模  従業員 10〜200名  市場背景  賃上げ圧力により収益悪化。  生産性改善が急務。  DX投資余力が限定的。  ⑦ 提供予定ソリューション DX支援（月額6万円） 内容  DXアドバイザー資格保有者が対応。  現状業務の可視化。  経営判断・意思決定支援。  生成AI活用支援  有償版生成AIを業務利用可能。  月額6万円プラン内で：  ChatGPT有償版を  最大100名利用可能  ※通常：1名 約4,000円/月相当  ⑧ リリース・販売計画  サービスリリース：4月予定  月額DX支援とセット販売。  ⑨ 営業体制の現状と変革方針 現在  社内架電部隊が稼働。  月売上：約5,000万円規模。  しかし…  賃上げにより人件費上昇。  新卒給与も上昇。  架電モデルの収益性が悪化。  今後方針  架電依存モデルから脱却。  営業DX・営業代行活用へシフト。  商談自体は継続実施。  ⑩ 付帯サービス・コンテンツ 動画コンテンツ  教育・営業動画を制作中。  4月から提供可能。  セキュリティ研修（無償版）  社員名義の疑似メール送信。  標的型攻撃訓練。  セキュリティリテラシー測定。  ⑪ 人材育成サービス  価格：300万円  目的  ベンダーマネジメント人材の育成。  外注・DXベンダー管理力強化。  期待効果  自社課題の言語化。  業務構造整理。  投資判断精度向上。  ⑫ 今後の営業展開示唆（重要ポイント）  本件の示唆は大きく3つ：  ① 全国横展開ポテンシャル  1拠点成功 → 全国展開。  LTVが極めて高い。  ② DX商材×営業代行の相性  架電からの脱却ニーズ。  営業プロセス外注需要。  テストマーケ起点導入可能。  ③ 産学連携データ活用  中小企業データ基盤構築。  政策連動可能性。  大型プロジェクト化余地。', NULL, NULL, NULL, '会議状況確認', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '93bce8cb-e175-47af-a236-04d5b677ace1', '3aab2e0a-edcd-4968-8db2-f1378bbb8cd9', 3, '2026-02-12', '00000000-0000-0000-0000-000000000001', 'A', '営業代行案件を依頼したいとのことで、 12日に顔合わせを行う', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fcdc0746-9839-402e-afd1-d2a3a0e6dc83', '7bf02f02-09d7-46e6-8818-7cbf1266a231', 1, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', '営業代行で提案中　4月開始の方向性で話が進んでいる状況 2月末ごろに決定できるとのこと 初期20万円　月額35万円　不動産業界(買取再販システム)、太陽光の業界など、そこに対して、無料でシステムの導入を行い、 その後に、有料提案を進める方針', NULL, NULL, NULL, '改めて連絡し、検討状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '93e55f16-511b-4420-8992-718ea9ad9131', '7bf02f02-09d7-46e6-8818-7cbf1266a231', 2, '2026-02-07', '00000000-0000-0000-0000-000000000001', 'C', 'ホームページのフォーム営業ツールを導入する方向で検討中 代理店契約に関しても行う形で合意しているため、採用面を特に取り扱いたいとのこと 改めて13日の11時から商談予定となる 研修及びフォームAIの利用について確認', NULL, NULL, NULL, '際商談', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '608fcec1-1e5e-4c21-a3f5-c1083bde090d', '7bf02f02-09d7-46e6-8818-7cbf1266a231', 3, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', '営業代行で提案中　4月開始の方向性で話が進んでいる状況 2月末ごろに決定できるとのこと 初期20万円　月額35万円　不動産業界(買取再販システム)、太陽光の業界など、そこに対して、無料でシステムの導入を行い、 その後に、有料提案を進める方針', NULL, NULL, NULL, '改めて連絡し、検討状況確認', '2026-03-02'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1f9d7191-1a20-4b4c-bfdb-761e392d26e4', 'e009504b-0ae6-4c96-8ce6-e6c203e31ae1', 1, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・中途採用を実施中（営業職・経理職） ・勤務地：本社（神田・東京）、営業は横浜・大阪も募集 ・採用手法：エージェント、ダイレクトリクルーティング、リファラルを活用中 ・直近1ヶ月の推薦数（経理）：各社合計で約43名 ・営業職は「用地仕入れ営業」を募集。ピンポイント経験者の母集団形成に課題感あり ・今後、技術職（建築設計・施工管理）も募集検討中 ・テレアポ営業は実施中（地主向けアプローチ等） ・AI活用は現状未導入 ・社内手続き上、導入前にコンプラチェック・契約関連確認が必要  【課題】 ・用地仕入れ営業など専門性の高い人材の母集団形成が難航 ・推薦数は一定数あるが、より多くの候補者と接点を持ちたい意向 ・長期利用時の候補者重複や精度維持に懸念 ・新サービス導入時の社内コンプラ・契約確認フローが必要  【提案サービス】 ・AIハチドリAIエージェント（AI活用型・完全成果報酬型の人材紹介サービス）  【次回アクション】 ・先方へサービス資料を送付 ・先方より必要資料（会社情報・契約関連資料等）の指定を受領 ・当社にて資料準備・返送 ・今月中を目安に社内コンプラチェックおよび申込可否判断予定 ・不明点があれば随時連絡対応', NULL, NULL, NULL, '先方のコンプラチェック用の資料送付', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '42f1bd45-7f23-4ada-b6a4-5d9a222d6dab', 'e009504b-0ae6-4c96-8ce6-e6c203e31ae1', 2, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・中途採用を実施中（営業職・経理職） ・勤務地：本社（神田・東京）、営業は横浜・大阪も募集 ・採用手法：エージェント、ダイレクトリクルーティング、リファラルを活用中 ・直近1ヶ月の推薦数（経理）：各社合計で約43名 ・営業職は「用地仕入れ営業」を募集。ピンポイント経験者の母集団形成に課題感あり ・今後、技術職（建築設計・施工管理）も募集検討中 ・テレアポ営業は実施中（地主向けアプローチ等） ・AI活用は現状未導入 ・社内手続き上、導入前にコンプラチェック・契約関連確認が必要  【課題】 ・用地仕入れ営業など専門性の高い人材の母集団形成が難航 ・推薦数は一定数あるが、より多くの候補者と接点を持ちたい意向 ・長期利用時の候補者重複や精度維持に懸念 ・新サービス導入時の社内コンプラ・契約確認フローが必要  【提案サービス】 ・AIハチドリAIエージェント（AI活用型・完全成果報酬型の人材紹介サービス）  【次回アクション】 ・先方へサービス資料を送付 ・先方より必要資料（会社情報・契約関連資料等）の指定を受領 ・当社にて資料準備・返送 ・今月中を目安に社内コンプラチェックおよび申込可否判断予定 ・不明点があれば随時連絡対応', NULL, NULL, NULL, '先方のコンプラチェック用の資料送付', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd26024f3-7716-4eaa-acc0-bbe61a27f4a5', '4caaf043-9272-416d-a109-d70f9ec11d5f', 1, '2026-02-17', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】  先方：ホテル青森（舟山様）。当方：リンク（樋上）  採用状況：新卒は「総合職」「調理」の2職種で募集。中途採用も年間通して継続（応募があれば随時面接）  採用チャネル：代理店経由で「engage」を利用。3月から「Indeed PLUS」を開始予定  応募・面接数感：月1〜2名程度（波あり）。職種も短時間・契約社員など複数  充足方針：4月に新卒入社がありつつ、中途採用も並行して進めたい  課題感：地元でホテル勤務希望者が主対象。首都圏等から移住してまで働く賃金水準ではなく、母集団形成が難しい（直近でダイレクトリクルーティングも試したが応募が伸びなかった）  採用コスト感（中途）：正確算出は難しいが、イメージとして1名あたり20〜30万円程度（ただし長期スパンで見た概算）  【課題】  成果報酬型（年収連動）の採用サービス利用実績がなく、社内判断のハードルが高い（費用が跳ね上がる懸念）  地方×賃金水準の制約により、「毎日/毎月一定数の紹介が本当に成立するのか」への疑問  3月からIndeed PLUS開始予定のため、現時点では新サービス検討の優先度が低い（まず既存施策の結果を見たい）  【提案サービス】  ハチドリAIエージェント（AI活用の人材紹介/エージェント型サービス）  合意/未合意：先方は「現時点で登録・導入は難しい」。人材の集め方（紹介会社DBからのピックアップ）については説明し理解  ハチドリHR（採用媒体の自動更新・応募一次対応等の採用支援ツール）  合意/未合意：代理店利用中の内容と近く、追加検討材料がなく現時点では見送り  【次回アクション】  当方：提案資料をメール送付  先方：3月開始のIndeed PLUS運用結果を踏まえ、厳しい状況と判断できたタイミングで再検討余地あり（必要時に連絡）  当方：不明点が出た場合の問い合わせ窓口としてフォロー継続', NULL, NULL, '他社NG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '64217f7f-9936-40a2-945e-cb903ff07534', '4caaf043-9272-416d-a109-d70f9ec11d5f', 2, '2026-02-17', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】  先方：ホテル青森（舟山様）。当方：リンク（樋上）  採用状況：新卒は「総合職」「調理」の2職種で募集。中途採用も年間通して継続（応募があれば随時面接）  採用チャネル：代理店経由で「engage」を利用。3月から「Indeed PLUS」を開始予定  応募・面接数感：月1〜2名程度（波あり）。職種も短時間・契約社員など複数  充足方針：4月に新卒入社がありつつ、中途採用も並行して進めたい  課題感：地元でホテル勤務希望者が主対象。首都圏等から移住してまで働く賃金水準ではなく、母集団形成が難しい（直近でダイレクトリクルーティングも試したが応募が伸びなかった）  採用コスト感（中途）：正確算出は難しいが、イメージとして1名あたり20〜30万円程度（ただし長期スパンで見た概算）  【課題】  成果報酬型（年収連動）の採用サービス利用実績がなく、社内判断のハードルが高い（費用が跳ね上がる懸念）  地方×賃金水準の制約により、「毎日/毎月一定数の紹介が本当に成立するのか」への疑問  3月からIndeed PLUS開始予定のため、現時点では新サービス検討の優先度が低い（まず既存施策の結果を見たい）  【提案サービス】  ハチドリAIエージェント（AI活用の人材紹介/エージェント型サービス）  合意/未合意：先方は「現時点で登録・導入は難しい」。人材の集め方（紹介会社DBからのピックアップ）については説明し理解  ハチドリHR（採用媒体の自動更新・応募一次対応等の採用支援ツール）  合意/未合意：代理店利用中の内容と近く、追加検討材料がなく現時点では見送り  【次回アクション】  当方：提案資料をメール送付  先方：3月開始のIndeed PLUS運用結果を踏まえ、厳しい状況と判断できたタイミングで再検討余地あり（必要時に連絡）  当方：不明点が出た場合の問い合わせ窓口としてフォロー継続', NULL, NULL, '他社NG', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '758a49e6-2fb6-4a9c-8b52-3001afbf3a04', '4ba7d3db-4a86-4ff3-a2af-aa4345776eaa', 1, '2026-02-26', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・クリーン社（コスメ事業） 平田カズヒロ氏 ・採用したい職種：①サロンカウンセラー ②美容営業（コンサルティング職）③SNSマーケター（優先度低め） ・採用エリア：福岡県中心（九州圏） ・採用手法：採用媒体が中心。マイナビで「サロンカウンセラー」のみエージェント活用を検討/進行中 ・過去に人材紹介を利用したが応募（紹介）が来ず、現在は積極活用していない ・営業活動（美容営業側）はテレアポではなく訪問・飛び込み中心  【課題】 ・特殊な営業スタイルのため、該当経験者（または準ずる人材）がどれくらい市場にいるかが見えず導入判断しにくい ・AI推薦でも求人票に100%合致する保証はない点を懸念（一般的な紹介会社同様という理解はある） ・毎日推薦が来ても、マッチしない候補が続くと面談対応の工数が増え疲弊する懸念 ・導入前に「福岡エリアにどの程度対象人材が存在するか」等、一定の事前情報（母数感/数値）が欲しい  【提案サービス】 ・ハチドリAIエージェント（AI活用の人材紹介サービス） ※成果報酬型・推薦を日次で行う運用（詳細条件は先方懸念のため深掘りせず）  【次回アクション】 ・現時点は見送り（導入判断に必要な母数データ/数値情報が提示できないため） ・提供側にて「対象人材の母数感（例：福岡で女性の営業経験者等）」など定量情報が用意でき次第、再提案する方針', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f62cdcc3-43ea-49c4-89c9-6cc8dc19f975', '4ba7d3db-4a86-4ff3-a2af-aa4345776eaa', 2, '2026-02-26', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・クリーン社（コスメ事業） 平田カズヒロ氏 ・採用したい職種：①サロンカウンセラー ②美容営業（コンサルティング職）③SNSマーケター（優先度低め） ・採用エリア：福岡県中心（九州圏） ・採用手法：採用媒体が中心。マイナビで「サロンカウンセラー」のみエージェント活用を検討/進行中 ・過去に人材紹介を利用したが応募（紹介）が来ず、現在は積極活用していない ・営業活動（美容営業側）はテレアポではなく訪問・飛び込み中心  【課題】 ・特殊な営業スタイルのため、該当経験者（または準ずる人材）がどれくらい市場にいるかが見えず導入判断しにくい ・AI推薦でも求人票に100%合致する保証はない点を懸念（一般的な紹介会社同様という理解はある） ・毎日推薦が来ても、マッチしない候補が続くと面談対応の工数が増え疲弊する懸念 ・導入前に「福岡エリアにどの程度対象人材が存在するか」等、一定の事前情報（母数感/数値）が欲しい  【提案サービス】 ・ハチドリAIエージェント（AI活用の人材紹介サービス） ※成果報酬型・推薦を日次で行う運用（詳細条件は先方懸念のため深掘りせず）  【次回アクション】 ・現時点は見送り（導入判断に必要な母数データ/数値情報が提示できないため） ・提供側にて「対象人材の母数感（例：福岡で女性の営業経験者等）」など定量情報が用意でき次第、再提案する方針', NULL, NULL, '使いこなせない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9282f73f-df38-4386-99cb-c3a9c339af3b', '627ba0f4-7298-4793-8dfa-afcb04818951', 1, '2026-02-16', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・募集職種：営業（賃貸仲介／100％反響型、新規開拓・テレアポなし） ・勤務地：東京・埼玉 ・現在の採用手法：マイナビ掲載＋複数の人材紹介会社を利用 ・人材紹介からの推薦数：月3～10名程度（時期・会社により変動） ・担当者は新卒採用メイン（中途は別担当の可能性あり） ・中途採用は実施中 ・LINE対応は既に専門部署あり（自動化ニーズなし） ・採用媒体更新は手間はあるが、差別化要素としてあえて自社で工夫している  【課題】 ・人材紹介の供給数に波がある（月3～10名と変動） ・中途営業職の継続採用が必要 ・紹介人材の母集団規模・重複可否・長期安定供給に関心あり ・返金規定の有無など契約条件を確認したい意向  【提案サービス】 ・ハチドリAIエージェント（AI活用型・完全成果報酬型人材紹介サービス） ・採用媒体自動更新AIツール（採用業務自動化サービス）  ※関心は主に「ハチドリAIエージェント」にあり。媒体更新ツールは現時点で優先度低。  【次回アクション】 ・営業より資料をメール送付 ・社内展開後、週明けに一次回答予定 ・導入可否の判断後、申込フォーム送付可  【温度感】 ・価格インパクトには関心あり ・紹介人数の持続性・重複有無に慎重姿勢 ・前向き検討だが即決ではなく社内確認フェーズ', NULL, NULL, '他社NG', '検討結果', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd6259617-73e1-4b7b-aed9-edd9517c8b77', '627ba0f4-7298-4793-8dfa-afcb04818951', 2, '2026-02-16', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・募集職種：営業（賃貸仲介／100％反響型、新規開拓・テレアポなし） ・勤務地：東京・埼玉 ・現在の採用手法：マイナビ掲載＋複数の人材紹介会社を利用 ・人材紹介からの推薦数：月3～10名程度（時期・会社により変動） ・担当者は新卒採用メイン（中途は別担当の可能性あり） ・中途採用は実施中 ・LINE対応は既に専門部署あり（自動化ニーズなし） ・採用媒体更新は手間はあるが、差別化要素としてあえて自社で工夫している  【課題】 ・人材紹介の供給数に波がある（月3～10名と変動） ・中途営業職の継続採用が必要 ・紹介人材の母集団規模・重複可否・長期安定供給に関心あり ・返金規定の有無など契約条件を確認したい意向  【提案サービス】 ・ハチドリAIエージェント（AI活用型・完全成果報酬型人材紹介サービス） ・採用媒体自動更新AIツール（採用業務自動化サービス）  ※関心は主に「ハチドリAIエージェント」にあり。媒体更新ツールは現時点で優先度低。  【次回アクション】 ・営業より資料をメール送付 ・社内展開後、週明けに一次回答予定 ・導入可否の判断後、申込フォーム送付可  【温度感】 ・価格インパクトには関心あり ・紹介人数の持続性・重複有無に慎重姿勢 ・前向き検討だが即決ではなく社内確認フェーズ', NULL, NULL, '他社NG', '検討結果', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'c6f02acd-89e3-40ad-bf23-44f3ebc420ae', '28de453b-fc65-43ca-a66a-bd9bc9f1dd0b', 1, '2026-02-10', '00000000-0000-0000-0000-000000000002', '代理店A', 'LINEでやりとり  【ヒアリング内容】  先方（樫井氏）はフランチャイズ本部の構築支援も行うが、主業は「加盟店開発（加盟店募集の営業代行）」。  業界課題：従来のフランチャイズ募集媒体（例：募集サイト）中心の集客は、SNS等の手法分散により以前ほどリードが取れず、商談の質も低下傾向。  現状の主なリード獲得はフランチャイズ募集系Webサイト経由の「資料請求」が中心。  一部フランチャイズでは「経営者紹介/ビジネスマッチング系」経由で契約が取れるケースがあるが、他案件に横展開すると成果が出ない。  テレアポは過去に試したが、空アポ・無断キャンセル等もあり効果が薄い印象。フランチャイズはプッシュ型営業がそもそも向きにくい認識。  先方の募集ターゲットは「個人の独立開業」より「法人（会社の新規事業としての参入）」が中心。経営者/決裁者にアプローチしたい。  【課題】  リード獲得チャネルが分散し、従来媒体に投資してもリード数・質が落ちている。  フランチャイズ加盟募集はアウトバウンド（電話）と相性が悪く、実行しても質担保が難しい懸念。  法人決裁者へ効率的に接触し、商談化する新しい打ち手が不足。  【提案サービス】  フォーム営業AI（営業フォーム送信の自動化／リスト作成〜送信をAIで自律実行するパッケージの一部）  AIテレアポ（一次対応・受付突破までをAIで代行する架電サービス）※ただしフランチャイズ加盟募集用途は適合性が低そうとの認識で双方一致  パートナー制度（紹介〜トスアップ/商談設定、または口頭受注までの支援で報酬が発生する提携スキーム）  （補足で言及）LINE対応自動化系、採用系サービス（ハチドリエーアイ：人材紹介系）※先方の優先は加盟店開発リード獲得  【次回アクション】  当社：提案資料をLINEで送付（先方希望）。あわせてパートナー登録用のGoogleフォームも送付。  先方：支援中のフランチャイズ本部へ「フォーム営業AI」の導入/試験利用を提案し、関心・予算感を確認する。  当社：先方から導入候補が出た段階で、条件面（初期費用の減額/無料可否など）は社内確認の上で再調整・再提案する。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '73dff5ae-34ee-42e2-b6a8-5c655fff734f', '28de453b-fc65-43ca-a66a-bd9bc9f1dd0b', 2, '2026-02-10', '00000000-0000-0000-0000-000000000002', '代理店A', 'LINEでやりとり  【ヒアリング内容】  先方（樫井氏）はフランチャイズ本部の構築支援も行うが、主業は「加盟店開発（加盟店募集の営業代行）」。  業界課題：従来のフランチャイズ募集媒体（例：募集サイト）中心の集客は、SNS等の手法分散により以前ほどリードが取れず、商談の質も低下傾向。  現状の主なリード獲得はフランチャイズ募集系Webサイト経由の「資料請求」が中心。  一部フランチャイズでは「経営者紹介/ビジネスマッチング系」経由で契約が取れるケースがあるが、他案件に横展開すると成果が出ない。  テレアポは過去に試したが、空アポ・無断キャンセル等もあり効果が薄い印象。フランチャイズはプッシュ型営業がそもそも向きにくい認識。  先方の募集ターゲットは「個人の独立開業」より「法人（会社の新規事業としての参入）」が中心。経営者/決裁者にアプローチしたい。  【課題】  リード獲得チャネルが分散し、従来媒体に投資してもリード数・質が落ちている。  フランチャイズ加盟募集はアウトバウンド（電話）と相性が悪く、実行しても質担保が難しい懸念。  法人決裁者へ効率的に接触し、商談化する新しい打ち手が不足。  【提案サービス】  フォーム営業AI（営業フォーム送信の自動化／リスト作成〜送信をAIで自律実行するパッケージの一部）  AIテレアポ（一次対応・受付突破までをAIで代行する架電サービス）※ただしフランチャイズ加盟募集用途は適合性が低そうとの認識で双方一致  パートナー制度（紹介〜トスアップ/商談設定、または口頭受注までの支援で報酬が発生する提携スキーム）  （補足で言及）LINE対応自動化系、採用系サービス（ハチドリエーアイ：人材紹介系）※先方の優先は加盟店開発リード獲得  【次回アクション】  当社：提案資料をLINEで送付（先方希望）。あわせてパートナー登録用のGoogleフォームも送付。  先方：支援中のフランチャイズ本部へ「フォーム営業AI」の導入/試験利用を提案し、関心・予算感を確認する。  当社：先方から導入候補が出た段階で、条件面（初期費用の減額/無料可否など）は社内確認の上で再調整・再提案する。', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '96a52aaf-5a40-4931-8290-4a12697659f7', 'a6d3e525-21c8-4b69-9bf4-a88a10fdaf7e', 1, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'A', 'フォームAIで契約合意 改めてクレジット決済の案内を行い、契約となる', NULL, NULL, NULL, '回収', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6a0df10f-2e3f-4a3b-839e-f928b56bcc70', 'a6d3e525-21c8-4b69-9bf4-a88a10fdaf7e', 2, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  株式会社style　宮野様  ① 基本情報  会社名：株式会社style  担当者名：宮野様  メールアドレス：miyano@styleinc.co.jp  電話番号：090-5761-0011  ② 現在の営業施策状況 ■ フォーム営業  すでに外部企業へ依頼実施中（成果報酬型）  送信数：不明（推定 約70,000件規模）  アポイント獲得数：  平均：約10～15件  最大：約20件前後  ■ 成果報酬条件  アポイント日程確定ベース  1アポあたり：約1,700円  10件獲得時：約17,000円規模  → 低単価・反響前提型のスキームで運用  ■ テレアポ施策  テレアポ代行も並行依頼中  フォーム営業＋電話のハイブリッド体制  ③ 数値管理・運用体制  手前のKPI数値を見ながら運用調整  完全成果報酬型での外注管理  費用リスクを抑えたテスト運用フェーズ  ④ フォームAIに対する反応 ■ 興味関心度  内容的には「使ってみたい」と前向き  導入メリットは理解済み  既存の外注フォーム営業との比較検討フェーズ  ⑤ 提案条件（提示済）  初期費用：5万円  月額費用：5万円  → トライアル導入しやすい価格設計で提示  ⑥ ネクストアクション  フォーム営業資料をメール送付  送付内容：  サービス概要資料  成果イメージ  送信数・反響率目安  他社比較  導入フロー  ⑦ スケジュール  1週間後を目安に先方より連絡予定  資料確認後に最終判断  ⑧ 受注確度  確度：中〜高  理由：  価格合意済  興味関心高い  既存施策あり → 比較判断しやすい  「使ってみたい」発言あり', NULL, NULL, NULL, '検討状況確認', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'fe49de35-9519-4a58-931a-51e99989a944', 'a6d3e525-21c8-4b69-9bf4-a88a10fdaf7e', 3, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'A', 'フォームAIで契約合意 改めてクレジット決済の案内を行い、契約となる', NULL, NULL, NULL, '回収', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a356447d-15c1-4e08-827e-ace7f670c954', '4094ae98-3a4b-4b95-966d-9adca1877a70', 1, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 次回商談で、採用の話も提携の文脈で行う 企業名：㈱gifts 代表取締役：佐藤 雄大 様  ① 商談背景・現状  現在、問い合わせフォーム営業は社内人員で手動送信を実施  送信工数・リソース負担が大きく、自動化・効率化の必要性を認識  新規開拓手法として、フォーム営業の強化を検討中  ② 提案サービス 1. フォーム営業AI（フォームAI）  フォーム送信の自動化  リストに対する一斉アプローチ  送信ログ・反響管理の可視化  手動送信からの工数削減  提示条件  初期費用：5万円  導入予定時期：2月検討  2. AIテレアポ  フォーム営業と並行した新規開拓チャネルとして提案  リード獲得最大化のための多面接触設計  フォーム×コールのハイブリッド営業モデル  ※現時点ではフォームAI優先度が高い状況  ③ クライアント関心領域・拡張可能性 ① 採用領域  フォーム営業の活用を採用母集団形成にも転用検討  企業アプローチ／求人訴求などで活用余地あり  ② 既存事業とのシナジー  求人媒体の更新代行事業を実施中  求人企業への営業・代理店開拓にもフォームAI活用余地  想定活用例：  求人掲載企業への営業  採用支援サービスの提案送信  代理店・提携先開拓  ④ 導入検討ステータス  フォームAI：導入前向き検討  費用感：初期5万円で提示済  導入時期：2月想定  社内検討フェーズ  ⑤ 次回アクション  来週〜再来週で再提案予定  導入可否判断の最終確認  想定議題：  実運用フロー整理  送信対象リスト確認  文面テンプレ設計  KPI設計（送信数／返信率）  採用活用モデル提示  ⑥ 提案深化余地（次回提案布石）  次回商談では下記を提示すると受注確度向上見込み：  手動送信 vs AI送信 工数比較  反響率シミュレーション  採用活用ユースケース  求人媒体更新代行との連携モデル  フォーム＋AIテレアポ統合設計', NULL, NULL, NULL, '検討状況確認', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'b8935b2a-429b-445f-b20e-d6420ee5235a', '4094ae98-3a4b-4b95-966d-9adca1877a70', 2, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 次回商談で、採用の話も提携の文脈で行う 企業名：㈱gifts 代表取締役：佐藤 雄大 様  ① 商談背景・現状  現在、問い合わせフォーム営業は社内人員で手動送信を実施  送信工数・リソース負担が大きく、自動化・効率化の必要性を認識  新規開拓手法として、フォーム営業の強化を検討中  ② 提案サービス 1. フォーム営業AI（フォームAI）  フォーム送信の自動化  リストに対する一斉アプローチ  送信ログ・反響管理の可視化  手動送信からの工数削減  提示条件  初期費用：5万円  導入予定時期：2月検討  2. AIテレアポ  フォーム営業と並行した新規開拓チャネルとして提案  リード獲得最大化のための多面接触設計  フォーム×コールのハイブリッド営業モデル  ※現時点ではフォームAI優先度が高い状況  ③ クライアント関心領域・拡張可能性 ① 採用領域  フォーム営業の活用を採用母集団形成にも転用検討  企業アプローチ／求人訴求などで活用余地あり  ② 既存事業とのシナジー  求人媒体の更新代行事業を実施中  求人企業への営業・代理店開拓にもフォームAI活用余地  想定活用例：  求人掲載企業への営業  採用支援サービスの提案送信  代理店・提携先開拓  ④ 導入検討ステータス  フォームAI：導入前向き検討  費用感：初期5万円で提示済  導入時期：2月想定  社内検討フェーズ  ⑤ 次回アクション  来週〜再来週で再提案予定  導入可否判断の最終確認  想定議題：  実運用フロー整理  送信対象リスト確認  文面テンプレ設計  KPI設計（送信数／返信率）  採用活用モデル提示  ⑥ 提案深化余地（次回提案布石）  次回商談では下記を提示すると受注確度向上見込み：  手動送信 vs AI送信 工数比較  反響率シミュレーション  採用活用ユースケース  求人媒体更新代行との連携モデル  フォーム＋AIテレアポ統合設計', NULL, NULL, NULL, '検討状況確認', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0f2b49cd-75b1-487d-a656-3b3e5091a6d8', 'b8b23ca7-7a44-4732-950f-abb0660da7a8', 1, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  R&C株式会社　藤方様  1. 商談概要  担当者：藤方様  会社名：R&C株式会社  商談状況：初回ヒアリング完了 → 次回具体提案フェーズ  検討サービス：  AIテレアポ  Lシンク  最終的に上記2サービスの導入可否を軸に検討したい意向で商談終了。  2. 現状の事業・組織体制  営業人員：約400名規模  雇用形態：社員ではなく業務委託・契約形態中心  ビジネスモデル：レベニューシェア型が主軸  今後構想：営業人員を1,000名規模まで拡大予定  3. 現在抱えている主要課題 ① 契約管理・ガバナンス  人数増加に伴い管理負荷が急増  社員ではないため統制が効きづらい  契約状況の把握・更新管理が煩雑  主な論点  契約締結状況の可視化  契約更新・失効管理  個別契約条件の把握  ② コンプライアンス対応  保険業界特有のコンプラ要件あり  営業品質の統制が重要  下位層の管理レベルに依存している状態  懸念点  説明義務違反  不適切募集  記録不備  ③ 営業管理・自己管理依存  基本は自己管理型  組織的なマネジメントは限定的  営業活動のプロセス管理が弱い  ④ 契約水準・生活維持ライン  「生活していける契約数」を基準に稼働  個々の売上・契約の安定性に課題  4. 将来構想・投資スタンス ■ システム開発  レベニューシェア型での共同開発に関心あり  良いプロダクトができた場合：  自社利用に留まらず  外販・販売展開も視野  ■ 組織拡大  営業 400名 → 1,000名構想  そのための管理基盤整備が必須  5. サービス検討状況 ① AIテレアポ  関心ポイント  新規開拓効率化  営業人員増加に対する案件供給  安定的な商談創出  ② Lシンク  関心ポイント  営業管理  契約管理  KPI可視化  組織統制  特に以下との親和性が高い：  業務委託営業管理  ガバナンス強化  コンプラ対応ログ  6. 導入検討ステータス  2サービスともに前向き検討  興味関心度：高  導入判断：事例・具体設計次第  7. 次回提案に向けた要求事項 ■ 必須提出情報  他保険会社での導入事例（詳細）  求められている粒度：  導入前課題  導入プロセス  活用方法  KPI改善数値  管理体制変化  コンプラ改善効果  ※抽象事例ではなく実運用レベルが必要  8. 次回商談方針  担当者：商談参加可能  フェーズ：具体提案・設計説明  ゴール：  導入判断材料提供  スモールスタート設計  費用対効果明示', NULL, NULL, NULL, '検討状況確認　際商談訴求', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '91ff8549-4e00-403f-8ac4-69fa630af369', 'b8b23ca7-7a44-4732-950f-abb0660da7a8', 2, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  R&C株式会社　藤方様  1. 商談概要  担当者：藤方様  会社名：R&C株式会社  商談状況：初回ヒアリング完了 → 次回具体提案フェーズ  検討サービス：  AIテレアポ  Lシンク  最終的に上記2サービスの導入可否を軸に検討したい意向で商談終了。  2. 現状の事業・組織体制  営業人員：約400名規模  雇用形態：社員ではなく業務委託・契約形態中心  ビジネスモデル：レベニューシェア型が主軸  今後構想：営業人員を1,000名規模まで拡大予定  3. 現在抱えている主要課題 ① 契約管理・ガバナンス  人数増加に伴い管理負荷が急増  社員ではないため統制が効きづらい  契約状況の把握・更新管理が煩雑  主な論点  契約締結状況の可視化  契約更新・失効管理  個別契約条件の把握  ② コンプライアンス対応  保険業界特有のコンプラ要件あり  営業品質の統制が重要  下位層の管理レベルに依存している状態  懸念点  説明義務違反  不適切募集  記録不備  ③ 営業管理・自己管理依存  基本は自己管理型  組織的なマネジメントは限定的  営業活動のプロセス管理が弱い  ④ 契約水準・生活維持ライン  「生活していける契約数」を基準に稼働  個々の売上・契約の安定性に課題  4. 将来構想・投資スタンス ■ システム開発  レベニューシェア型での共同開発に関心あり  良いプロダクトができた場合：  自社利用に留まらず  外販・販売展開も視野  ■ 組織拡大  営業 400名 → 1,000名構想  そのための管理基盤整備が必須  5. サービス検討状況 ① AIテレアポ  関心ポイント  新規開拓効率化  営業人員増加に対する案件供給  安定的な商談創出  ② Lシンク  関心ポイント  営業管理  契約管理  KPI可視化  組織統制  特に以下との親和性が高い：  業務委託営業管理  ガバナンス強化  コンプラ対応ログ  6. 導入検討ステータス  2サービスともに前向き検討  興味関心度：高  導入判断：事例・具体設計次第  7. 次回提案に向けた要求事項 ■ 必須提出情報  他保険会社での導入事例（詳細）  求められている粒度：  導入前課題  導入プロセス  活用方法  KPI改善数値  管理体制変化  コンプラ改善効果  ※抽象事例ではなく実運用レベルが必要  8. 次回商談方針  担当者：商談参加可能  フェーズ：具体提案・設計説明  ゴール：  導入判断材料提供  スモールスタート設計  費用対効果明示', NULL, NULL, NULL, '検討状況確認　際商談訴求', '2026-02-17'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f808aced-1446-4bb8-8033-e90a7b6946a0', 'b16e02ea-032d-4e1f-97ca-46aa9672e64f', 1, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '営業責任者の方 Lシンク・採用のの話はしていく 各班してもらうことが目的 上記ライトアップ  下記はライトアップではできない バックオフィスの方がやらない 録音のリストバンド 音声KPI管理  商談議事録：AI実装および共同販売（OEM）に向けた協議 1. 参加者および目的 * 参加者     * 株式会社ソロボッティリンク: 小貫氏（AI商社・開発）     * 株式会社ライトアップ: 杉山氏（役員）、菅野氏、白石氏（AI事業管掌）     * ホリフードサービス / 関連グループ: 堀江氏（代表）、鈴木氏（CFO）、石野氏（総務・管理部長）     * 仲介: 高橋氏 * 目的: 堀江氏が経営する営業会社および飲食店グループへのAI実装と、その成功実績をパッケージ化して他社へ展開する共同ビジネスモデルの構築。  2. 現状の課題と堀江氏の経営方針 * 社内格差の是正: AIを使いこなす社員と、未だに手作業（メール・資料作成等）に時間をかける社員の格差を解消し、業務効率を劇的に向上させたい。 * 危機感の共有: 若い世代の圧倒的なAI活用スピードに対し、従来のやり方に固執する組織文化への強い危機感。 * 現場の構造的負担: トップ営業マンほど顧客対応に追われ、新規営業に注力できない。 飲食店の現場ではITリテラシーが高くないため、複雑な操作は定着しない。 * 「座組み」重視: 機能の優劣以上に、日常業務の動線（レジ操作やLINE返信等）にAIが自動的に組み込まれている「勝手に自動化される状態」を最優先する。  3. 具体的な提案・協議内容 ① 業務フローの「AIエージェント化」 * 個別のツール利用ではなく、リスト作成から商談資料作成、顧客フォローまでを一貫して自動化する仕組み。 * ライトアップ社のM&A仲介における自動化事例（リスト作成〜資料作成の工数削減）を横展開。 ② 営業マンの「コピーAI」活用（Lシンク連携） * 公式LINEへの実装: 営業マン個人の「分身」を公式LINEに構築し、よくある質問への即時回答や一次対応を24時間自動化。 * 営業効率の極大化: 返信漏れによるクレームを防ぎ、営業マンがコア業務（クロージング等）に専念できる環境を作る。 * 顧客分析: AIが会話からニーズを抽出し、自動でタグ付けしてCRM（顧客管理システム）へ反映。 ③ 飲食店・バックオフィスの自動化 * 飲食店支援: 求人票の自動作成・更新、MEO（Googleマップ対策）の口コミ返信代行など。 * 管理部門のDX: 請求書のデータ化（OCR）や、バラバラな既存システム間を埋める自動化フローの構築。 ④ ビジネス展開（OEM構想） * 堀江氏の会社を「実験台」とし、導入による工数削減や売上向上を定量的にデータ化する。 * その実績を武器に、堀江氏が持つ10万店舗の飲食店ネットワークや中堅企業向けに共同で販売していく。  4. 次回アクション（アクションプラン） アクション項目        担当者        期限 営業部門との詳細ヒアリング: Top営業マンを交え、LINE活用や商談分析のデモ・要件定義を実施        小貫氏、白石氏        次回MTG 管理部門の業務精査: 既存システム構成を確認し、AI化・自動化が可能な「隙間業務」を特定        鈴木氏、石野氏        随時 個別連絡ラインの開設: 高橋氏を介し、堀江氏・小貫氏間で具体的な進め方を直接協議        高橋氏、堀江氏        直近 Top営業マンのナレッジ抽出: コピーAI構築のため、トップ層の商談ログや口癖のデータを精査        小貫氏、堀江氏側営業担当        次回以降', NULL, NULL, NULL, '際商談調整', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '734c3e92-24c6-4d74-af66-2ffd84962aa8', 'b16e02ea-032d-4e1f-97ca-46aa9672e64f', 2, '2026-02-10', '00000000-0000-0000-0000-000000000001', 'C', '営業責任者の方 Lシンク・採用のの話はしていく 各班してもらうことが目的 上記ライトアップ  下記はライトアップではできない バックオフィスの方がやらない 録音のリストバンド 音声KPI管理  商談議事録：AI実装および共同販売（OEM）に向けた協議 1. 参加者および目的 * 参加者     * 株式会社ソロボッティリンク: 小貫氏（AI商社・開発）     * 株式会社ライトアップ: 杉山氏（役員）、菅野氏、白石氏（AI事業管掌）     * ホリフードサービス / 関連グループ: 堀江氏（代表）、鈴木氏（CFO）、石野氏（総務・管理部長）     * 仲介: 高橋氏 * 目的: 堀江氏が経営する営業会社および飲食店グループへのAI実装と、その成功実績をパッケージ化して他社へ展開する共同ビジネスモデルの構築。  2. 現状の課題と堀江氏の経営方針 * 社内格差の是正: AIを使いこなす社員と、未だに手作業（メール・資料作成等）に時間をかける社員の格差を解消し、業務効率を劇的に向上させたい。 * 危機感の共有: 若い世代の圧倒的なAI活用スピードに対し、従来のやり方に固執する組織文化への強い危機感。 * 現場の構造的負担: トップ営業マンほど顧客対応に追われ、新規営業に注力できない。 飲食店の現場ではITリテラシーが高くないため、複雑な操作は定着しない。 * 「座組み」重視: 機能の優劣以上に、日常業務の動線（レジ操作やLINE返信等）にAIが自動的に組み込まれている「勝手に自動化される状態」を最優先する。  3. 具体的な提案・協議内容 ① 業務フローの「AIエージェント化」 * 個別のツール利用ではなく、リスト作成から商談資料作成、顧客フォローまでを一貫して自動化する仕組み。 * ライトアップ社のM&A仲介における自動化事例（リスト作成〜資料作成の工数削減）を横展開。 ② 営業マンの「コピーAI」活用（Lシンク連携） * 公式LINEへの実装: 営業マン個人の「分身」を公式LINEに構築し、よくある質問への即時回答や一次対応を24時間自動化。 * 営業効率の極大化: 返信漏れによるクレームを防ぎ、営業マンがコア業務（クロージング等）に専念できる環境を作る。 * 顧客分析: AIが会話からニーズを抽出し、自動でタグ付けしてCRM（顧客管理システム）へ反映。 ③ 飲食店・バックオフィスの自動化 * 飲食店支援: 求人票の自動作成・更新、MEO（Googleマップ対策）の口コミ返信代行など。 * 管理部門のDX: 請求書のデータ化（OCR）や、バラバラな既存システム間を埋める自動化フローの構築。 ④ ビジネス展開（OEM構想） * 堀江氏の会社を「実験台」とし、導入による工数削減や売上向上を定量的にデータ化する。 * その実績を武器に、堀江氏が持つ10万店舗の飲食店ネットワークや中堅企業向けに共同で販売していく。  4. 次回アクション（アクションプラン） アクション項目        担当者        期限 営業部門との詳細ヒアリング: Top営業マンを交え、LINE活用や商談分析のデモ・要件定義を実施        小貫氏、白石氏        次回MTG 管理部門の業務精査: 既存システム構成を確認し、AI化・自動化が可能な「隙間業務」を特定        鈴木氏、石野氏        随時 個別連絡ラインの開設: 高橋氏を介し、堀江氏・小貫氏間で具体的な進め方を直接協議        高橋氏、堀江氏        直近 Top営業マンのナレッジ抽出: コピーAI構築のため、トップ層の商談ログや口癖のデータを精査        小貫氏、堀江氏側営業担当        次回以降', NULL, NULL, NULL, '際商談調整', '2026-02-11'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6e04acc0-dff9-4641-a4c1-39fe52170edf', 'c73e8e3f-d603-443e-9de0-926f8ee09281', 1, '2026-02-12', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】  先方：（共豊）竹中様。1人で事業運営（昨年立ち上げ）  きっかけ：2/10頃に別経由で紹介（「営業関連で良い会社がある」との流れで面談）  先方事業：サジェスト対策（ネガティブワード削除ではなく、検索段階でプロモーションを行い“指名検索に近い状態”を作る趣旨）。料金は完全成果報酬で「表示されたら1日3,000円」等の形（最大で月9万円程度のイメージ）  新規開拓の現状：  営業代行（テレアポ）を一部利用しリード獲得  交流会参加→紹介経由の面談も多い  代行実績：月中時点で約5アポ、架電数は約400コール/月、費用は約10万円/月  リードは「もう少し増やしたい」一方、現代行は成果に疑問も出ており、別手法を情報収集中（契約期間は残あり）  追加の費用投下は「なるべくしたくない」意向  【課題】  新規開拓の獲得件数を伸ばしたいが、現行テレアポ代行の質・成果に不安  競合が多い領域で、リスティング広告は入札単価高騰・大手優位になりやすく、費用対効果が合いにくい（先方の顧客課題としても多い）  提案を複数受けており、各サービスの差分が分かりづらい（単価比較だけでは判断できない）  商談進行面：当方からの提案中心になり、先方は「自社サービスの深掘り（要件確認）をしてから合う提案が欲しい」とフィードバック  【提案サービス】  フォーム営業AI（フォーム送信自動化/新規開拓支援ツール）  月額5万円、送信10,000件等の説明。今月導入なら初期費用0円・契約縛りなしで1ヶ月試用可の提示あり  先方は類似サービス情報あり（0.05円/件・大量送信等の別サービスを聞いており、差分が不明）  トスアップ支援サービス（紹介型/成果報酬のアポ獲得支援）  交流会コミュニティ起点でニーズに合う企業紹介、決裁者アポ単価設定の説明  先方は同様の成果報酬提案を他社からも受けており、差別化が見えにくい反応  （参考）AI営業代行（AI活用で架電数増の代行）  月額50万円/5,000コール等の説明。ただし先方の費用感とはギャップあり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '1821728d-fad4-41a5-b58c-d2cc68ae7d22', 'c73e8e3f-d603-443e-9de0-926f8ee09281', 2, '2026-02-12', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】  先方：（共豊）竹中様。1人で事業運営（昨年立ち上げ）  きっかけ：2/10頃に別経由で紹介（「営業関連で良い会社がある」との流れで面談）  先方事業：サジェスト対策（ネガティブワード削除ではなく、検索段階でプロモーションを行い“指名検索に近い状態”を作る趣旨）。料金は完全成果報酬で「表示されたら1日3,000円」等の形（最大で月9万円程度のイメージ）  新規開拓の現状：  営業代行（テレアポ）を一部利用しリード獲得  交流会参加→紹介経由の面談も多い  代行実績：月中時点で約5アポ、架電数は約400コール/月、費用は約10万円/月  リードは「もう少し増やしたい」一方、現代行は成果に疑問も出ており、別手法を情報収集中（契約期間は残あり）  追加の費用投下は「なるべくしたくない」意向  【課題】  新規開拓の獲得件数を伸ばしたいが、現行テレアポ代行の質・成果に不安  競合が多い領域で、リスティング広告は入札単価高騰・大手優位になりやすく、費用対効果が合いにくい（先方の顧客課題としても多い）  提案を複数受けており、各サービスの差分が分かりづらい（単価比較だけでは判断できない）  商談進行面：当方からの提案中心になり、先方は「自社サービスの深掘り（要件確認）をしてから合う提案が欲しい」とフィードバック  【提案サービス】  フォーム営業AI（フォーム送信自動化/新規開拓支援ツール）  月額5万円、送信10,000件等の説明。今月導入なら初期費用0円・契約縛りなしで1ヶ月試用可の提示あり  先方は類似サービス情報あり（0.05円/件・大量送信等の別サービスを聞いており、差分が不明）  トスアップ支援サービス（紹介型/成果報酬のアポ獲得支援）  交流会コミュニティ起点でニーズに合う企業紹介、決裁者アポ単価設定の説明  先方は同様の成果報酬提案を他社からも受けており、差別化が見えにくい反応  （参考）AI営業代行（AI活用で架電数増の代行）  月額50万円/5,000コール等の説明。ただし先方の費用感とはギャップあり', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '121814fd-1389-4758-9d5e-bc008835f84a', 'bc2f679f-65dd-4e99-8670-508d275e3707', 1, '2026-02-19', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】   オークス社の採用状況   新卒：セレモニー職／営業職／（窓口として総務も設置しているが、基本はセレモニー配属想定が強い）   中途：現在は「インディード」中心     採用チャネル   新卒：マイナビ中心＋アウトソーシング利用、スカウト型も1つ利用   中途：インディード一本（現状）     営業職の内容   以前の個別訪問型（飛び込み）ではなく、現在はイベント企画運営で地域接点を作る活動＋葬儀後のアフターフォローが中心     提案サービスへの主な確認事項（顧客側の関心）   完全成功報酬でランニングコストなしであることの確認   成功報酬の算定範囲：年収の定義（基本給のみ／賞与なし／インセンティブや各種手当、交通費・家族手当・技術手当などは対象外）   対象雇用形態：正社員のみ（パートは対象外）   早期退職時の補填：なし   富山×冠婚葬祭（葬儀）まで絞ると母数が減る懸念（どれくらい紹介可能かのイメージを確認）   連携する人材紹介会社の数や内訳：提携先が約30社程度、一覧の提示可否を確認     【課題】   中途採用は現状インディード中心で、紹介型（エージェント活用）での母集団拡大・推薦獲得の選択肢を検討中   富山県×葬儀領域まで条件を絞ると候補者母数が小さくなる懸念があり、紹介数・マッチング精度に不安   料金面は相場（30〜35%）より低いものの、27%からの価格交渉余地は小さそうで、費用対効果の見極めが必要   早期退職時の返金/補填がない点はリスクとして認識されうる   【提案サービス】   ハチドリAIエージェント（中途採用向け／AIによる人材紹介・推薦支援サービス）   【次回アクション】   営業側：サービス資料をメール送付（提携人材紹介会社の一覧も要望があれば提示）   顧客側：資料を社内（各セクション）に回覧し、急ぎで人員拡充が必要な部門があるか含めて検討   顧客側→営業側：導入を進める場合は連絡（申込フォーム送付→求人票共有→推薦開始の流れ）', NULL, NULL, NULL, '検討状況確認', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '00d40258-c881-4333-be54-121fcbd4fee1', 'bc2f679f-65dd-4e99-8670-508d275e3707', 2, '2026-02-19', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】   オークス社の採用状況   新卒：セレモニー職／営業職／（窓口として総務も設置しているが、基本はセレモニー配属想定が強い）   中途：現在は「インディード」中心     採用チャネル   新卒：マイナビ中心＋アウトソーシング利用、スカウト型も1つ利用   中途：インディード一本（現状）     営業職の内容   以前の個別訪問型（飛び込み）ではなく、現在はイベント企画運営で地域接点を作る活動＋葬儀後のアフターフォローが中心     提案サービスへの主な確認事項（顧客側の関心）   完全成功報酬でランニングコストなしであることの確認   成功報酬の算定範囲：年収の定義（基本給のみ／賞与なし／インセンティブや各種手当、交通費・家族手当・技術手当などは対象外）   対象雇用形態：正社員のみ（パートは対象外）   早期退職時の補填：なし   富山×冠婚葬祭（葬儀）まで絞ると母数が減る懸念（どれくらい紹介可能かのイメージを確認）   連携する人材紹介会社の数や内訳：提携先が約30社程度、一覧の提示可否を確認     【課題】   中途採用は現状インディード中心で、紹介型（エージェント活用）での母集団拡大・推薦獲得の選択肢を検討中   富山県×葬儀領域まで条件を絞ると候補者母数が小さくなる懸念があり、紹介数・マッチング精度に不安   料金面は相場（30〜35%）より低いものの、27%からの価格交渉余地は小さそうで、費用対効果の見極めが必要   早期退職時の返金/補填がない点はリスクとして認識されうる   【提案サービス】   ハチドリAIエージェント（中途採用向け／AIによる人材紹介・推薦支援サービス）   【次回アクション】   営業側：サービス資料をメール送付（提携人材紹介会社の一覧も要望があれば提示）   顧客側：資料を社内（各セクション）に回覧し、急ぎで人員拡充が必要な部門があるか含めて検討   顧客側→営業側：導入を進める場合は連絡（申込フォーム送付→求人票共有→推薦開始の流れ）', NULL, NULL, NULL, '検討状況確認', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '5b46fe76-ef2b-412f-9fac-d0d1739c0d12', '29a0ca40-21c0-42d9-9e40-88998d02b133', 1, '2026-02-16', '00000000-0000-0000-0000-000000000001', '失注', '新卒向けで現在獲得を行っている状況のため、 ハチドリエージェントが新卒の人が多いプラットフォームであれば、27%で大丈夫だと思うが、自社が60万円で確得している状況のため、導入が難しいのではないかという状況', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a82a39df-d789-47ce-ac65-4d63ec27d91b', '29a0ca40-21c0-42d9-9e40-88998d02b133', 2, '2026-02-16', '00000000-0000-0000-0000-000000000001', '失注', '新卒向けで現在獲得を行っている状況のため、 ハチドリエージェントが新卒の人が多いプラットフォームであれば、27%で大丈夫だと思うが、自社が60万円で確得している状況のため、導入が難しいのではないかという状況', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '35e09efe-ea48-462a-af1b-1998572828d9', '4dab2948-cd1c-4bfb-9829-89cb3079db27', 1, '2026-02-12', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  株式会社VISK　笹川様  1. 商談概要  会社名：株式会社VISK  担当者：笹川様  商談フェーズ：初回ヒアリング完了 → 次回具体提案予定  提案テーマ：  AI顧問サービス  営業支援／営業代行連携  AIシステム開発支援  最終的に、**AI顧問サービス（初期5万円／月額5万円）**を軸とした内容で一度提示。 商談時間の都合により、詳細説明は次回へ持ち越しとなり、翌週に再提案の流れ。  2. 現状の営業体制・取り組み ■ 新規営業の状況  新規営業自体は実施しているが、課題感あり  マッチングサービスを活用した営業が中心  その結果、コンペ案件化しやすい  価格競争・条件競争に巻き込まれやすい  ■ 今後の営業方針  コンペにならない営業環境を構築したい  指名案件化  事前関係構築  差別化提案スキーム  3. 営業代行の活用状況  営業代行も並行活用中  報酬形態：固定報酬型  契約状況  1社：お試し1ヶ月契約  1社：年間契約想定  リード獲得支援を期待  2月契約だが進捗は現時点不明  現在稼働中  課題示唆  成果可視化が不透明  継続判断基準が曖昧  ROI測定が困難  4. システム・AI開発の取り組み ■ AI開発  自社または外部連携でAI開発を実施  提案プロセス：  見積もり提示  提案書作成  デモ開発／提示  ■ 対応可能領域（一例）  車パーツ仕入れ自動化  在庫／発注連携  自動購買フロー構築  本人確認システム  顔写真撮影  本人認証プロセス構築  KYC系対応  → 業務自動化・業務DX領域の開発実績あり  5. 営業手法の特徴 ■ リファラル営業中心  紹介起点での案件創出  関係性ベースの営業  ■ 課題  スケールしにくい  再現性が低い  新規母集団形成が弱い  6. 検討ニーズ（潜在含む）  ヒアリング内容から抽出されるニーズ：  コンペ脱却営業設計  新規リード創出導線構築  営業代行の成果最大化  AI活用による営業効率化  提案・見積・デモの高速化  顧客接点の資産化  7. 当社提案方向性（整理） ■ フロント提案  1ヶ月無料AI顧問トライアル  課題抽出  KPI設計  営業導線設計  ■ 本契約条件（提示済）  初期費用：5万円  月額費用：5万円  提供想定内容：  AI活用営業戦略設計  リード獲得導線構築  コンペ回避営業設計  提案書／デモ生成支援  営業プロセス自動化設計  8. 次回商談アクション  AI顧問サービス詳細説明  営業課題の深掘り  コンペ脱却モデル提示  リード獲得スキーム提案  AI活用デモ提示（可能であれば）', NULL, NULL, NULL, '際商談', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '0149cf59-7353-4ecb-ae05-db3205c31728', '4dab2948-cd1c-4bfb-9829-89cb3079db27', 2, '2026-02-12', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  株式会社VISK　笹川様  1. 商談概要  会社名：株式会社VISK  担当者：笹川様  商談フェーズ：初回ヒアリング完了 → 次回具体提案予定  提案テーマ：  AI顧問サービス  営業支援／営業代行連携  AIシステム開発支援  最終的に、**AI顧問サービス（初期5万円／月額5万円）**を軸とした内容で一度提示。 商談時間の都合により、詳細説明は次回へ持ち越しとなり、翌週に再提案の流れ。  2. 現状の営業体制・取り組み ■ 新規営業の状況  新規営業自体は実施しているが、課題感あり  マッチングサービスを活用した営業が中心  その結果、コンペ案件化しやすい  価格競争・条件競争に巻き込まれやすい  ■ 今後の営業方針  コンペにならない営業環境を構築したい  指名案件化  事前関係構築  差別化提案スキーム  3. 営業代行の活用状況  営業代行も並行活用中  報酬形態：固定報酬型  契約状況  1社：お試し1ヶ月契約  1社：年間契約想定  リード獲得支援を期待  2月契約だが進捗は現時点不明  現在稼働中  課題示唆  成果可視化が不透明  継続判断基準が曖昧  ROI測定が困難  4. システム・AI開発の取り組み ■ AI開発  自社または外部連携でAI開発を実施  提案プロセス：  見積もり提示  提案書作成  デモ開発／提示  ■ 対応可能領域（一例）  車パーツ仕入れ自動化  在庫／発注連携  自動購買フロー構築  本人確認システム  顔写真撮影  本人認証プロセス構築  KYC系対応  → 業務自動化・業務DX領域の開発実績あり  5. 営業手法の特徴 ■ リファラル営業中心  紹介起点での案件創出  関係性ベースの営業  ■ 課題  スケールしにくい  再現性が低い  新規母集団形成が弱い  6. 検討ニーズ（潜在含む）  ヒアリング内容から抽出されるニーズ：  コンペ脱却営業設計  新規リード創出導線構築  営業代行の成果最大化  AI活用による営業効率化  提案・見積・デモの高速化  顧客接点の資産化  7. 当社提案方向性（整理） ■ フロント提案  1ヶ月無料AI顧問トライアル  課題抽出  KPI設計  営業導線設計  ■ 本契約条件（提示済）  初期費用：5万円  月額費用：5万円  提供想定内容：  AI活用営業戦略設計  リード獲得導線構築  コンペ回避営業設計  提案書／デモ生成支援  営業プロセス自動化設計  8. 次回商談アクション  AI顧問サービス詳細説明  営業課題の深掘り  コンペ脱却モデル提示  リード獲得スキーム提案  AI活用デモ提示（可能であれば）', NULL, NULL, NULL, '際商談', '2026-02-19'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'abd999fb-dc36-4820-8d32-b6dfd7aaa6ad', '01add2b6-dac6-4efd-bfcb-4493d5ed583d', 1, '2026-02-13', '00000000-0000-0000-0000-000000000001', '代理店A', '商談サマリー（更新版）  トップノート株式会社様  1. 商談概要  企業名：トップノート株式会社  事業領域：製造業向けDXコンサルティング  コア提供価値：  顧客管理システム（CRM）導入支援  業務DX推進  営業・顧客データの可視化  今回の商談では、DX支援に留まらず、  営業支援  採用支援  マーケ支援  AI活用  まで拡張した連携可能性をディスカッション。  2. 代理店連携構想（最重要トピック）  最終的な着地イメージとして、  弊社サービスの代理店として活動いただく構想について合意形成が進んだ。  ■ 代理店スキームの方向性  トップノート社が保有する顧客基盤：  製造業企業群  設立30年以上の中堅企業  DX検討・CRM導入企業  これら顧客に対し、  弊社AIソリューションを横展開する形。  ■ 想定販売対象  製造業クライアント  DX支援導入済企業  営業強化ニーズ企業  採用課題保有企業  新規開拓を行いたい企業  製造業に限定せず、  他業界顧客への横展開も視野。  3. 直近具体案件（フォームAI）  商談内で、即時案件化の可能性として  フォームAIが刺さる企業が1社存在  との共有あり。  ■ 対象企業の特徴（想定）  新規営業を強化したい  Web問い合わせ導線が弱い  人手送信でフォーム営業を実施 or 検討  営業リソース不足  ■ フォームAI適合ポイント 課題        フォームAIでの解決 手動送信        自動化 送信数不足        大量送信 人件費        削減 アポ不足        母数増加 ■ 直近アクション  対象企業の情報共有  提案資料送付  デモ実施  初期トライアル提案  代理店化前の  スモールスタート案件として位置付け。  4. トップノート社の顧客特性 ■ 製造業文化構造  先方の実体験ベースインサイト：  外部情報を入れない  交流会文化がない  新規発想が乏しい  ■ DX推進障壁  象徴的コメント：  「3D CADを眺めているだけで仕事になる」  DX推進により：  業務量可視化  生産性露呈  抵抗発生  ■ 経営層傾向  売上30億前後企業に多い：  危機感が低い  変革意欲が弱い  現状維持志向  5. 営業・マーケ課題 ■ 新規営業  強化意向あり  フィールドセールス拡張検討  ■ 集客経路  現状：  川崎氏系プラットフォーム依存  課題：  自社集客力不足  リード母数制限  ■ Web導線  自然流入弱い  問い合わせ少  導線設計未最適  6. 採用・ブランディング課題 ■ 採用媒体依存  コスト増大  応募質ばらつき  ■ 動画活用ニーズ  検討内容：  採用動画  会社紹介  技術PR  目的：  応募率改善  ミスマッチ防止  7. 連携可能サービス整理  代理店化を前提とした展開可能商材。  ■ 営業領域  フォームAI  AIテレアポ  営業リスト生成AI  KPI管理AI  ■ 採用領域  採用自動化AI  採用動画制作  SNS採用導線  ■ マーケ領域  広告運用  SEO  動画マーケ  ■ DX統合  CRM×営業連携  データ活用支援  顧客分析AI  8. 代理店モデルの戦略的価値 トップノート社メリット  既存顧客へのアップセル  ストック収益化  DX支援の付加価値向上  弊社メリット  製造業チャネル獲得  一括顧客アクセス  横展開加速  9. フェーズ設計 Phase 1（即時）  フォームAI 1社提案  デモ実施  トライアル導入  Phase 2（短期）  代理店契約締結  商材説明会  共同営業開始  Phase 3（中期）  製造業横展開  採用・営業パッケージ販売  ストック収益化  10. 次回アクション  フォームAI対象企業情報共有  提案資料送付  デモ日程調整  代理店条件整理  収益分配モデル設計', NULL, NULL, NULL, '次回21日に商材研修を行う', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6d151de2-1e82-4cad-b050-a36b3689fd70', '01add2b6-dac6-4efd-bfcb-4493d5ed583d', 2, '2026-02-13', '00000000-0000-0000-0000-000000000001', '代理店A', '商談サマリー（更新版）  トップノート株式会社様  1. 商談概要  企業名：トップノート株式会社  事業領域：製造業向けDXコンサルティング  コア提供価値：  顧客管理システム（CRM）導入支援  業務DX推進  営業・顧客データの可視化  今回の商談では、DX支援に留まらず、  営業支援  採用支援  マーケ支援  AI活用  まで拡張した連携可能性をディスカッション。  2. 代理店連携構想（最重要トピック）  最終的な着地イメージとして、  弊社サービスの代理店として活動いただく構想について合意形成が進んだ。  ■ 代理店スキームの方向性  トップノート社が保有する顧客基盤：  製造業企業群  設立30年以上の中堅企業  DX検討・CRM導入企業  これら顧客に対し、  弊社AIソリューションを横展開する形。  ■ 想定販売対象  製造業クライアント  DX支援導入済企業  営業強化ニーズ企業  採用課題保有企業  新規開拓を行いたい企業  製造業に限定せず、  他業界顧客への横展開も視野。  3. 直近具体案件（フォームAI）  商談内で、即時案件化の可能性として  フォームAIが刺さる企業が1社存在  との共有あり。  ■ 対象企業の特徴（想定）  新規営業を強化したい  Web問い合わせ導線が弱い  人手送信でフォーム営業を実施 or 検討  営業リソース不足  ■ フォームAI適合ポイント 課題        フォームAIでの解決 手動送信        自動化 送信数不足        大量送信 人件費        削減 アポ不足        母数増加 ■ 直近アクション  対象企業の情報共有  提案資料送付  デモ実施  初期トライアル提案  代理店化前の  スモールスタート案件として位置付け。  4. トップノート社の顧客特性 ■ 製造業文化構造  先方の実体験ベースインサイト：  外部情報を入れない  交流会文化がない  新規発想が乏しい  ■ DX推進障壁  象徴的コメント：  「3D CADを眺めているだけで仕事になる」  DX推進により：  業務量可視化  生産性露呈  抵抗発生  ■ 経営層傾向  売上30億前後企業に多い：  危機感が低い  変革意欲が弱い  現状維持志向  5. 営業・マーケ課題 ■ 新規営業  強化意向あり  フィールドセールス拡張検討  ■ 集客経路  現状：  川崎氏系プラットフォーム依存  課題：  自社集客力不足  リード母数制限  ■ Web導線  自然流入弱い  問い合わせ少  導線設計未最適  6. 採用・ブランディング課題 ■ 採用媒体依存  コスト増大  応募質ばらつき  ■ 動画活用ニーズ  検討内容：  採用動画  会社紹介  技術PR  目的：  応募率改善  ミスマッチ防止  7. 連携可能サービス整理  代理店化を前提とした展開可能商材。  ■ 営業領域  フォームAI  AIテレアポ  営業リスト生成AI  KPI管理AI  ■ 採用領域  採用自動化AI  採用動画制作  SNS採用導線  ■ マーケ領域  広告運用  SEO  動画マーケ  ■ DX統合  CRM×営業連携  データ活用支援  顧客分析AI  8. 代理店モデルの戦略的価値 トップノート社メリット  既存顧客へのアップセル  ストック収益化  DX支援の付加価値向上  弊社メリット  製造業チャネル獲得  一括顧客アクセス  横展開加速  9. フェーズ設計 Phase 1（即時）  フォームAI 1社提案  デモ実施  トライアル導入  Phase 2（短期）  代理店契約締結  商材説明会  共同営業開始  Phase 3（中期）  製造業横展開  採用・営業パッケージ販売  ストック収益化  10. 次回アクション  フォームAI対象企業情報共有  提案資料送付  デモ日程調整  代理店条件整理  収益分配モデル設計', NULL, NULL, NULL, '次回21日に商材研修を行う', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '06d2e4bf-62b8-45cb-8d93-18477976e184', 'e3eee156-32ac-4b26-9187-b92907a0d719', 1, '2026-02-13', '00000000-0000-0000-0000-000000000001', 'A', '商談サマリー  案件名：ベストオブミス埼玉 共催企業獲得支援（フォームAI／リストAI）  1. 商談基本情報  担当者名：冨岡 龍也 様  団体名：ベストオブミス埼玉  連絡先：best.of.miss-saitama@add-group.biz  電話番号：070-9062-6758  商談フェーズ：初回ヒアリング完了 → 導入前向き検討  2. 事業・プロジェクト概要  ベストオブミス埼玉大会の運営およびスポンサー／共催企業の獲得活動を実施  主な活動内容：  ミスコンテスト大会の企画・運営  共催企業（スポンサー）の募集  地域企業とのタイアップ施策  メディア露出を活用したPR支援  3. 現在の営業・集客スキーム 共催営業の実態  スポンサー／共催企業の開拓が必須  しかし以下の理由で営業リソースが逼迫  主な要因  大会準備業務と並行  出場者対応・運営対応  メディア調整  企画制作  → 営業専任体制を持てず、 　アポイント獲得が大きなボトルネック  4. 共催企業のターゲット  業種制限：特になし（全業種対象）  想定スポンサー例：  美容（エステ／脱毛／美容皮膚科）  フィットネス  化粧品メーカー  アパレル  飲食  不動産  自動車  地元優良企業  医療／整体  教育／スクール  5. 共催企業側のメリット設計  スポンサー企業が得られる露出価値：  メディア露出  テレビ埼玉での生放送  ミス埼玉密着番組の開始予定  出場者追跡ドキュメント型番組  番組内企画露出  例：  企業訪問インタビュー  エステ施術体験  美容サービス体験  トレーニング指導  商品提供  → 番組内で企業名・サービスが露出  6. PRチャネル活用  露出メディアは多面展開：  テレビ埼玉（地上波）  Yahoo!ニュース掲載  YouTube配信  SNS拡散  各種Webメディア  → スポンサー企業に対し PRパッケージとして提案  7. 組織体制・展開範囲  全国に運営母体あり  各エリアごとに大会実施  埼玉大会はその一拠点  → 成功モデル化すれば 他県展開の可能性あり  8. 現在の課題整理 項目	課題内容 営業工数	大会準備と並行で不足 アポ獲得	手動営業で限界 リスト不足	業種横断で収集が困難 送信工数	個別メール対応 反響管理	一元管理できていない 9. 提案サービス ① フォームAI  用途  共催企業への営業打診  スポンサー募集案内  番組出演提案  訴求軸  メディア露出  地域貢献  ブランドPR  ② リストAI  用途  埼玉周辺企業の抽出  業種横断ターゲティング  スポンサー適性企業選定  10. 提案条件  初期費用：0円  導入ハードル：低  まずはテスト運用想定  11. 想定活用フロー  埼玉県内企業リスト生成  共催スポンサー候補抽出  フォームAIで一斉打診  反響企業へ個別営業  協賛契約締結  番組出演／PR連携  12. 導入期待効果  営業工数削減  アポ獲得自動化  スポンサー数最大化  PR露出企業増加  大会収益安定化  13. 次回アクション  フォーム文面設計  ターゲット業種優先順位設定  送信件数シミュレーション  反響率想定  スポンサー単価設計確認', NULL, NULL, NULL, '代理店とフォームAI契約', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7e3a1e70-d03f-4fc6-b4be-cb1a17748d67', 'e3eee156-32ac-4b26-9187-b92907a0d719', 2, '2026-02-13', '00000000-0000-0000-0000-000000000001', 'A', '商談サマリー  案件名：ベストオブミス埼玉 共催企業獲得支援（フォームAI／リストAI）  1. 商談基本情報  担当者名：冨岡 龍也 様  団体名：ベストオブミス埼玉  連絡先：best.of.miss-saitama@add-group.biz  電話番号：070-9062-6758  商談フェーズ：初回ヒアリング完了 → 導入前向き検討  2. 事業・プロジェクト概要  ベストオブミス埼玉大会の運営およびスポンサー／共催企業の獲得活動を実施  主な活動内容：  ミスコンテスト大会の企画・運営  共催企業（スポンサー）の募集  地域企業とのタイアップ施策  メディア露出を活用したPR支援  3. 現在の営業・集客スキーム 共催営業の実態  スポンサー／共催企業の開拓が必須  しかし以下の理由で営業リソースが逼迫  主な要因  大会準備業務と並行  出場者対応・運営対応  メディア調整  企画制作  → 営業専任体制を持てず、 　アポイント獲得が大きなボトルネック  4. 共催企業のターゲット  業種制限：特になし（全業種対象）  想定スポンサー例：  美容（エステ／脱毛／美容皮膚科）  フィットネス  化粧品メーカー  アパレル  飲食  不動産  自動車  地元優良企業  医療／整体  教育／スクール  5. 共催企業側のメリット設計  スポンサー企業が得られる露出価値：  メディア露出  テレビ埼玉での生放送  ミス埼玉密着番組の開始予定  出場者追跡ドキュメント型番組  番組内企画露出  例：  企業訪問インタビュー  エステ施術体験  美容サービス体験  トレーニング指導  商品提供  → 番組内で企業名・サービスが露出  6. PRチャネル活用  露出メディアは多面展開：  テレビ埼玉（地上波）  Yahoo!ニュース掲載  YouTube配信  SNS拡散  各種Webメディア  → スポンサー企業に対し PRパッケージとして提案  7. 組織体制・展開範囲  全国に運営母体あり  各エリアごとに大会実施  埼玉大会はその一拠点  → 成功モデル化すれば 他県展開の可能性あり  8. 現在の課題整理 項目	課題内容 営業工数	大会準備と並行で不足 アポ獲得	手動営業で限界 リスト不足	業種横断で収集が困難 送信工数	個別メール対応 反響管理	一元管理できていない 9. 提案サービス ① フォームAI  用途  共催企業への営業打診  スポンサー募集案内  番組出演提案  訴求軸  メディア露出  地域貢献  ブランドPR  ② リストAI  用途  埼玉周辺企業の抽出  業種横断ターゲティング  スポンサー適性企業選定  10. 提案条件  初期費用：0円  導入ハードル：低  まずはテスト運用想定  11. 想定活用フロー  埼玉県内企業リスト生成  共催スポンサー候補抽出  フォームAIで一斉打診  反響企業へ個別営業  協賛契約締結  番組出演／PR連携  12. 導入期待効果  営業工数削減  アポ獲得自動化  スポンサー数最大化  PR露出企業増加  大会収益安定化  13. 次回アクション  フォーム文面設計  ターゲット業種優先順位設定  送信件数シミュレーション  反響率想定  スポンサー単価設計確認', NULL, NULL, NULL, '代理店とフォームAI契約', '2026-02-13'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '25370798-34ae-40f1-ac56-ef8b6c953f3a', '5721b8ce-eddc-4dc8-847e-073df2773d53', 1, '2026-02-13', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 1. 商談概要  対象：個人事業主（toCコンサルティング領域） 商談フェーズ：初回ヒアリング完了 → 導入検討段階 主目的：顧客管理・案件獲得導線の構築  2. 現状の事業・営業スタイル  個人向け（toC）コンサルティングが主軸  クライアント属性は個人事業主が中心  一部BtoB案件もあるが、比率は低め  BtoB領域においては、  積極的な営業活動は未整備  案件獲得の仕組み化が未構築  3. 現在の主な課題  ① 顧客管理の未整備  toC顧客情報の蓄積・管理が属人的  継続フォロー・アップセル導線が弱い  ② リスト・見込み客管理不足  交流会・紹介で得た名刺／連絡先が散在  案件化に至るまでの管理フローがない  ③ BtoB案件獲得導線の弱さ  個人事業主支援の延長で法人案件を取りたい意向  代理店活動・交流会営業は実施しているが、  案件化率  追客管理 が不透明  4. 取り組み施策（現状）  交流会参加・主催  代理店としての営業活動  紹介・人脈ベースの案件獲得  ただし、  リスト化  ステータス管理  追客履歴管理 ができておらず、機会損失が発生している認識。  5. ニーズ整理  先方が求めている機能は以下：  顧客管理（toC中心）  リスト管理（交流会・紹介）  名刺情報のデータ化  案件ステータス管理  BtoB案件創出の導線整理  いわゆる「営業管理＋顧客資産化」の基盤構築ニーズ。  6. 提案サービス  Lシンク  初期費用：5万円  月額費用：3万円  顧客・リスト・商談管理を一元化し、 交流会起点の営業活動を資産化する設計で提案。  7. 先方反応  Lシンク：前向きに検討  導入イメージ：具体的に持てている  一方で下記ツールは温度感低め：  フォーム営業ツール  リスト生成ツール  名刺管理ツール（単体）  理由： 現時点では「新規開拓強化」よりも、 既存接点の管理・活用を優先したい意向。  8. ネクストアクション  1週間後にフォロー連絡  導入可否の最終回答取得予定  導入の場合、初期設定〜運用設計支援へ移行', NULL, NULL, NULL, '回答', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ecda3241-7a15-4169-8b0a-2754f8ed6963', '5721b8ce-eddc-4dc8-847e-073df2773d53', 2, '2026-02-13', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー 1. 商談概要  対象：個人事業主（toCコンサルティング領域） 商談フェーズ：初回ヒアリング完了 → 導入検討段階 主目的：顧客管理・案件獲得導線の構築  2. 現状の事業・営業スタイル  個人向け（toC）コンサルティングが主軸  クライアント属性は個人事業主が中心  一部BtoB案件もあるが、比率は低め  BtoB領域においては、  積極的な営業活動は未整備  案件獲得の仕組み化が未構築  3. 現在の主な課題  ① 顧客管理の未整備  toC顧客情報の蓄積・管理が属人的  継続フォロー・アップセル導線が弱い  ② リスト・見込み客管理不足  交流会・紹介で得た名刺／連絡先が散在  案件化に至るまでの管理フローがない  ③ BtoB案件獲得導線の弱さ  個人事業主支援の延長で法人案件を取りたい意向  代理店活動・交流会営業は実施しているが、  案件化率  追客管理 が不透明  4. 取り組み施策（現状）  交流会参加・主催  代理店としての営業活動  紹介・人脈ベースの案件獲得  ただし、  リスト化  ステータス管理  追客履歴管理 ができておらず、機会損失が発生している認識。  5. ニーズ整理  先方が求めている機能は以下：  顧客管理（toC中心）  リスト管理（交流会・紹介）  名刺情報のデータ化  案件ステータス管理  BtoB案件創出の導線整理  いわゆる「営業管理＋顧客資産化」の基盤構築ニーズ。  6. 提案サービス  Lシンク  初期費用：5万円  月額費用：3万円  顧客・リスト・商談管理を一元化し、 交流会起点の営業活動を資産化する設計で提案。  7. 先方反応  Lシンク：前向きに検討  導入イメージ：具体的に持てている  一方で下記ツールは温度感低め：  フォーム営業ツール  リスト生成ツール  名刺管理ツール（単体）  理由： 現時点では「新規開拓強化」よりも、 既存接点の管理・活用を優先したい意向。  8. ネクストアクション  1週間後にフォロー連絡  導入可否の最終回答取得予定  導入の場合、初期設定〜運用設計支援へ移行', NULL, NULL, NULL, '回答', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'daff7f6b-beb7-488f-9b96-e62c2256c654', '6c33e1db-ee4e-4785-b66a-2412174f15f1', 1, '2026-02-14', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポの営業代行の話を行い、 1コール60円〜70円で大量コールができることの話を行い、非常にいい内容とのことで、 現在受けている案件が、4500件の名前がわかるリストがあり、そこに対して、2400コール70万円で、3%のアポイントが獲得できるということで、行っている会社があるため、 そこに対して、同じ内容で、50万円でできると提示 さらに同時並行で、更にに3.6万件のリストがあるとのことで、そっちの人員も欲しいとのこと この部分で、決裁権を持つ方と改めて提案を行うことに 2社話を聞いているため、その辺確認した上で最長氏え', NULL, NULL, NULL, '再調整', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f5c90297-d520-4b3c-9da4-e6cc22c59ada', '6c33e1db-ee4e-4785-b66a-2412174f15f1', 2, '2026-02-14', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポの営業代行の話を行い、 1コール60円〜70円で大量コールができることの話を行い、非常にいい内容とのことで、 現在受けている案件が、4500件の名前がわかるリストがあり、そこに対して、2400コール70万円で、3%のアポイントが獲得できるということで、行っている会社があるため、 そこに対して、同じ内容で、50万円でできると提示 さらに同時並行で、更にに3.6万件のリストがあるとのことで、そっちの人員も欲しいとのこと この部分で、決裁権を持つ方と改めて提案を行うことに 2社話を聞いているため、その辺確認した上で最長氏え', NULL, NULL, NULL, '再調整', '2026-02-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '40420011-8d47-44d9-9a78-d9b591eb86b6', '09bd42c1-04fc-4cd9-815d-d10e8f1be5d2', 1, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・当社はSNSコンサル（ショート動画運用）を主力事業としており、業種は限定せずPRニーズのある企業が対象。 ・現在の新規獲得は紹介のみ。自社に営業担当は不在。 ・今後は新規アポを安定供給できる仕組みを検討中。 ・クロージングは知人の富岡氏（別会社・営業担当）が担う想定。 ・アポ獲得手法については未確定で、今回提案サービスを有力候補として検討。 ・AIテレアポには強い関心は示さず、フォーム営業AIに興味あり。 ・フォーム営業で獲得した反響に対し、クロージングまで含めて一度回してみたい意向。 ・予算決裁は当社側。金額感は大きな拒否反応なし。 ・フォーム営業：月5万円／最大月1万件、拡張時は2万件10万円、3万件15万円の説明に理解。 ・データベース130,000件保有・毎月増加との説明についても確認済み。 ・最終判断は富岡氏と協議のうえ、今週中に回答予定。  【課題】 ・新規開拓の仕組みが未整備（紹介依存）。 ・営業体制が未確立（アポ取得・クロージングの役割分担は構想段階）。 ・アポ獲得手法の具体設計が未決定（富岡氏と要調整）。 ・フォーム営業の運用設計（ターゲット・訴求内容・クロージング連携）が未定。  【提案サービス】 ・ツバメリード フォーム営業AI（フォーム営業自動化ツール） ・AIテレアポ（AI活用型営業代行）※今回は優先度低  【次回アクション】 ・当社：提案資料を送付。 ・先方：富岡氏と実施手法・運用フローを協議。 ・先方：今週中に導入可否の回答予定。 ・回答後、導入の場合はターゲット設定・スクリプト設計の打ち合わせ設定。', NULL, NULL, NULL, '検討結果', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4b631bbf-829a-41d3-be78-54d9425bf49e', '09bd42c1-04fc-4cd9-815d-d10e8f1be5d2', 2, '2026-02-16', '00000000-0000-0000-0000-000000000002', 'C', '【ヒアリング内容】 ・当社はSNSコンサル（ショート動画運用）を主力事業としており、業種は限定せずPRニーズのある企業が対象。 ・現在の新規獲得は紹介のみ。自社に営業担当は不在。 ・今後は新規アポを安定供給できる仕組みを検討中。 ・クロージングは知人の富岡氏（別会社・営業担当）が担う想定。 ・アポ獲得手法については未確定で、今回提案サービスを有力候補として検討。 ・AIテレアポには強い関心は示さず、フォーム営業AIに興味あり。 ・フォーム営業で獲得した反響に対し、クロージングまで含めて一度回してみたい意向。 ・予算決裁は当社側。金額感は大きな拒否反応なし。 ・フォーム営業：月5万円／最大月1万件、拡張時は2万件10万円、3万件15万円の説明に理解。 ・データベース130,000件保有・毎月増加との説明についても確認済み。 ・最終判断は富岡氏と協議のうえ、今週中に回答予定。  【課題】 ・新規開拓の仕組みが未整備（紹介依存）。 ・営業体制が未確立（アポ取得・クロージングの役割分担は構想段階）。 ・アポ獲得手法の具体設計が未決定（富岡氏と要調整）。 ・フォーム営業の運用設計（ターゲット・訴求内容・クロージング連携）が未定。  【提案サービス】 ・ツバメリード フォーム営業AI（フォーム営業自動化ツール） ・AIテレアポ（AI活用型営業代行）※今回は優先度低  【次回アクション】 ・当社：提案資料を送付。 ・先方：富岡氏と実施手法・運用フローを協議。 ・先方：今週中に導入可否の回答予定。 ・回答後、導入の場合はターゲット設定・スクリプト設計の打ち合わせ設定。', NULL, NULL, NULL, '検討結果', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '9972d0f8-55a0-4782-8c1f-beedf4d1ef0d', 'd67618fc-8e96-4629-ad34-e35d3eba699f', 1, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  企業名：株式会社ヴォーカス  1. 商談概要  目的：Lステップ流入経路の可視化・分析環境の構築検討  背景：既存Lステップ運用において「流入元の特定・効果測定」が不十分  初期検討：Lステップ連携前提での分析環境導入  ヒアリングを進める中で、 Lステップ単体最適ではなく、CRM統合管理視点の方が効果最大化できると判断。  そのため、 Lシンクへの導入切替が可能かを相談・検討フェーズへ移行。  2. 現状課題  ① 流入経路の可視化不足  広告／SNS／紹介 等の流入元判別が困難  施策別ROIが算出できていない  ② Lステップ運用の属人化  管理画面ベースの運用に依存  データの横断分析が不可  ③ EC顧客データの統合管理未整備  購買履歴とLINE行動履歴の連携不足  LTV最大化施策が限定的  3. 検討サービス  現時点での検討スコープは下記3領域。  ① Lシンク  LINE顧客データ統合管理  流入経路分析  セグメント配信最適化  CRM／MA的活用  ※Lステップ分析補完ではなく、 　上位CRMとしての導入イメージ  ② AIテレアポ  新規リード獲得  休眠顧客掘り起こし  EC関連企業への横展開営業  ③ フォームAI  問い合わせフォーム営業自動化  EC関連企業へのアプローチ  リード母集団形成  4. 導入優先度・評価感触  EC顧客向け提案モデルと親和性が高く、評価は良好  特に下記2点の評価が高い  ① 顧客データ統合によるCRM強化 ② 流入経路分析 → 売上貢献可視化  「非常に良いと感じている」とのコメントあり。 前向き検討フェーズ。  5. 導入スケジュール感  最終判断時期：2月〜3月中旬  社内検討後に正式回答  「3月中旬頃までには連絡できるようにする」  との明確な意思表示あり。  6. 受注見通し  ステータス：中〜高確度  理由：  課題とサービスの適合度が高い  EC顧客展開モデルと一致  CRM強化ニーズが顕在化  7. ネクストアクション  営業側  Lシンク導入パターン資料送付  Lステップ連携事例提示  EC企業活用事例共有  先方  社内検討  予算・導入優先度整理  導入可否判断  8. クロージングシナリオ想定  ① Lシンク単体導入 ② Lシンク＋フォームAI ③ フルパッケージ導入 （Lシンク＋AIテレアポ＋フォームAI）  EC顧客展開を踏まえると、 ② or ③着地の可能性が高い構図。', NULL, NULL, NULL, '回答', '2026-03-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '2196064f-1ba7-402b-931b-957886063d6d', 'd67618fc-8e96-4629-ad34-e35d3eba699f', 2, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'ネタ', '商談サマリー  企業名：株式会社ヴォーカス  1. 商談概要  目的：Lステップ流入経路の可視化・分析環境の構築検討  背景：既存Lステップ運用において「流入元の特定・効果測定」が不十分  初期検討：Lステップ連携前提での分析環境導入  ヒアリングを進める中で、 Lステップ単体最適ではなく、CRM統合管理視点の方が効果最大化できると判断。  そのため、 Lシンクへの導入切替が可能かを相談・検討フェーズへ移行。  2. 現状課題  ① 流入経路の可視化不足  広告／SNS／紹介 等の流入元判別が困難  施策別ROIが算出できていない  ② Lステップ運用の属人化  管理画面ベースの運用に依存  データの横断分析が不可  ③ EC顧客データの統合管理未整備  購買履歴とLINE行動履歴の連携不足  LTV最大化施策が限定的  3. 検討サービス  現時点での検討スコープは下記3領域。  ① Lシンク  LINE顧客データ統合管理  流入経路分析  セグメント配信最適化  CRM／MA的活用  ※Lステップ分析補完ではなく、 　上位CRMとしての導入イメージ  ② AIテレアポ  新規リード獲得  休眠顧客掘り起こし  EC関連企業への横展開営業  ③ フォームAI  問い合わせフォーム営業自動化  EC関連企業へのアプローチ  リード母集団形成  4. 導入優先度・評価感触  EC顧客向け提案モデルと親和性が高く、評価は良好  特に下記2点の評価が高い  ① 顧客データ統合によるCRM強化 ② 流入経路分析 → 売上貢献可視化  「非常に良いと感じている」とのコメントあり。 前向き検討フェーズ。  5. 導入スケジュール感  最終判断時期：2月〜3月中旬  社内検討後に正式回答  「3月中旬頃までには連絡できるようにする」  との明確な意思表示あり。  6. 受注見通し  ステータス：中〜高確度  理由：  課題とサービスの適合度が高い  EC顧客展開モデルと一致  CRM強化ニーズが顕在化  7. ネクストアクション  営業側  Lシンク導入パターン資料送付  Lステップ連携事例提示  EC企業活用事例共有  先方  社内検討  予算・導入優先度整理  導入可否判断  8. クロージングシナリオ想定  ① Lシンク単体導入 ② Lシンク＋フォームAI ③ フルパッケージ導入 （Lシンク＋AIテレアポ＋フォームAI）  EC顧客展開を踏まえると、 ② or ③着地の可能性が高い構図。', NULL, NULL, NULL, '回答', '2026-03-16'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '25be9472-421f-4585-b777-a9a2765c4c10', '263f6809-8cc4-40f8-b319-d68d96762e77', 1, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'C', '外国人財の紹介を行っていく企業で、 案件獲得にフォームAIサービスは使えるとのこと 初期5万円　月額5万円で利用可能とお伝えし、非常に良い反応となる 改めて、来週に検討結果確認する 2月申し込みで伝えている', NULL, NULL, NULL, '検討状況確認', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '56ee45d9-1503-4bdf-b89d-bde9d09700df', '263f6809-8cc4-40f8-b319-d68d96762e77', 2, '2026-02-16', '00000000-0000-0000-0000-000000000001', 'C', '外国人財の紹介を行っていく企業で、 案件獲得にフォームAIサービスは使えるとのこと 初期5万円　月額5万円で利用可能とお伝えし、非常に良い反応となる 改めて、来週に検討結果確認する 2月申し込みで伝えている', NULL, NULL, NULL, '検討状況確認', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4394aafb-1426-43d6-abe2-f72ee34a5e82', '414a5198-e933-4aa0-bba6-7d5124dc873b', 1, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  初期費用5万円　月額5万円　フォームAI  株式会社ミズテック 担当：小林 慎太郎 様 件名：【ご紹介】AIフォーム送信／営業支援関連 商談記録  1. 企業・事業概況  主軸：住宅設備関連事業  取扱領域：  給湯器  リフォーム  専門工事  電気工事  空調設備  付帯ビジネス：  住宅設備の共同販売モデル  会員制にて「商品供給のみ」を実施（卸・プラットフォーム型）  2. 営業体制・現状  自社営業：  一部実施  他社営業代行を活用しテレアポを外注  既存課題：  反響対応でリソースが逼迫  新規開拓に人的余力なし  問い合わせ処理だけで業務が埋まる状態  3. AIフォーム送信（ToB向け）検討背景  興味領域：  AIを活用したフォーム営業  新規開拓の自動化  懸念点：  給湯器業界での具体事例が未確認  同業界適用イメージがまだ弱い  4. ターゲット適合業種（先方認識）  AIフォーム送信の適用可能性として挙がった業種：  リフォーム会社  専門工事店  電気工事会社  空調設備会社  給湯器販売会社  住宅設備バリューチェーン全体への横展開余地あり。  5. テレアポ施策の現状  外注先：  「すとっく（Stock）」にて実施  今後：  3月よりキャンペーン開始予定  現在は事前準備フェーズ  進捗感：  架電数は増加予定だが現状は未稼働  6. 数値・成果状況  現状評価：  架電数が不足  サービス特性上アポ率低下  想定より商談化せず  心理面：  担当者としても  モチベーション低下  施策疲弊感あり  7. 費用感・契約状況  テレアポ単価：  200〜300円／コール  既に契約済み  比較軸：  同一価格帯での  架電量  商談化率  効率性  を重視  8. 現時点の検討温度感  AIフォーム送信：  興味あり  事例不足で判断保留  テレアポ：  既存運用あり  成果不十分  総合評価：  営業自動化ニーズは高い  ただし投資判断は慎重  9. 今後のスケジュール  2月中：  サービス利用可否を社内検討  来週：  検討状況ヒアリング  導入可否の一次回答取得予定  10. ネクストアクション（当社側）  給湯器／住宅設備業界のフォーム営業事例整理  テレアポとの費用対効果比較資料提示  反響対応過多企業向け「自動化導線」提案  3月キャンペーン開始前の代替施策提示', NULL, NULL, NULL, '検討状況確認', '2026-02-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'dd302514-26c1-4465-bb57-efdb99da2177', '414a5198-e933-4aa0-bba6-7d5124dc873b', 2, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー  初期費用5万円　月額5万円　フォームAI  株式会社ミズテック 担当：小林 慎太郎 様 件名：【ご紹介】AIフォーム送信／営業支援関連 商談記録  1. 企業・事業概況  主軸：住宅設備関連事業  取扱領域：  給湯器  リフォーム  専門工事  電気工事  空調設備  付帯ビジネス：  住宅設備の共同販売モデル  会員制にて「商品供給のみ」を実施（卸・プラットフォーム型）  2. 営業体制・現状  自社営業：  一部実施  他社営業代行を活用しテレアポを外注  既存課題：  反響対応でリソースが逼迫  新規開拓に人的余力なし  問い合わせ処理だけで業務が埋まる状態  3. AIフォーム送信（ToB向け）検討背景  興味領域：  AIを活用したフォーム営業  新規開拓の自動化  懸念点：  給湯器業界での具体事例が未確認  同業界適用イメージがまだ弱い  4. ターゲット適合業種（先方認識）  AIフォーム送信の適用可能性として挙がった業種：  リフォーム会社  専門工事店  電気工事会社  空調設備会社  給湯器販売会社  住宅設備バリューチェーン全体への横展開余地あり。  5. テレアポ施策の現状  外注先：  「すとっく（Stock）」にて実施  今後：  3月よりキャンペーン開始予定  現在は事前準備フェーズ  進捗感：  架電数は増加予定だが現状は未稼働  6. 数値・成果状況  現状評価：  架電数が不足  サービス特性上アポ率低下  想定より商談化せず  心理面：  担当者としても  モチベーション低下  施策疲弊感あり  7. 費用感・契約状況  テレアポ単価：  200〜300円／コール  既に契約済み  比較軸：  同一価格帯での  架電量  商談化率  効率性  を重視  8. 現時点の検討温度感  AIフォーム送信：  興味あり  事例不足で判断保留  テレアポ：  既存運用あり  成果不十分  総合評価：  営業自動化ニーズは高い  ただし投資判断は慎重  9. 今後のスケジュール  2月中：  サービス利用可否を社内検討  来週：  検討状況ヒアリング  導入可否の一次回答取得予定  10. ネクストアクション（当社側）  給湯器／住宅設備業界のフォーム営業事例整理  テレアポとの費用対効果比較資料提示  反響対応過多企業向け「自動化導線」提案  3月キャンペーン開始前の代替施策提示', NULL, NULL, NULL, '検討状況確認', '2026-02-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '997add48-cbab-4475-8630-7b51c0bf095f', '37efffb5-d987-4b9a-a489-0f64b631cdcc', 1, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー ■商談先概要  一人法人にてFC（フランチャイズ）本部運営を実施。 所在地：大阪  ■現状の事業・運営状況  新規加盟開発については積極営業は実施していない方針。  「営業してまで加盟を増やしたい」というスタンスではなく、 ビジネスモデルを聞いて興味を持った企業のみ加盟させる形式。  加盟までの基本フロー：  ビジネスモデル説明  現場見学  審査  契約  加盟希望者は多く、 1店舗運営者が30店舗展開を希望するケースも発生。  ■紹介・営業スキーム  紹介料の設定：なし  背景：  昨年4月より現行スキームを運用  加盟満足度が非常に高い  自然流入・紹介で加盟が増加  営業インセンティブを設ける必要がない状況  ■現在の最重要経営テーマ ① 本部構築  FC本部機能の構築に相当な工数・コストを投下  運営設計・管理体制整備に苦戦  ② DX化・自動化  注力領域：  業務DX化  自動化設計  チャットボット導入  本部管理システム構築  → 本部運営効率化が最優先テーマ  ■運営課題  加盟希望が増加し、 本部側の運営負荷が急増  現在の状態：  「勝手に加盟・追加したい」という声が増えている  受け皿となる本部機能が逼迫  管理・統制が追いついていない  ■改善スタンス  常に課題を抽出しPDCAを回している  外部支援の受け入れには前向き  期待値：  内部に入り込んでの業務改善  本部運営設計の最適化  DX推進支援  ■具体検討事項  大阪現地対応を含めた支援検討  想定費用感：15万円（現地対応含む）  検討対象：  本部管理ツール  運営DX支援  自動化設計  ■今後アクション  ピースフラット社の資料を再送  本部DX／運営支援の具体検討フェーズへ移行予定  ステータス：情報提供後・検討中', NULL, NULL, NULL, '回答', '2026-02-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7688ea3c-c605-4e85-a7c4-320ea04a5561', '37efffb5-d987-4b9a-a489-0f64b631cdcc', 2, '2026-02-17', '00000000-0000-0000-0000-000000000001', 'C', '商談サマリー ■商談先概要  一人法人にてFC（フランチャイズ）本部運営を実施。 所在地：大阪  ■現状の事業・運営状況  新規加盟開発については積極営業は実施していない方針。  「営業してまで加盟を増やしたい」というスタンスではなく、 ビジネスモデルを聞いて興味を持った企業のみ加盟させる形式。  加盟までの基本フロー：  ビジネスモデル説明  現場見学  審査  契約  加盟希望者は多く、 1店舗運営者が30店舗展開を希望するケースも発生。  ■紹介・営業スキーム  紹介料の設定：なし  背景：  昨年4月より現行スキームを運用  加盟満足度が非常に高い  自然流入・紹介で加盟が増加  営業インセンティブを設ける必要がない状況  ■現在の最重要経営テーマ ① 本部構築  FC本部機能の構築に相当な工数・コストを投下  運営設計・管理体制整備に苦戦  ② DX化・自動化  注力領域：  業務DX化  自動化設計  チャットボット導入  本部管理システム構築  → 本部運営効率化が最優先テーマ  ■運営課題  加盟希望が増加し、 本部側の運営負荷が急増  現在の状態：  「勝手に加盟・追加したい」という声が増えている  受け皿となる本部機能が逼迫  管理・統制が追いついていない  ■改善スタンス  常に課題を抽出しPDCAを回している  外部支援の受け入れには前向き  期待値：  内部に入り込んでの業務改善  本部運営設計の最適化  DX推進支援  ■具体検討事項  大阪現地対応を含めた支援検討  想定費用感：15万円（現地対応含む）  検討対象：  本部管理ツール  運営DX支援  自動化設計  ■今後アクション  ピースフラット社の資料を再送  本部DX／運営支援の具体検討フェーズへ移行予定  ステータス：情報提供後・検討中', NULL, NULL, NULL, '回答', '2026-02-24'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '43b0bb5f-e72b-4541-950b-9e06666a9418', '03fed703-3a68-461e-baa4-389764f6b8af', 1, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'ネタ', '株式会社ライディ  営業代行 固定報酬   3月7日以降で、1アポ5万円程度の案件が取れるのではないかとのことで、 その件また連絡が来る可能性あり 改めて、連絡し、案件があるか確認する 時給も2200円ほどで、月100時間単位で仕事は依頼可能 弊社の営業代行案件で、あれば、依頼可能な状況となってる   https://crowdworks.jp/public/jobs/12832873 【 概要 】 太陽光発電・蓄電池導入のアポイント獲得に向けて、テレアポを実施していただきます。   【期待していること（業務内容）】 ・テレアポ ・お客様の課題を引き出し、興味を喚起するトーク展開 ・商談につながるリード創出 ・トーク内容や成果を定量化・報告・改善  【 期間 】 即稼動可能   【 報酬体系 】 40,000円/1アポイント ※契約金額（税込）からシステム利用料を差し引いた金額が、ワーカーさまの受取金額となります。 ※スキル・ご経験に応じて柔軟に設計させていただきます。  【重視する点／歓迎スキル・経験】 必須ではありませんが、以下に該当する方は歓迎します。 BtoB向けテレアポ／IS業務の実務経験 電話での法人対応に抵抗がない方・課題ヒアリング型の営業経験 Slackでの業務コミュニケーション経験 基本的なビジネスマナー・コミュニケーション力 PC操作が可能な方（CRM入力、オンライン対応） 業務委託として一定の自走ができる方  【備考】 トークスクリプト 架電リスト：あり CTIツール：あり マニュアル・オンボーディング：あり 商材理解・ターゲット設計が整理された状態でスタートできます  【 応募方法 】 ・簡単な自己紹介や実績をご提示ください。    営業代行 法人向けの太陽光、蓄電池の導入 └アポイントの確得を行っており、 稼働を行う中で、   リスト数  ペンディング状態となるため、   製造業サーす  オンライン特化のBPOサービス  成果報酬案件  サブスク特化方の決済サービス └成果報酬　2万円 固定報酬　  経理、DX部門関係、月次の    3月2週目〜末にかけて、案件が入ってきそう └ 企業方DC 確定拠出年金  その他ご質問等ありましたら、お気軽にお問い合わせください。 ご応募をお待ちしております！ 下記の内容でアプローチしそのまま打ち合わせの流れになった 【会社概要】 株式会社SoloptiLinkは「営業の最適解を、すべての業界に」をミッションに、AI×人材を融合した営業支援・営業代行事業を展開しております。  テレマーケティング、インサイドセールス、営業戦略設計までを一気通貫で支援し、継続的な売上創出体制の構築を得意としております。  【対応条件／料金体系】  ・架電単価：1コール70円 ・月間5万件規模の継続架電体制構築可能  ※上記以外の追加費用は一切いただきません。 ※費用対効果が合わない場合は、契約見直しも柔軟に対応いたします。  【稼働開始スケジュール】  ・契約後 最短2週間で稼働開始可能 リスト設計、スクリプト調整、テスト架電を経て本稼働へ移行いたします。  【対応領域】  ■ BtoB営業支援 ・法人向けサービス新規開拓 ・アポイント創出／商談設定 ・インサイドセールス代行  ■ BtoC営業支援 ・個人向け商材販売促進 ・イベント／催事送客 ・反響追客架電  商材特性に応じたトーク設計・ターゲティングが可能です。  【導入・取引実績】  ・株式会社フォーバル ・株式会社ライトアップ ・日本エコシステム株式会社 ・シャープ株式会社 ・長州産業株式会社 ・他1000社以上との取引実績  【営業支援成果】  ・人件費 1/8 削減 ・開始2ヶ月でアポ数400％達成 ・10ヶ月で売上1億円以上創出  【運用実績】  ・月間5万コールの対応実績あり 継続案件において、大規模母集団への安定的な架電運用を実施しております。  【運用品質・管理体制】  ・全架電録音対応 ・通話ログ共有可能 ・日次／週次／月次レポート提出 ・KPI（通話数・接続率・アポ率）可視化  運用状況を透明化し、改善提案まで一体で実施いたします。  【当社の強み】  ① 継続運用前提の営業体制構築 単発支援ではなく、KPI設計を行い長期成果を創出。  ② 大量架電×品質担保 量と質を両立した営業活動が可能。  ③ トークスクリプト最適化 ABテストにより反応率を継続改善。  ④ コンサルティング連動 ターゲット戦略・販売導線設計まで伴走。  これまでの営業支援実績とコンサルティングノウハウを活かし、貴社の売上拡大に向けた継続的な営業基盤構築に貢献いたします。  詳細な体制・実績については添付資料をもとにご説明可能です。 ぜひ一度お打ち合わせの機会をいただけますと幸いです。  何卒よろしくお願い申し上げます。', NULL, NULL, NULL, '新しい案件確認', '2026-03-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '24bb8a56-34f8-43c4-ba46-bedc22dd9d0c', '03fed703-3a68-461e-baa4-389764f6b8af', 2, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'ネタ', '株式会社ライディ  営業代行 固定報酬   3月7日以降で、1アポ5万円程度の案件が取れるのではないかとのことで、 その件また連絡が来る可能性あり 改めて、連絡し、案件があるか確認する 時給も2200円ほどで、月100時間単位で仕事は依頼可能 弊社の営業代行案件で、あれば、依頼可能な状況となってる   https://crowdworks.jp/public/jobs/12832873 【 概要 】 太陽光発電・蓄電池導入のアポイント獲得に向けて、テレアポを実施していただきます。   【期待していること（業務内容）】 ・テレアポ ・お客様の課題を引き出し、興味を喚起するトーク展開 ・商談につながるリード創出 ・トーク内容や成果を定量化・報告・改善  【 期間 】 即稼動可能   【 報酬体系 】 40,000円/1アポイント ※契約金額（税込）からシステム利用料を差し引いた金額が、ワーカーさまの受取金額となります。 ※スキル・ご経験に応じて柔軟に設計させていただきます。  【重視する点／歓迎スキル・経験】 必須ではありませんが、以下に該当する方は歓迎します。 BtoB向けテレアポ／IS業務の実務経験 電話での法人対応に抵抗がない方・課題ヒアリング型の営業経験 Slackでの業務コミュニケーション経験 基本的なビジネスマナー・コミュニケーション力 PC操作が可能な方（CRM入力、オンライン対応） 業務委託として一定の自走ができる方  【備考】 トークスクリプト 架電リスト：あり CTIツール：あり マニュアル・オンボーディング：あり 商材理解・ターゲット設計が整理された状態でスタートできます  【 応募方法 】 ・簡単な自己紹介や実績をご提示ください。    営業代行 法人向けの太陽光、蓄電池の導入 └アポイントの確得を行っており、 稼働を行う中で、   リスト数  ペンディング状態となるため、   製造業サーす  オンライン特化のBPOサービス  成果報酬案件  サブスク特化方の決済サービス └成果報酬　2万円 固定報酬　  経理、DX部門関係、月次の    3月2週目〜末にかけて、案件が入ってきそう └ 企業方DC 確定拠出年金  その他ご質問等ありましたら、お気軽にお問い合わせください。 ご応募をお待ちしております！ 下記の内容でアプローチしそのまま打ち合わせの流れになった 【会社概要】 株式会社SoloptiLinkは「営業の最適解を、すべての業界に」をミッションに、AI×人材を融合した営業支援・営業代行事業を展開しております。  テレマーケティング、インサイドセールス、営業戦略設計までを一気通貫で支援し、継続的な売上創出体制の構築を得意としております。  【対応条件／料金体系】  ・架電単価：1コール70円 ・月間5万件規模の継続架電体制構築可能  ※上記以外の追加費用は一切いただきません。 ※費用対効果が合わない場合は、契約見直しも柔軟に対応いたします。  【稼働開始スケジュール】  ・契約後 最短2週間で稼働開始可能 リスト設計、スクリプト調整、テスト架電を経て本稼働へ移行いたします。  【対応領域】  ■ BtoB営業支援 ・法人向けサービス新規開拓 ・アポイント創出／商談設定 ・インサイドセールス代行  ■ BtoC営業支援 ・個人向け商材販売促進 ・イベント／催事送客 ・反響追客架電  商材特性に応じたトーク設計・ターゲティングが可能です。  【導入・取引実績】  ・株式会社フォーバル ・株式会社ライトアップ ・日本エコシステム株式会社 ・シャープ株式会社 ・長州産業株式会社 ・他1000社以上との取引実績  【営業支援成果】  ・人件費 1/8 削減 ・開始2ヶ月でアポ数400％達成 ・10ヶ月で売上1億円以上創出  【運用実績】  ・月間5万コールの対応実績あり 継続案件において、大規模母集団への安定的な架電運用を実施しております。  【運用品質・管理体制】  ・全架電録音対応 ・通話ログ共有可能 ・日次／週次／月次レポート提出 ・KPI（通話数・接続率・アポ率）可視化  運用状況を透明化し、改善提案まで一体で実施いたします。  【当社の強み】  ① 継続運用前提の営業体制構築 単発支援ではなく、KPI設計を行い長期成果を創出。  ② 大量架電×品質担保 量と質を両立した営業活動が可能。  ③ トークスクリプト最適化 ABテストにより反応率を継続改善。  ④ コンサルティング連動 ターゲット戦略・販売導線設計まで伴走。  これまでの営業支援実績とコンサルティングノウハウを活かし、貴社の売上拡大に向けた継続的な営業基盤構築に貢献いたします。  詳細な体制・実績については添付資料をもとにご説明可能です。 ぜひ一度お打ち合わせの機会をいただけますと幸いです。  何卒よろしくお願い申し上げます。', NULL, NULL, NULL, '新しい案件確認', '2026-03-09'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '56bddcbf-6461-4d05-bbed-9e5846c96ea3', '49e9c286-37fe-4f85-99e6-accfda0d5351', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', '失注', 'AIテレアポの代行サービスの提案を行ったが、 ターゲットが少ない状況で、対応が難しいと鼻足が前に進まない サービス自体はいいが、', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '6675c1ad-09d6-4e98-ba8b-d3a4e0a864a0', '49e9c286-37fe-4f85-99e6-accfda0d5351', 2, '2026-02-20', '00000000-0000-0000-0000-000000000001', '失注', 'AIテレアポの代行サービスの提案を行ったが、 ターゲットが少ない状況で、対応が難しいと鼻足が前に進まない サービス自体はいいが、', NULL, NULL, NULL, NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '31cd62ac-bba3-4131-85e8-039595d2a6a2', 'b83f0476-6199-4e7d-9bb1-a4d758afdf87', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'C', '最終的に、いいなと思うサービスは営業代行 2月中申し込みで、初期費用5万円と伝え済み  最終回答をもらう   歯医者の取引先が多い MEO 採用 クリエイティブ   新規リード開拓 紹介が多い  件数が落ちてしまう └テレアポは 気合いと根性が必要で、 できる人材がいない └テレアポ人員がいない  案件対応リソース └ウェブサイトのリソースの問題がある マップの対策  手がかからないことはないが、 ウェブサイトの部分になると、工数の問題  増えれば、', NULL, NULL, NULL, '回答', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a88a9727-0b6a-4b60-9040-3b4fe465a7d5', 'b83f0476-6199-4e7d-9bb1-a4d758afdf87', 2, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'C', '最終的に、いいなと思うサービスは営業代行 2月中申し込みで、初期費用5万円と伝え済み  最終回答をもらう   歯医者の取引先が多い MEO 採用 クリエイティブ   新規リード開拓 紹介が多い  件数が落ちてしまう └テレアポは 気合いと根性が必要で、 できる人材がいない └テレアポ人員がいない  案件対応リソース └ウェブサイトのリソースの問題がある マップの対策  手がかからないことはないが、 ウェブサイトの部分になると、工数の問題  増えれば、', NULL, NULL, NULL, '回答', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '43157daa-6001-4ad1-be39-06799740fbcd', '03e6579c-3330-4a0f-ba02-b84ea1bbc301', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'A', '商談サマリー  企業名：株式会社未来ホーム 担当：宮崎 真人様 議題：AIテレアポ導入およびアライアンス営業強化  1. 結論  未来ホーム様は AIテレアポ導入の方向で前向きに検討中。  初期費用：20万円  月額費用：20万円  契約期間：6ヶ月  今月中の契約希望  Chatworkにて再接続し、契約締結へ進める。  2. 事業背景・営業戦略 ■ 事業モデル  住宅総合リフォーム  塗装・外装関連  太陽光販売会社等との提携  ボランタリーチェーン構築  アライアンス営業担当として展開  ■ 特徴  無料ビジネスマッチング実施  既存顧客を抱える企業（塗装会社・太陽光販売会社）と提携  既存顧客へのアライアンス営業を強化  3. 課題 ■ 市場課題  悪質業者の増加  顧客接触の質の担保が必要  ■ 営業課題  月1,000件アポが理想  現状 約700件  不足分300件をAIで補完したい  ■ 組織体制  30〜40名体制  4. 現在の施策 ■ 既存営業  既存顧客への点検・メンテナンス架電  塗装アフター点検アポ取得  ■ ディグロス検討中  火曜日に契約判断予定。  ディグロス条件  月額23万円  システム利用料：7.5万円  通話料：15.5万円  単価：1秒0.3円  月8,000コール想定  留守電：1.5円  データ例：  留守電 85件  67件留守電／14件会話  71件中51件留守電（差分不明）  ※最初のスケジュール調整までをディグロスが対応。  5. AIテレアポ導入目的  月間不足分300件の補完  アポ最大化  成果次第でアカウント増設予定  将来的に拡張前提の運用  6. 今後の動き  Chatworkで再接続  予算提示  契約条件確定  今月中契約目標  導入スケジュール策定  7. 戦略的整理（提案視点）  未来ホーム様は  アライアンス型営業  既存顧客活用  既存リスト営業  組織30名以上  という「量を取れる土台」がある企業。  AI導入は効率化ではなく拡張フェーズ。  月1,000件アポが取れるモデルに到達すれば、 ボランタリーチェーン拡大の加速装置になる。', NULL, NULL, NULL, '契約書を巻く', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7a6daa17-486f-47bb-8531-a47c147d443b', '03e6579c-3330-4a0f-ba02-b84ea1bbc301', 2, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'A', '商談サマリー  企業名：株式会社未来ホーム 担当：宮崎 真人様 議題：AIテレアポ導入およびアライアンス営業強化  1. 結論  未来ホーム様は AIテレアポ導入の方向で前向きに検討中。  初期費用：20万円  月額費用：20万円  契約期間：6ヶ月  今月中の契約希望  Chatworkにて再接続し、契約締結へ進める。  2. 事業背景・営業戦略 ■ 事業モデル  住宅総合リフォーム  塗装・外装関連  太陽光販売会社等との提携  ボランタリーチェーン構築  アライアンス営業担当として展開  ■ 特徴  無料ビジネスマッチング実施  既存顧客を抱える企業（塗装会社・太陽光販売会社）と提携  既存顧客へのアライアンス営業を強化  3. 課題 ■ 市場課題  悪質業者の増加  顧客接触の質の担保が必要  ■ 営業課題  月1,000件アポが理想  現状 約700件  不足分300件をAIで補完したい  ■ 組織体制  30〜40名体制  4. 現在の施策 ■ 既存営業  既存顧客への点検・メンテナンス架電  塗装アフター点検アポ取得  ■ ディグロス検討中  火曜日に契約判断予定。  ディグロス条件  月額23万円  システム利用料：7.5万円  通話料：15.5万円  単価：1秒0.3円  月8,000コール想定  留守電：1.5円  データ例：  留守電 85件  67件留守電／14件会話  71件中51件留守電（差分不明）  ※最初のスケジュール調整までをディグロスが対応。  5. AIテレアポ導入目的  月間不足分300件の補完  アポ最大化  成果次第でアカウント増設予定  将来的に拡張前提の運用  6. 今後の動き  Chatworkで再接続  予算提示  契約条件確定  今月中契約目標  導入スケジュール策定  7. 戦略的整理（提案視点）  未来ホーム様は  アライアンス型営業  既存顧客活用  既存リスト営業  組織30名以上  という「量を取れる土台」がある企業。  AI導入は効率化ではなく拡張フェーズ。  月1,000件アポが取れるモデルに到達すれば、 ボランタリーチェーン拡大の加速装置になる。', NULL, NULL, NULL, '契約書を巻く', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '3231c549-b1cb-4771-b826-bda6b6f364b6', '46ad1712-1afc-4c19-8f10-233d9d739bbc', 1, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'A', '【商談サマリー】 株式会社ゆいち様 × 営業代行契約内容整理 1. 契約概要  ■ 契約内容 営業代行業務（新規開拓特化）  ■ 契約条件  初期費用：20万円  月額費用：35万円  契約期間：3ヶ月（合計125万円）  ■ 目的 新規営業体制の構築および安定した商談創出  2. 背景・現状課題  これまで紹介中心で事業運営  コミュニティ経由の集客はやり切った状況  新規営業を本格的に強化したい  社内に営業専任体制が整っていない  → 新規リード創出の仕組み化が急務  3. 目標設計  短期目標（3ヶ月）  月3〜4件の商談創出  合計10件前後のアポイント獲得  LTV想定  1社あたり100万〜200万円  → 1件受注で十分ペイする構造 → 2件以上でROI大幅プラス  4. ターゲット業界  以下の業界を重点ターゲットとする：  造園業  製造業  商社  水道事業者  建設業  施工業者  その他、管理部門が未整備な中小企業  5. ターゲット企業の特徴  管理部門が明確に存在しない  受発注管理がアナログ  書類作成が煩雑  PC活用が十分でない  現場優先で管理業務が後回し  アプローチ先  社長ではなく  社内の管理業務責任者  総務的ポジション  実務責任者層  6. 商材内容  LP制作  アプリ開発  業務効率化支援  アポ獲得フック → 「無料アプリ制作」提案  入り口を無料にすることで、 商談化率を高める戦略。  7. 営業戦略設計 ① リスト設計  上記業界の中小企業抽出  管理業務課題を持ちそうな企業を優先  地域選定は別途協議  ② トーク設計  無料アプリ提案  受発注効率化の仮説提示  現状ヒアリング型アポ取得  ③ KPI設計（想定） 指標        目標 架電数        月1,500〜2,000件 接続率        10〜15% アポ率        0.5〜1% 月間アポ        3〜4件  ※3ヶ月で10件前後を目標  8. 今後のスケジュール  金曜日：最終条件調整  契約書送付  契約締結後即稼働  9. 連絡先情報  担当：畑中 雄一郎様 メール：yuichiro.hatanaka@yuichiinc.com  電話：080-1703-1603  総括  本案件は、  LTVが高い  受注1件で黒字化可能  3ヶ月で十分勝負可能  という非常に健全な案件構造。  新規営業の仕組み構築が成功すれば、 紹介依存からの脱却が可能となる。', NULL, NULL, NULL, '契約書を巻く', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '4a22f732-4c69-48ed-88de-acaa414d5456', '46ad1712-1afc-4c19-8f10-233d9d739bbc', 2, '2026-02-20', '00000000-0000-0000-0000-000000000001', 'A', '【商談サマリー】 株式会社ゆいち様 × 営業代行契約内容整理 1. 契約概要  ■ 契約内容 営業代行業務（新規開拓特化）  ■ 契約条件  初期費用：20万円  月額費用：35万円  契約期間：3ヶ月（合計125万円）  ■ 目的 新規営業体制の構築および安定した商談創出  2. 背景・現状課題  これまで紹介中心で事業運営  コミュニティ経由の集客はやり切った状況  新規営業を本格的に強化したい  社内に営業専任体制が整っていない  → 新規リード創出の仕組み化が急務  3. 目標設計  短期目標（3ヶ月）  月3〜4件の商談創出  合計10件前後のアポイント獲得  LTV想定  1社あたり100万〜200万円  → 1件受注で十分ペイする構造 → 2件以上でROI大幅プラス  4. ターゲット業界  以下の業界を重点ターゲットとする：  造園業  製造業  商社  水道事業者  建設業  施工業者  その他、管理部門が未整備な中小企業  5. ターゲット企業の特徴  管理部門が明確に存在しない  受発注管理がアナログ  書類作成が煩雑  PC活用が十分でない  現場優先で管理業務が後回し  アプローチ先  社長ではなく  社内の管理業務責任者  総務的ポジション  実務責任者層  6. 商材内容  LP制作  アプリ開発  業務効率化支援  アポ獲得フック → 「無料アプリ制作」提案  入り口を無料にすることで、 商談化率を高める戦略。  7. 営業戦略設計 ① リスト設計  上記業界の中小企業抽出  管理業務課題を持ちそうな企業を優先  地域選定は別途協議  ② トーク設計  無料アプリ提案  受発注効率化の仮説提示  現状ヒアリング型アポ取得  ③ KPI設計（想定） 指標        目標 架電数        月1,500〜2,000件 接続率        10〜15% アポ率        0.5〜1% 月間アポ        3〜4件  ※3ヶ月で10件前後を目標  8. 今後のスケジュール  金曜日：最終条件調整  契約書送付  契約締結後即稼働  9. 連絡先情報  担当：畑中 雄一郎様 メール：yuichiro.hatanaka@yuichiinc.com  電話：080-1703-1603  総括  本案件は、  LTVが高い  受注1件で黒字化可能  3ヶ月で十分勝負可能  という非常に健全な案件構造。  新規営業の仕組み構築が成功すれば、 紹介依存からの脱却が可能となる。', NULL, NULL, NULL, '契約書を巻く', '2026-02-20'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f64ef494-c641-4a72-a54b-8f40aa9d67b8', 'e0570c49-5ceb-4ae2-853d-b0e634152096', 1, '2026-02-22', '00000000-0000-0000-0000-000000000001', '代理店A', '月2万円のサービスの提案をもらう 令和の虎の井口さんのオンラインサロンで、2200名会員がいる状況で、その会員を集めて、小貫のPRを行って頂ける そこで、AIテレアポの営業代行の提案を行う方向性で進んでいる状況 3月7日で、セミナー開催予定', NULL, NULL, NULL, '状況確認', '2026-03-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '7b8a5844-cd07-4524-b3e9-02c93892b9f6', 'e0570c49-5ceb-4ae2-853d-b0e634152096', 2, '2026-02-22', '00000000-0000-0000-0000-000000000001', '代理店A', '月2万円のサービスの提案をもらう 令和の虎の井口さんのオンラインサロンで、2200名会員がいる状況で、その会員を集めて、小貫のPRを行って頂ける そこで、AIテレアポの営業代行の提案を行う方向性で進んでいる状況 3月7日で、セミナー開催予定', NULL, NULL, NULL, '状況確認', '2026-03-04'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '55e070cd-5d5d-4733-a4ed-e5fa395723fb', '12e85160-823a-435a-b911-26a413ae3696', 1, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', '"【商談サマリー】森沢薬品様  作成日：XXXX年XX月XX日 担当：小貫  西山さんはいろいろな会社の代表を行っており、投資家でもあり、買収を行えるほどの資産を持っている  1. 商談概要  森沢薬品様より、AIテレアポサービス導入について前向きな検討をいただいており、 最終的には代表者様へご紹介のうえ、改めて正式な打ち合わせを実施する流れとなった。  次回は代表同席の上で再商談を行うため、日程調整を進める。  2. AIテレアポ導入検討背景 ■ 現状課題  無駄な営業活動に時間を割いている  リスト購入後、自社でアポを取る体制を構築したい  代理店獲得・ラインツール販売を強化したい  効率的な営業チャネルを確立したい  ■ 方向性  AIテレアポを活用し、 「自社主導のアポ獲得モデル」へ転換  外部依存型ではなく、再現性ある営業体制構築を目指す  3. 事業展開・ネットワーク状況  森沢薬品様は多角的事業を展開。  ■ 主な事業領域  医療機器  医薬品  医療法人関連  就労支援事業（北海道：約300名規模）  不動産事業  映像制作（新大阪）  海外法人（香港に1社）  SEO会社を買収（現在財務改善が必要な状況）  ※SEO会社は黒字倒産リスクがあり、 2番手ポジションの会社が独立意向あり。  4. 百貨店・量販店展開構想  大丸百貨店との取引関係から紹介を受けた経緯あり。  今後の展開として、  ドン・キホーテ  キリン堂  八日堂（※確認必要）  大丸百貨店  などの店舗網を活用し、 太陽光販売をヤマダ電機×コジマ型の量販モデルで展開できるのではないか という構想が議論に上がった。  この件は今後、具体的に詰めていく予定。  5. 経営・人的背景  代表は旧三菱銀行出身  高校：香港・ロシア経験あり（国際志向）  海外展開実績あり  北海道で就労支援事業300名規模運営  → 経営規模・資本力・拡張性は十分。  6. 今後の営業機会 ■ 検討テーマ  AIテレアポ導入  代理店獲得モデル構築  ラインツール販売拡張  太陽光量販店モデル構築  自社主導リスト営業モデル  7. 次回アクション  代表同席の商談日程調整  AIテレアポ具体プラン提示  導入スキーム提示（リスト購入型／代理店獲得型）  太陽光量販モデルの可能性整理  事業横断的な営業DX提案  8. 提案戦略メモ（内部用）  森沢薬品様は  多角経営  海外法人  医療系ネットワーク  小売チャネル接点  人材規模（北海道300名）  を持つため、  単なるAIテレアポ導入ではなく、営業インフラ全体の再設計提案が有効。  特に、  医療法人向け営業自動化  就労支援×代理店モデル  百貨店チャネル活用型太陽光販売  海外展開支援  まで視野に入れた包括提案が望ましい。"', NULL, NULL, NULL, '日程調整', '2026-02-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '73326c42-4c2b-4775-a034-dbd678de1148', '12e85160-823a-435a-b911-26a413ae3696', 2, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', '"【商談サマリー】森沢薬品様  作成日：XXXX年XX月XX日 担当：小貫  西山さんはいろいろな会社の代表を行っており、投資家でもあり、買収を行えるほどの資産を持っている  1. 商談概要  森沢薬品様より、AIテレアポサービス導入について前向きな検討をいただいており、 最終的には代表者様へご紹介のうえ、改めて正式な打ち合わせを実施する流れとなった。  次回は代表同席の上で再商談を行うため、日程調整を進める。  2. AIテレアポ導入検討背景 ■ 現状課題  無駄な営業活動に時間を割いている  リスト購入後、自社でアポを取る体制を構築したい  代理店獲得・ラインツール販売を強化したい  効率的な営業チャネルを確立したい  ■ 方向性  AIテレアポを活用し、 「自社主導のアポ獲得モデル」へ転換  外部依存型ではなく、再現性ある営業体制構築を目指す  3. 事業展開・ネットワーク状況  森沢薬品様は多角的事業を展開。  ■ 主な事業領域  医療機器  医薬品  医療法人関連  就労支援事業（北海道：約300名規模）  不動産事業  映像制作（新大阪）  海外法人（香港に1社）  SEO会社を買収（現在財務改善が必要な状況）  ※SEO会社は黒字倒産リスクがあり、 2番手ポジションの会社が独立意向あり。  4. 百貨店・量販店展開構想  大丸百貨店との取引関係から紹介を受けた経緯あり。  今後の展開として、  ドン・キホーテ  キリン堂  八日堂（※確認必要）  大丸百貨店  などの店舗網を活用し、 太陽光販売をヤマダ電機×コジマ型の量販モデルで展開できるのではないか という構想が議論に上がった。  この件は今後、具体的に詰めていく予定。  5. 経営・人的背景  代表は旧三菱銀行出身  高校：香港・ロシア経験あり（国際志向）  海外展開実績あり  北海道で就労支援事業300名規模運営  → 経営規模・資本力・拡張性は十分。  6. 今後の営業機会 ■ 検討テーマ  AIテレアポ導入  代理店獲得モデル構築  ラインツール販売拡張  太陽光量販店モデル構築  自社主導リスト営業モデル  7. 次回アクション  代表同席の商談日程調整  AIテレアポ具体プラン提示  導入スキーム提示（リスト購入型／代理店獲得型）  太陽光量販モデルの可能性整理  事業横断的な営業DX提案  8. 提案戦略メモ（内部用）  森沢薬品様は  多角経営  海外法人  医療系ネットワーク  小売チャネル接点  人材規模（北海道300名）  を持つため、  単なるAIテレアポ導入ではなく、営業インフラ全体の再設計提案が有効。  特に、  医療法人向け営業自動化  就労支援×代理店モデル  百貨店チャネル活用型太陽光販売  海外展開支援  まで視野に入れた包括提案が望ましい。"', NULL, NULL, NULL, '日程調整', '2026-02-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '75878c5b-ba17-4d8f-a7e3-9c296485f12c', '4a2ab2dc-6e74-46d8-9194-5ebaee2d9aa0', 1, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポのサービスに関しては、他の会社で、ご紹介いただける可能性あり AIのスーパーAIみたいなサービスで、要件定義を投げたら、最後まで開発を進めてしまうエージェントを開発を行っており、世界トップクラスのエンジニアがこれを作っているため、次回この話を伺いたいという状況で話が終わった 代理店展開というよりかは、この商材は、人を選び提供のため、次回その話を伺う', NULL, NULL, NULL, '日程調整', '2026-02-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '00b06291-d1ca-4791-bd7b-4b6adadbac25', '4a2ab2dc-6e74-46d8-9194-5ebaee2d9aa0', 2, '2026-02-22', '00000000-0000-0000-0000-000000000001', 'C', 'AIテレアポのサービスに関しては、他の会社で、ご紹介いただける可能性あり AIのスーパーAIみたいなサービスで、要件定義を投げたら、最後まで開発を進めてしまうエージェントを開発を行っており、世界トップクラスのエンジニアがこれを作っているため、次回この話を伺いたいという状況で話が終わった 代理店展開というよりかは、この商材は、人を選び提供のため、次回その話を伺う', NULL, NULL, NULL, '日程調整', '2026-02-26'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '291c409e-278a-4b90-88b9-b40d2dd35cfb', '8563615c-4a8a-4c9e-9bb0-4f79bbf14356', 1, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'A', '株式会社Think Up ご担当：高嶋 克成 様 商談テーマ：営業代行（AI活用型アウトバウンド支援）  1. 営業代行契約内容（確定事項） ■ 開始時期  2025年5月開始  ■ 契約条件  初期費用：20万円  月額費用：20万円  契約期間：3ヶ月契約  コール数：2,500コール  ■ 今後の流れ  4月中に架電対象リストを確定  契約書送付  契約締結後、準備開始  5月より本稼働  2. Think Up社の現状整理 ■ 現在の事業状況  月売上：約80万円  AI営業代行サービスを展開中  今回の営業代行導入は、 リード獲得の安定化および事業スケールの加速を目的とした施策。  3. 協業体制  双方にとって良好な協業関係を構築できる見込み。 単なるコール代行ではなく、  AI活用型の営業戦略設計  リスト精度改善  トークブラッシュアップ  月次振り返り（PDCA）  を含めた伴走型支援として進行予定。  4. 参考情報（アイドマ契約状況） ■ 過去契約実績  契約期間：2年間  契約件数：約26,000件  総額：約720万円  月額：約15万円（税別）  月間約1,100件架電  月1回MTG実施  2025年7月開始契約  2年間で12,000件予定  現在8,600件実施済み  ※今回の契約は、 月2,500コールで月額20万円という条件であり、 過去条件と比較しても費用対効果を意識した設計。  5. 今回契約の戦略的意義  現在売上80万円 → 安定的なリード供給体制構築  AI営業代行サービスの拡販  協業による相互送客の可能性  将来的なLTV最大化の布石  次アクション  4月：架電リスト決定  契約書送付・締結  トーク設計・リスト整備  5月本格稼働', NULL, NULL, NULL, '契約書回収', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'f293276a-fb98-4454-817f-8f98d88286e6', '8563615c-4a8a-4c9e-9bb0-4f79bbf14356', 2, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'A', '株式会社Think Up ご担当：高嶋 克成 様 商談テーマ：営業代行（AI活用型アウトバウンド支援）  1. 営業代行契約内容（確定事項） ■ 開始時期  2025年5月開始  ■ 契約条件  初期費用：20万円  月額費用：20万円  契約期間：3ヶ月契約  コール数：2,500コール  ■ 今後の流れ  4月中に架電対象リストを確定  契約書送付  契約締結後、準備開始  5月より本稼働  2. Think Up社の現状整理 ■ 現在の事業状況  月売上：約80万円  AI営業代行サービスを展開中  今回の営業代行導入は、 リード獲得の安定化および事業スケールの加速を目的とした施策。  3. 協業体制  双方にとって良好な協業関係を構築できる見込み。 単なるコール代行ではなく、  AI活用型の営業戦略設計  リスト精度改善  トークブラッシュアップ  月次振り返り（PDCA）  を含めた伴走型支援として進行予定。  4. 参考情報（アイドマ契約状況） ■ 過去契約実績  契約期間：2年間  契約件数：約26,000件  総額：約720万円  月額：約15万円（税別）  月間約1,100件架電  月1回MTG実施  2025年7月開始契約  2年間で12,000件予定  現在8,600件実施済み  ※今回の契約は、 月2,500コールで月額20万円という条件であり、 過去条件と比較しても費用対効果を意識した設計。  5. 今回契約の戦略的意義  現在売上80万円 → 安定的なリード供給体制構築  AI営業代行サービスの拡販  協業による相互送客の可能性  将来的なLTV最大化の布石  次アクション  4月：架電リスト決定  契約書送付・締結  トーク設計・リスト整備  5月本格稼働', NULL, NULL, NULL, '契約書回収', '2026-02-25'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'ec02374f-9d04-4a07-9222-af27fa29b36d', '090a61c2-5120-4739-82c1-caaab473e1fd', 1, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'B', '会社名：HIROTSUバイオサイエンス 初期費用20万円　月額20万円の2500件プランで検討中  ご担当：紺野様 議題：フォームAI／営業代行導入検討  1. 事業概要（確認事項）  HIROTSUバイオサイエンスは、線虫を活用したがんリスク検査「N-NOSE」を展開。  世界初の技術  特許22件取得  累計100万人受検、約2,500社導入実績  ステージ1段階でのがんリスク検知を目指す検査技術  ※顔認証等ではなく、「がんになる可能性」を早期に検知するアプローチ。  2. 現在の営業状況・課題 ■ 営業チャネル  法人営業中心（福利厚生導入）  健康診断の一環として導入  ■ 主なターゲット  40代以上の従業員が多い企業  製造業  建設業  農協  保険会社  ■ 導入規模  5名規模〜数千名規模まで幅広い  継続率：約60〜70%  3. 現在の課題 ① アップセルテクノロジー活用中  アポイントは一定数上がる  しかし契約率が約1%  商談化後の歩留まりが極めて低い  営業効率が悪化している状況  ② 課題の本質（整理）  アポの「質」に課題がある可能性  商談設計／事前ナーチャリング不足  ターゲット精度と訴求軸のズレ  4. 提案検討内容  下記いずれかの導入を前向きに検討したいとのこと。  【A】フォームAI  初期費用：5万円  月額：5万円  目的：  精度の高いターゲットへのアプローチ  問い合わせフォーム経由での質の高いリード創出  テレアポに依存しないチャネル構築  【B】営業代行  初期費用：20万円  月額：35万円  契約期間：3ヶ月  目的：  法人新規アポイント創出  ターゲット再設計  商談前ヒアリング精度向上  契約率改善  5. 今後の方向性  録音データ共有予定  テレアポ資料確認予定  現行スクリプト精査  → 契約率1%のボトルネック特定を実施  6. 戦略的示唆（整理）  現状は「量はあるが、質が弱い」状態。  改善アプローチとしては：  ターゲット再定義（業種×従業員年齢構成×健康経営意識）  商談前教育（動画・資料・事例共有）  導入ROIの明確化（離職率低下／企業ブランディング）  経営層への直打ちチャネル構築  次回アクション  録音データ確認  現行資料レビュー  契約率改善プラン提示  フォームAI／営業代行の最適プラン提案', NULL, NULL, NULL, '検討結果確認', '2026-02-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'd063bf57-89db-40c7-ab0f-38259616efc1', '090a61c2-5120-4739-82c1-caaab473e1fd', 2, '2026-02-24', '00000000-0000-0000-0000-000000000001', 'B', '会社名：HIROTSUバイオサイエンス 初期費用20万円　月額20万円の2500件プランで検討中  ご担当：紺野様 議題：フォームAI／営業代行導入検討  1. 事業概要（確認事項）  HIROTSUバイオサイエンスは、線虫を活用したがんリスク検査「N-NOSE」を展開。  世界初の技術  特許22件取得  累計100万人受検、約2,500社導入実績  ステージ1段階でのがんリスク検知を目指す検査技術  ※顔認証等ではなく、「がんになる可能性」を早期に検知するアプローチ。  2. 現在の営業状況・課題 ■ 営業チャネル  法人営業中心（福利厚生導入）  健康診断の一環として導入  ■ 主なターゲット  40代以上の従業員が多い企業  製造業  建設業  農協  保険会社  ■ 導入規模  5名規模〜数千名規模まで幅広い  継続率：約60〜70%  3. 現在の課題 ① アップセルテクノロジー活用中  アポイントは一定数上がる  しかし契約率が約1%  商談化後の歩留まりが極めて低い  営業効率が悪化している状況  ② 課題の本質（整理）  アポの「質」に課題がある可能性  商談設計／事前ナーチャリング不足  ターゲット精度と訴求軸のズレ  4. 提案検討内容  下記いずれかの導入を前向きに検討したいとのこと。  【A】フォームAI  初期費用：5万円  月額：5万円  目的：  精度の高いターゲットへのアプローチ  問い合わせフォーム経由での質の高いリード創出  テレアポに依存しないチャネル構築  【B】営業代行  初期費用：20万円  月額：35万円  契約期間：3ヶ月  目的：  法人新規アポイント創出  ターゲット再設計  商談前ヒアリング精度向上  契約率改善  5. 今後の方向性  録音データ共有予定  テレアポ資料確認予定  現行スクリプト精査  → 契約率1%のボトルネック特定を実施  6. 戦略的示唆（整理）  現状は「量はあるが、質が弱い」状態。  改善アプローチとしては：  ターゲット再定義（業種×従業員年齢構成×健康経営意識）  商談前教育（動画・資料・事例共有）  導入ROIの明確化（離職率低下／企業ブランディング）  経営層への直打ちチャネル構築  次回アクション  録音データ確認  現行資料レビュー  契約率改善プラン提示  フォームAI／営業代行の最適プラン提案', NULL, NULL, NULL, '検討結果確認', '2026-02-27'
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  '084de0bb-4cb5-43a8-b58f-5fa28e762bb2', 'e716554c-3859-4ab4-8c11-d9b3b534fa42', 1, '2026-02-25', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・利用カウンセラー協会 代表理事 安河内恵美氏（エミー） ・美容クリニック（保険診療＋自費、美容専門双方）向けに研修・人材育成サービスを展開 ・新規開拓は紹介・口コミ・SNS中心。テレアポやフォーム営業は未実施 ・業界は閉鎖的で、院長につながる営業は基本的に遮断されるとの認識 ・自身が受付経験あり、営業を断る立場だったため、電話営業の通過率は極めて低いと実感 ・営業代行（AI活用型）については紹介経由で情報収集目的で面談参加  【課題】 ・美容クリニックは受付突破が非常に困難 ・テレアポや飛び込み、代表メール経由の接触はほぼ見られない／つながらない可能性大 ・ゼロイチでの新規開拓は難易度が高いとの認識 ・信頼関係構築型であれば高確率で受注できるが、接点創出がボトルネック  【提案サービス】 ・AI活用型営業代行サービス（新規開拓支援／受付突破特化型テレアポ代行）  ※美容院での実績はあるが、クリニック・一般病院での実績は現時点でなし。  【次回アクション】 ・現時点では見送り ・クリニック領域での実績・事例が出た場合に再提案予定 ・将来的に協業（紹介ベース・レベニューシェア型）の可能性があれば検討余地あり', NULL, NULL, 'テレアポしてない', NULL, NULL
);
INSERT INTO deal_followups (id, deal_id, followup_number, followup_date, assignee_id, status, note, email_content, email_attachment, loss_reason, next_action, next_action_date) VALUES (
  'a1395c13-1cc2-4e0f-87ee-1777058686f3', 'e716554c-3859-4ab4-8c11-d9b3b534fa42', 2, '2026-02-25', '00000000-0000-0000-0000-000000000002', '失注', '【ヒアリング内容】 ・利用カウンセラー協会 代表理事 安河内恵美氏（エミー） ・美容クリニック（保険診療＋自費、美容専門双方）向けに研修・人材育成サービスを展開 ・新規開拓は紹介・口コミ・SNS中心。テレアポやフォーム営業は未実施 ・業界は閉鎖的で、院長につながる営業は基本的に遮断されるとの認識 ・自身が受付経験あり、営業を断る立場だったため、電話営業の通過率は極めて低いと実感 ・営業代行（AI活用型）については紹介経由で情報収集目的で面談参加  【課題】 ・美容クリニックは受付突破が非常に困難 ・テレアポや飛び込み、代表メール経由の接触はほぼ見られない／つながらない可能性大 ・ゼロイチでの新規開拓は難易度が高いとの認識 ・信頼関係構築型であれば高確率で受注できるが、接点創出がボトルネック  【提案サービス】 ・AI活用型営業代行サービス（新規開拓支援／受付突破特化型テレアポ代行）  ※美容院での実績はあるが、クリニック・一般病院での実績は現時点でなし。  【次回アクション】 ・現時点では見送り ・クリニック領域での実績・事例が出た場合に再提案予定 ・将来的に協業（紹介ベース・レベニューシェア型）の可能性があれば検討余地あり', NULL, NULL, 'テレアポしてない', NULL, NULL
);

-- ============================================================
-- 7. AI Tool Orders
-- ============================================================
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '96f7833d-4807-4a6c-aaff-b0f9afb7c3fe', '20839b67-edef-4a3b-a466-01b0a0c3cc5f', '平田さん紹介', '2025-12-31', '契約完了', NULL, '2026-01-30', '2025-12-31', 50000, 0, '{"ai_teleapo":0,"form_sales_ai":50000,"l_sync":0,"list_gen_ai":30000,"president_copy_ai":0,"card_follow_ai":30000,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":15000,"l_sync_margin":0,"list_gen_ai_margin":15000,"president_copy_ai_margin":0,"card_follow_ai_margin":15000,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'd5347dde-58a3-4f7c-851d-7bf7be081ab4', '9c1a6d99-9e53-4f7d-90ae-3f43ee67409b', '小貫リファラル', '2026-02-02', '契約完了', NULL, '2026-02-10', '2026-02-02', 0, 100000, '{"ai_teleapo":200000,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":40000,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'f2797281-4b86-463a-b511-9a6dbf70ce5e', 'e443bd34-c1f6-47ff-a5ca-926f88f443b3', 'ランサーズ', '2025-12-31', '契約完了', NULL, '2026-01-30', '2025-12-31', 50000, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":30000,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":30000,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":15000,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":15000,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'fb13cf78-4091-4081-9c30-ac606a56a801', '72432d0e-2231-4f65-8902-7fe11e146329', '小貫リファラル', '2026-01-09', '契約完了', NULL, '2026-01-30', '2026-01-09', 100000, 100000, '{"ai_teleapo":200000,"form_sales_ai":0,"l_sync":10000,"list_gen_ai":30000,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":40000,"form_sales_ai_margin":0,"l_sync_margin":3000,"list_gen_ai_margin":15000,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'ec6ca5f9-f710-4c1d-a879-10d373fd4118', 'a8307135-d901-4a3d-ae6f-ece5a49635f0', 'クラウドワークス', '2026-02-09', '契約完了', NULL, '2026-02-06', '2026-02-09', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":30000,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":15000,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'e7eaf85e-12a4-40a8-a879-62fcd94fcfa8', '45ad2dc7-cf01-40ef-b56c-7013cfd5e33f', '平田さん紹介', '2026-02-09', '送信済み', NULL, '2026-02-06', '2026-02-09', 0, 0, '{"ai_teleapo":0,"form_sales_ai":50000,"l_sync":0,"list_gen_ai":30000,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":15000,"l_sync_margin":0,"list_gen_ai_margin":15000,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '26c72f2f-b6fd-48c9-ab3a-b26546580c86', 'd370fcf4-ad95-4143-b3d9-09215f88853c', '(オルガロ)野村さん紹介', '2026-02-09', '契約完了', NULL, '2026-02-06', '2026-02-09', 50000, 0, '{"ai_teleapo":0,"form_sales_ai":50000,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":15000,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'd5ae93b2-cfcc-4d83-a2f3-64904edca336', '6a04eb32-9802-4c41-b74c-fa38c877edc7', '(オルガロ)野村さん紹介', '2026-02-09', '契約完了', NULL, '2026-02-06', '2026-02-09', 50000, 0, '{"ai_teleapo":0,"form_sales_ai":50000,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":15000,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'd4952807-76aa-46fd-a3bc-035250e6db51', '2afdf017-d683-42d0-ad2b-ab3c93c95b37', 'マイナビリスト', '2026-02-06', '送信済み', NULL, NULL, '2026-02-06', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '45210aa0-92f4-4e14-8041-da5ddb5590e6', '10404e0b-af70-4eac-bce8-37b2189ea9c2', 'マイナビリスト', '2026-02-06', '送信済み', NULL, NULL, '2026-02-06', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '7283dbdc-7589-4e9a-a9e5-d583d63b88b9', '15551ef6-0526-4122-9363-dd2281b8ca64', NULL, '2026-01-23', NULL, NULL, NULL, '2026-01-23', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '45d9da51-4c99-4b29-a9e4-b7b7e74d3cba', '5850258e-a938-4727-95f0-6f7721e9429a', NULL, '2026-01-30', NULL, NULL, NULL, '2026-01-30', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '7c9def47-d9e9-425c-87cf-bf969f66258c', 'dc84c46e-f008-44b3-b2ea-85a5e95107c2', NULL, '2026-01-26', NULL, NULL, NULL, '2026-01-26', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '170db9f5-7f03-431f-8c17-8bacc1029eaf', '7089cba4-7d58-4f72-a0c6-439887ed441c', NULL, '2026-02-02', NULL, NULL, NULL, '2026-02-02', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'a0a72fa6-c3a3-48dc-8b1d-fe8621446a39', 'c50b7a1d-5bd4-410c-8eae-0090fc25273e', NULL, '2026-01-28', NULL, NULL, NULL, '2026-01-28', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '2efcb5e5-e14d-4d45-9b0b-b63bd50ee10c', '90522b13-7ac3-4e46-ac79-9a8b5d832c26', NULL, '2026-01-28', NULL, NULL, NULL, '2026-01-28', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '9b6be882-7599-4846-af09-367b9f17abab', '3d06d475-c1e6-45a7-b041-a882dad05862', NULL, '2026-01-29', NULL, NULL, NULL, '2026-01-29', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '94392bf7-c14a-4f08-8ee3-0e254ad49ab7', '6c2dccf4-c09d-4e8b-913e-6e8854b8aab3', NULL, '2026-01-29', NULL, NULL, NULL, '2026-01-29', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'a2f18f85-8843-4fc7-bcb0-8317c9fc65ca', '1c0f2583-f7da-4ae1-a8d8-2b050a8c9fa8', NULL, '2026-01-29', NULL, NULL, NULL, '2026-01-29', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'aed43802-d675-45bb-85c8-6519ac6ab6de', '99093944-deb5-4c1f-81ba-3460e394ae36', NULL, '2026-01-30', NULL, NULL, NULL, '2026-01-30', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'bc57d0ac-5de2-4f46-bbab-a75a7ecf45b0', '8a431a7b-f875-4c5d-b82e-9109d90a8eaf', NULL, '2026-02-02', NULL, NULL, NULL, '2026-02-02', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'fc365644-24fa-4fed-8c21-4de898615298', 'fabfbbeb-558a-450e-a5a4-35ef1cf323a9', NULL, '2026-02-02', NULL, NULL, NULL, '2026-02-02', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '75f4f8f9-ae39-450e-9ba2-00a519257dc7', 'fb60b87e-0e55-47d7-a448-861ce29f2140', 'マイナビリスト', '2026-02-12', '送信済み', NULL, NULL, '2026-02-12', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'e9ec6574-07ec-4aa9-a7b8-6cb0aa688457', '68e2ad80-528e-41f4-872b-b209889e67eb', 'マイナビリスト', '2026-02-06', NULL, NULL, NULL, '2026-02-06', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  '715db50a-88c3-4d51-95f7-87b166c5194b', 'c55bd7e7-47c8-424b-b8cc-eeada3e6b4bd', 'マイナビリスト', '2026-02-10', '送信済み', NULL, NULL, '2026-02-10', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);
INSERT INTO ai_tool_orders (id, company_id, list_source, verbal_agreement_date, status, cancellation_month, initial_payment_date, monthly_payment_start, initial_fee_lightup, initial_fee_ai_teleapo, monthly_fees, margin_amounts) VALUES (
  'a9f27ad0-766d-487f-a373-511c970801c7', '465a3d78-f860-4f27-a7fd-736f3f31b458', 'マイナビリスト', '2026-02-12', '送信済み', NULL, NULL, '2026-02-12', 0, 0, '{"ai_teleapo":0,"form_sales_ai":0,"l_sync":0,"list_gen_ai":0,"president_copy_ai":0,"card_follow_ai":0,"ai_management":0,"meo":0,"recruitment_ai":0,"hachidori_ai":0,"ai_stepup":0}', '{"ai_teleapo_margin":0,"form_sales_ai_margin":0,"l_sync_margin":0,"list_gen_ai_margin":0,"president_copy_ai_margin":0,"card_follow_ai_margin":0,"ai_management_margin":0,"meo_margin":0,"recruitment_ai_margin":0,"hachidori_ai_margin":0,"ai_stepup_margin":0}'
);

-- ============================================================
-- FK制約を再有効化（コメントアウト）
-- 以下はauth.usersにユーザー作成後に手動で実行してください
-- ============================================================
-- ALTER TABLE users ADD CONSTRAINT users_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id);
-- ALTER TABLE deals ADD CONSTRAINT deals_appointer_id_fkey FOREIGN KEY (appointer_id) REFERENCES users(id);
-- ALTER TABLE deals ADD CONSTRAINT deals_closer_id_fkey FOREIGN KEY (closer_id) REFERENCES users(id);
-- ALTER TABLE deal_followups ADD CONSTRAINT deal_followups_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES users(id);
-- ALTER TABLE activity_logs ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
