module MCodesHelper
  def self.code_list(kbn)
        MCode.find(:all, :conditions => ["kbn = ?",kbn], :order => 'code').map do |u|
      [u.code_name,u.id]
        end
  end  
end
