# -*- coding:utf-8 -*-
class AddrecordUsers < ActiveRecord::Migration
  def up

           execute "TRUNCATE TABLE users;"
           
          execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (3, '000006', 'KOWA社員SS', NULL, 2, 16, 0, NULL, NULL, 0, NULL, 'kowa11@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (8, '000010', 'KOWAバイト', NULL, 2, 17, 1, NULL, NULL, 0, NULL, 'kowa5@', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (1, '999999', '管理者', 'ｶﾝﾘｼｬ', 1, 1, 0, '2012-10-01 00:00:00', '2012-10-01 00:00:00', 0, NULL, '999999@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 25, '2012-08-23 03:53:53.200407', '2012-08-23 03:00:38.224022', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 03:53:53.201144');
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (4, '000002', 'KOWA専務', NULL, 1, 3, 0, NULL, NULL, 0, NULL, 'kowa1@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL);
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (5, '000003', 'KOWA常務', NULL, 1, 4, 0, NULL, NULL, 0, NULL, 'kowa2@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 1, '2012-08-23 02:54:20.88417', '2012-08-23 02:54:20.88417', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 02:54:20.884906');
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (6, '000004', 'KOWA店長', NULL, 2, 6, 0, NULL, NULL, 0, NULL, 'kowa3@', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 6, '2012-08-23 03:49:14.909155', '2012-08-23 03:46:59.644673', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 03:49:14.909815');
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (7, '000005', 'KOWA社員', NULL, 2, 13, 0, NULL, NULL, 0, NULL, 'kowa4@', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 3, '2012-08-23 03:52:21.380034', '2012-08-23 02:57:57.38074', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 03:52:21.380893');
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (2, '000001', 'KOWA社長', NULL, 1, 2, 0, '2012-10-01 00:00:00', '2012-10-01 00:00:00', 0, NULL, 'kowa@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 5, '2012-08-23 01:03:24.84941', '2012-08-23 01:01:58.312895', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 01:03:24.850083');
           "
           execute "INSERT INTO users (id, account, user_name, user_name_kana, m_shop_id, m_authority_id, user_class, nyusya_date, birthday, deleted_flg, deleted_at, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) VALUES (9, '000011', 'KOWA監査人', NULL, 1, 18, 2, '2012-10-01 00:00:00', '2012-10-01 00:00:00', 0, NULL, 'kowa9@com.jp', '$2a$10$bd976DPdnruu.AxdVcfYjunP7SvbZ/3qyqt.LqflOHAEFwo8U0woq', NULL, NULL, NULL, 5, '2012-08-23 01:03:24.84941', '2012-08-23 01:01:58.312895', '127.0.0.1', '127.0.0.1', NULL, '2012-08-23 01:03:24.850083');
           "
           execute "select setval('users_id_seq',(select max(id) from users));"
           
           execute "TRUNCATE TABLE m_codes;"
           
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (1, 'user_class', '0', '社員', '社員', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (2, 'user_class', '1', '社員以外', '社員以外', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (3, 'user_class', '2', '監査人', '監査人', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (4, 'delete_flg', '0', '通常', '通常', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (5, 'delete_flg', '1', '削除', '削除', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (6, 'shop_kbn', '0', '直営', '直営', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (7, 'shop_kbn', '1', '油外', '油外', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (8, 'tax_flg', '0', '非課税', '非課税', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (9, 'tax_flg', '1', '課税', '課税', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (10, 'umu_flg', '0', '無', '無し', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (11, 'umu_flg', '1', '有', '有り', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (12, 'item_class', '0', '出金', '出金', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (13, 'item_class', '1', '入金', '入金', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (14, 'item_class', '2', 'プリカ', 'プリカ', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (15, 'item_class', '3', '手数料', '手数料', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (16, 'item_class', '4', '他売上', '他売上', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (17, 'input_kbn', '0', '日単位', '日単位', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (18, 'input_kbn', '1', '月単位', '月単位', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (19, 'kakutei_flg', '0', '未確定', '未確定', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (20, 'misumi_flg', '0', '未', '未済', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (21, 'misumi_flg', '1', '済', '済', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (22, 'kakutei_flg', '1', '確定', '確定', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (23, 'audit_class', '0', '自主監査', '自主監査', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (24, 'audit_class', '1', '本監査', '本監査', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (25, 'approve_flg', '2', '却下', '却下', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (26, 'approve_flg', '1', '承認', '承認', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (27, 'approve_flg', '0', '未承認', '未承認', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (28, 'oiletc_group', '0', '油外', '油外', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (29, 'oiletc_group', '1', '他商品', '他商品', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (30, 'oiletc_group', '2', '夢ポイント', '夢ポイント', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (31, 'fix_item_class', '0', '金種別', '金種別', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (32, 'fix_item_class', '1', '一括', '一括', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (33, 'pos_class', '1', 'POS1', 'POS1', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (34, 'pos_class', '2', 'POS2', 'POS2', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (35, 'pos_class', '3', 'POS3', 'POS3', '2012-10-01', '2012-10-01');"           
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (36, 'm_etc_group', '0', '洗用品', '洗用品', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (37, 'm_etc_group', '1', 'ヘルス', 'ヘルス', '2012-10-01', '2012-10-01');"           
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (38, 'm_etc_group', '2', 'スロット', 'スロット', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (39, 'm_etc_group', '3', '充電器', '充電器', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (40, 'm_etc_group', '4', '予備', '予備', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (41, 'tani', '0', '円', '円', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (42, 'tani', '1', '本', '本', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (43, 'tani', '2', '枚', '枚', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (44, 'tani', '3', '個', '個', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (45, 'tani', '4', '件', '件', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (46, 'tani', '5', '台', '台', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (47, 'tani', '6', 'Ｌ', 'Ｌ', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (48, 'tani', '7', 'Ｐ', 'Ｐ', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (49, 'kansa_flg', '0', '監査', '監査', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (50, 'kansa_flg', '1', '実績', '実績', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (51, 'shop_kbn', '9', 'その他', 'その他', '2012-10-01', '2012-10-01');"
           execute "INSERT INTO m_codes (id, kbn, code, code_name, code_name1, created_at, updated_at) VALUES (52, 'user_class', '3', '役職', '役職', '2012-10-01', '2012-10-01');"
           execute "select setval('m_codes_id_seq',(select max(id) from m_codes));"
           
           execute "TRUNCATE TABLE m_shops;"
           
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          1,999999,'本社','ﾎﾝｼｬ','本社','830-0017','久留米市日吉町23-36 福岡スタンダードビル5F','0942-33-2323','0942-31-2222','',9,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          2,195639,'八女インターSS','ﾔﾒｲﾝﾀｰ','八女IC','833-0005','筑後市長浜2245-1','0942-53-0679','0942-53-5766','',1,2,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
          execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress, 
            shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, 
            m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          3,'195638','上原々SS','ｶﾝﾊﾞﾗﾊﾞﾗ','上原々','833-0055','筑後市熊野1404','0942-53-0709','0942-53-0709','',1,1,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          4,'195642','ニュー久留米インターSS','ｸﾙﾒｲﾝﾀｰ','久留米IC','839-0841','久留米市御井旗崎1丁目1-12','0942-44-0446','0942-44-0446','',1,2,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          5,'195643','ニュー久留米南SS','ｸﾙﾒﾐﾅﾐ','久留米南','830-0047','久留米市津福本町499-1','0942-32-1377','0942-32-1377','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          6,'301019','小郡インターSS','ｵｺﾞｵﾘｲﾝﾀｰ','小郡IC','838-0122','小郡市松崎186-1','0942-72-0988','0942-72-0988','',1,2,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          7,'195646','ニュー広川インターSS','ﾋﾛｶﾜｲﾝﾀｰ','広川IC','834-0115','八女郡広川町新代1092','0943-32-6119','0943-32-6119','',0,7,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          8,'195647','鳥栖インターSS','ﾄｽｲﾝﾀｰ','鳥栖IC','841-0037','鳥栖市本町3-1514-1','0942-84-7780','0942-84-7780','',1,2,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          9,'195648','八女吉田SS','ﾔﾒﾖｼﾀﾞ','八女吉田','834-0006','八女市吉田796-1','0943-24-0181','0943-24-0181','',1,3,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          10,'195649','櫛原SS','ｸｼﾊﾗ','櫛原','830-0003','久留米市東櫛原町46','0942-30-3223 ','0942-30-3223 ','',1,4,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          11,'195650','セルフ新宮SS','ｼﾝｸﾞｳ','新宮','811-0017','糟屋郡新宮町上府773-1','092-941-5811','092-941-5811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          12,'232797','セルフ曽根SS','ｿﾈ','曽根','800-0223','北九州市小倉南区上曽根5丁目110-1','093-474-5811','093-474-5811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          13,'232798','セルフ長府SS','ﾁｮｳﾌ','長府','752-0928','下関市長府才川2丁目473－5','083-249-2211','083-249-2211','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          14,'232799','高三潴SS','ﾀｶﾐｽﾞﾏ','高三潴','830-0103','久留米市三潴町高三潴1258-1','0942-64-4325 ','0942-64-4325 ','',1,4,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          15,'244095','セルフ金隈SS','ｶﾈﾉｸﾏ','金隈','812-0863','福岡市博多区金の隈１丁目23-29','092-503-0686','092-503-0686','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          16,'246407','セルフ佐賀大和SS','ｻｶﾞﾔﾏﾄ','佐賀大和','849-0917','佐賀市高木瀬町大字長瀬1666-1','0952-34-5801','0952-34-5801','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          17,'253342','セルフ画図SS','ｴｽﾞ','画図','862-0946','熊本市画図町大字所島123-1','096-334-9811','096-334-9811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          18,'256970','セルフ荒木SS','ｱﾗｷ','荒木','830-0063','久留米市荒木町荒木2411','0942-51-3550','0942-51-3336','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          19,'265628','セルフ菊陽SS','ｷｸﾖｳ','菊陽','869-1101','菊池郡菊陽町津久礼2150-1','096-233-5011','096-233-5011','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          20,'270075','セルフ筑紫野3号バイパスSS','ﾁｸｼﾉｻﾝｺﾞｳﾊﾞｲﾊﾟｽ','筑紫野3号','818-0066','筑紫野市大字永岡685-1','092-918-7701','092-918-7701','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          21,'273479','セルフ筑紫野インターSS','ﾁｸｼﾉｲﾝﾀｰ','筑紫野IC','818-0054','筑紫野市杉塚 3-181-5','092-923-5817','092-923-5817','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          22,'277618','セルフ大野城SS','ｵｵﾉｼﾞｮｳ','大野城','816-0955','大野城市上大利北26街区4号','092-915-5817','092-915-5817','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          23,'278668','セルフ二又瀬SS','ﾌﾀﾏﾀｾ','二又瀬','812-0065','福岡市東区二又瀬新町6-22','092-624-2811','092-624-2811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          24,'283529','セルフ久留米東SS','ｸﾙﾒﾋｶﾞｼ','久留米東','839-0862','久留米市野中町419-1','0942-41-9818','0942-41-9818','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          25,'285260','セルフ津福SS','ﾂﾌﾞｸ','津福','830-0061','久留米市津福今町679-1','0942-31-5330','0942-31-5330','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          26,'287706','セルフ岡垣SS','ｵｶｶﾞｷ','岡垣','811-4222','遠賀郡岡垣町大字戸切344-1','093-281-5330','093-281-5330','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          27,'288626','セルフ東合川SS','ﾋｶﾞｼｱｲｶﾜ','東合川','839-0809','久留米市東合川2-2-10','0942-44-3811','0942-44-3811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          28,'288907','セルフ東篠崎SS','ﾋｶﾞｼｼﾉｻﾞｷ','東篠崎','802-0072','北九州市小倉北区東篠崎3-193-17','093-932-9811','093-932-9811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          29,'289575','セルフ志免SS','ｼﾒ','志免','811-2207','糟屋郡志免町大字南里105-1','092-937-9011','092-937-9011','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          30,'290018','セルフ山口SS','ﾔﾏｸﾞﾁ','山口','753-0871','山口市朝田1808-10','083-934-5911','083-934-5911','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          31,'293100','セルフみやまSS','ﾐﾔﾏ','みやま','835-0016','みやま市瀬高町濱田330-1','0944-64-7011','0944-64-7011','',1,5,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          32,'293378','セルフ諫早SS','ｲｻﾊﾔ','諫早','854-0062','諫早市小船越町242-1','0957-21-7011 ','0957-21-7011 ','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          33,'293975','セルフ別府SS','ﾍﾞｯﾌﾟ','別府','874-0023','別府市上人ヶ浜町239','0977-27-7355','0977-27-7355','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          34,'297994','セルフ上津SS','ｶﾐﾂ','上津','830-0052','久留米市上津町1194-1','0942-33-2323','0942-33-2323','',1,2,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          35,'299508','セルフ大分SS','ｵｵｲﾀ','大分','870-0924','大分市牧1-160','097-504-3811','097-504-3811','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          36,'300847','セルフ佐賀ゆめタウン前SS','ｻｶﾞﾕﾒﾀｳﾝﾏｴ','佐賀ゆめ','849-0914','佐賀市兵庫町大字西渕三本柳1912-2','0952-36-9411','0952-36-9411','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          37,'300846','セルフ時津SS','ﾄｷﾂ','時津','851-2104','西彼杵郡時津町野田郷字岩崎35-1','0958-60-2711','0958-60-2711','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          38,'301506','セルフ大牟田SS','ｵｵﾑﾀ','大牟田','836-0083','大牟田市長田町7-1','0944-57-1800','0944-57-1800','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
           execute "INSERT INTO m_shops(
            id, shop_cd, shop_name, shop_kana, shop_ryaku, shop_zip_cd, shop_adress,shop_tel, shop_fax, shop_mail_adress, shop_kbn, m_shop_group_id, m_oil_id1, tank1_all, m_oil_id2, tank2_all, m_oil_id3, tank3_all, 
            m_oil_id4, tank4_all, deleted_flg, created_at, updated_at)
          VALUES (
          39,'301505','セルフ大川SS','ｵｵｶﾜ','大川','831-0005','大川市向島前開1367-1','0944-86-6711','0944-86-6711','',0,6,1,0,2,0,3,0,4,0,0,'2012-10-01','2012-10-01');
          "
          execute "
          select setval('m_shops_id_seq',(select max(id) from m_shops));
          "
           execute "TRUNCATE TABLE m_shop_groups;"
           
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (1, 1, '重野石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (2, 2, '小郡スタンダード石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (3, 3, '久留米スタンダード石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (4, 4, '平成スタンダード石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (5, 5, 'みやまスタンダード石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_shop_groups (id, group_cd, group_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (6, 6, '福岡スタンダード石油', 0, NULL, '2012-10-01', '2012-10-01');
           "
          execute "
          select setval('m_shop_groups_id_seq',(select max(id) from m_shop_groups));
          
          "
           execute "TRUNCATE TABLE m_oils;"
           
           execute "INSERT INTO m_oils (id, oil_cd, oil_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (1, 1, 'ハイオク', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_oils (id, oil_cd, oil_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (2, 2, 'レギュラー', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_oils (id, oil_cd, oil_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (3, 3, '軽油', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_oils (id, oil_cd, oil_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (4, 4, '灯油', 0, NULL, '2012-10-01', '2012-10-01');
           "
          execute "
          select setval('m_oils_id_seq',(select max(id) from m_oils));
          "
          
           execute "TRUNCATE TABLE menus;"
           
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (1,1,0, 'データ入力', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (2,1,1, '実績入力', 'd_results', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (3,1,2, '売上入力', 'd_sales/new', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (4,1,3, '洗車売上入力', 'd_wash_sales', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (5,1,4, '他売上入力', 'd_sale_etcs', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (6,1,5, '洗車売上報告', 'd_washsale_reports', NULL, NULL,2, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (7,1,6, '備品購入申請入力', 'd_fixtures', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (8,1,7, '価格調査入力', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (9,1,8, '人件費入力', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (10,1,9, '目標値入力', 'd_aims', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (11,2,0, 'データ照会', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (12,2,1, '照　会', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (13,2,2, '一覧照会', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (14,2,1, '実績表', '#', NULL, NULL,2, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (15,2,1, '地下タンク過不足表', 'd_tank_decrease_reports', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (16,2,1, '地下タンク計算表', 'd_tank_compute_report_details', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (17,2,1, '人件費表', '#', NULL, NULL,0, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (18,2,1, '夢ポイント管理表', 'd_yume_point_lists', NULL, NULL,0, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (19,2,1, '見込客集計表', '#', NULL, NULL,0, 5);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (20,2,1, '洗車プリカ目標販売', '#', NULL, NULL,0, 6);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (21,2,2, '売上現金管理表一覧', 'd_sale_reports', NULL, NULL,0, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (22,2,2, '地下タンク計算表一覧', 'd_tank_compute_reports', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (23,2,2, '洗車売上報告書一覧', 'd_washsale_report_lists', NULL, NULL,0, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (24,2,2, '目標値一覧', '#', NULL, NULL,0, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (25,3,0, '状況一覧', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (26,3,1, '実績入力状況一覧', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (27,3,1, '売上入力状況一覧', 'd_sales', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (28,3,1, '洗車売上入力状況一覧', 'd_washsale_lists', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (29,3,1, '監査入力状況一覧', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (30,3,1, '人件費入力状況一覧', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (31,4,0, '監　査', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (32,4,1, '自主監査', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (33,4,2, '本監査', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (34,4,1, '金庫自主監査', '#', NULL, NULL,1, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (35,4,1, '釣銭機自主監査', 'd_audit_changemachines?audit_class=0', NULL, NULL,1, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (36,4,1, '洗車売上自主監査', 'd_audit_washes?audit_class=0', NULL, NULL,1, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (37,4,1, '他売上自主監査', 'd_audit_etcs?audit_class=0', NULL, NULL,1, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (38,4,2, '金庫本監査', '#', NULL, NULL,1, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (39,4,2, '釣銭機本監査', 'd_audit_washes?audit_class=1', NULL, NULL,1, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (40,4,2, '洗車売上本監査', 'd_audit_washes?audit_class=1', NULL, NULL,1, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (41,4,2, '他売上本監査', 'd_audit_etcs?audit_class=1', NULL, NULL,1, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (42,4,2, '監査SSチェック', 'd_audit_checks', NULL, NULL,0, 5);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (43,5,0, '承　認', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (44,5,1, '売上承認一覧', 'd_sale_approves', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (45,5,1, '監査承認一覧', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (46,5,1, '備品購入申請承認', 'd_audit_approves', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (47,6,0, '運　用', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (48,6,1, 'イベント通知入力', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (49,6,1, 'コメント入力', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (50,6,2, '他シス連携', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (51,6,2, '売上データ出力', '#', NULL, NULL,0, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (52,6,2, '在庫データ出力', '#', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (53,6,2, '給与データ出力', '#', NULL, NULL,0, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (54,7,0, 'マスタメンテ', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (55,7,1, 'メンテ1', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (56,7,2, 'メンテ2', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (57,7,1, 'ユーザーマスタメンテ', 'users', NULL, NULL,0, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (58,7,1, '店舗マスタメンテ', 'm_shops', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (59,7,1, '油外マスタメンテ', 'm_oiletcs', NULL, NULL,0, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (60,7,1, '他売上マスタメンテ', 'm_etcs', NULL, NULL,0, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (61,7,1, '洗車機マスタメンテ', 'm_washes', NULL, NULL,0, 5);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (62,7,1, '内訳マスタメンテ', 'm_items', NULL, NULL,0, 6);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (63,7,2, '所属会社マスタメンテ', 'm_shop_groups', NULL, NULL,0, 1);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (64,7,2, '監査チェックマスタメンテ', 'm_audit_checks', NULL, NULL,0, 2);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (65,7,2, '人件費マスタメンテ', '#', NULL, NULL,0, 3);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (66,7,2, '権限マスタ', 'm_authorities', NULL, NULL,0, 4);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (67,7,2, 'メニュー表示マスタメンテ', 'authority_menus', NULL, NULL,0, 5);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (68,8,0, 'システムメンテ', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (69,8,1, 'コードマスタメンテ', 'm_codes', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (70,8,1, '分類チェックマスタメンテ', 'm_class_checks', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (71,8,1, '釣銭固定額内訳マスタ', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (72,8,1, '目標値マスタメンテ', 'm_aims', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (73,8,1, '油種マスタメンテ', 'm_oils', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (74,8,1, 'ログイン履歴', '#', NULL, NULL,0, 0);"
           execute "INSERT INTO menus (id, menu_cd1, menu_cd2, display_name, uri, created_at, updated_at, messege_send, menu_cd3) VALUES (75,8,1, '会社情報マスタ', 'establishes', NULL, NULL,0, 0);"

          execute "
          select setval('menus_id_seq',(select max(id) from menus));
          "

           execute "TRUNCATE TABLE authority_menus;"
           
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (1,1,1,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (2,1,2,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (3,1,3,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (4,1,4,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (5,1,5,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (6,1,6,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (7,1,7,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (8,1,8,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (9,1,9,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (10,1,10,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (11,1,11,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (12,1,12,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (13,1,13,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (14,1,14,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (15,1,15,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (16,1,16,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (17,1,17,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (18,1,18,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (19,1,19,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (20,1,20,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (21,1,21,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (22,1,22,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (23,1,23,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (24,1,24,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (25,1,25,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (26,1,26,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (27,1,27,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (28,1,28,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (29,1,29,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (30,1,30,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (31,1,31,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (32,1,32,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (33,1,33,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (34,1,34,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (35,1,35,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (36,1,36,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (37,1,37,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (38,1,38,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (39,1,39,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (40,1,40,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (41,1,41,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (42,1,42,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (43,1,43,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (44,1,44,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (45,1,45,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (46,1,46,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (47,1,47,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (48,1,48,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (49,1,49,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (50,1,50,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (51,1,51,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (52,1,52,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (53,1,53,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (54,1,54,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (55,1,55,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (56,1,56,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (57,1,57,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (58,1,58,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (59,1,59,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (60,1,60,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (61,1,61,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (62,1,62,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (63,1,63,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (64,1,64,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (65,1,65,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (66,1,66,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (67,1,67,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (68,1,68,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (69,1,69,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (70,1,70,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (71,1,71,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (72,1,72,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (73,1,73,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (74,1,74,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (75,1,75,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (76,1,76,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (77,1,77,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (78,1,78,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (79,1,79,'2012-10-01','2012-10-01');"
           execute "INSERT INTO authority_menus (id, m_authority_id, menu_id, created_at, updated_at) VALUES (80,1,80,'2012-10-01','2012-10-01');"
          execute "
          select setval('authority_menus_id_seq',(select max(id) from authority_menus));
          "

           execute "TRUNCATE TABLE m_authorities;"
           
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (2, 1, '社長', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (3, 2, '専務', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (4, 3, '常務', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (5, 4, '部長', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (6, 5, '店長１', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (10, 6, '店長２', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (11, 7, '店長３', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (13, 8, '社員１', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (14, 9, '社員２', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (16, 10, '社員SS', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (1, 99, '管理者', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (17, 11, 'アルバイト', 0, NULL, '2012-10-01', '2012-10-01');
           "
           execute "INSERT INTO m_authorities (id, authority_cd, authority_name, deleted_flg, deleted_at, created_at, updated_at) VALUES (18, 12, '監査人', 0, NULL, '2012-10-01', '2012-10-01');
           "
          execute "
          select setval('m_authorities_id_seq',(select max(id) from m_authorities));
          "

 end

  def down
  end
end