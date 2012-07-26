class AuthorityMenu < ActiveRecord::Base
  @@auth_menus = nil

  def self.get_auth_menus_by_authority_class(authority_class)
    # クラス変数として保持している権限メニュー情報がない場合は取得
    @@auth_menus = find(:all,:order => 'authority_class,menu_id') if @@auth_menus.blank?

    # 保持しているクラス変数内から、該当する権限のメニュー定義を取得する
    auth_menus = Array.new
    sort_order = Array.new
    @@auth_menus.each { |item|
      if item.authority_class == authority_class
        auth_menus << item
        sort_order << {:id=> item.id , :parent_menu_id=> item.menu.parent_menu_id, :display_order=> item.menu.display_order}
      end
    }

    # 権限メニューをメニューカテゴリ・表示順位の順にソートする
    auth_menus = auth_menus.sort {| a, b|
      (a.menu.parent_menu_id <=> b.menu.parent_menu_id).nonzero? or a.menu.display_order <=> b.menu.display_order
    }

    return auth_menus
  end

  def self.reflesh_authorities_menus
    @@auth_menus = find(:all,:order => 'authority_class,menu_id')
  end  
end
