# -*- coding:utf-8 -*-
class AddrecordMOiletcs < ActiveRecord::Migration
  def up
    execute "TRUNCATE TABLE m_oiletcs;"

    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (1, 1, 'オイル', '高A', 1, 1, 0, 6, 500, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (2, 31, 'パーツ', '部用', 2, 1, 1, 0, 0.3, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (3, 61, '特殊', '特製', 3, 1, 1, 0, 0.7, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (4, 900, '洗車', '洗車', 0, 1, 1, 0, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (5, 141, '作業', '工賃', 5, 1, 1, 0, 0.95, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (6, 171, 'タイヤ', 'タイヤ', 6, 1, 0, 1, 1500, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (7, 150, '板金', '板金', 5, 1, 1, 0, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (8, 181, '給油プリカ売上', 'GP', 7, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (9, 191, 'スピードパス', 'SP', 8, 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (10, 101, '洗車プリカ合計', '洗車P売上', 4, 0, 0, 2, 0.95, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (11, 111, '洗車プリカ売上', '洗車PPC', 4, 0, 0, 1, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (12, 95, '洗車現金売上', '洗車売上', 4, 0, 1, 0, 0.95, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (13, 203, '車検', '車検', 8, 1, 0, 5, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (14, 10, 'ATFオイル', 'ATF', 1, 0, 0, 6, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (15, 131, '高額洗車', '高洗', 4, 0, 0, 5, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (16, 901, 'LLC', 'LLC', 8, 0, 0, 6, 0, NULL, 1, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (17, 35, 'バッテリー', 'BT', 2, 0, 0, 1, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (18, 40, 'ワイパー', 'ワイパー', 2, 0, 0, 1, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (19, 20, 'モービル1', 'M-1', 1, 0, 0, 6, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (20, 206, '現金会員', '現金会員', 8, 0, 0, 2, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (21, 209, '書替・更新', '書替', 8, 0, 0, 2, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (22, 197, 'ムートンパス', 'ムートンパス', 8, 0, 0, 4, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (23, 194, 'シナジーカード', 'SC', 8, 0, 0, 2, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (24, 185, 'キャッシュバック', 'CB', 7, 0, 1, 0, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (25, 212, '夢ポイント', '夢ポ', 8, 0, 0, 4, 0, NULL, 1, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (26, 221, 'スピードパスプラス', 'SPプラス', 8, 0, 1, 4, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (27, 140, 'タイヤW', 'タイヤW', 4, 0, 1, 1, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (28, 176, '調整', '調整', 7, 0, 1, 0, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (29, 121, 'お試しプリカ', 'お試しプリカ', 4, 0, 0, 4, 0, 1, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (30, 224, 'チラシ配布件数', 'チラシ', 8, 0, 0, 2, 0, 0, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (31, 215, 'nanacoカード件数', 'nanaco(件)', 8, 0, 0, 4, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (32, 218, 'nanacoPOINT', 'nanaco(P)', 8, 0, 0, 7, 0, NULL, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (33, 96, '洗車現金売上', '洗車売上', 4, 0, 1, 0, 1, 0, 0, NULL, NULL, NULL);"
    execute "INSERT INTO m_oiletcs (id, oiletc_cd, oiletc_name, oiletc_ryaku, oiletc_group, oiletc_trade, tax_flg, oiletc_tani, oiletc_arari, shop_kbn, deleted_flg, deleted_at, created_at, updated_at ) VALUES (34, 102, '洗車プリカ合計', '洗車P売上', 4, 0, 0, 2, 1, 0, 0, NULL, NULL, NULL);"
    
    execute "select setval('m_oiletcs_id_seq',(select max(id) from m_oiletcs));"
  end

  def down
  end
end