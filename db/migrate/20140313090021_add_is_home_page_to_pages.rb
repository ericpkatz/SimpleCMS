class AddIsHomePageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :is_home_page, :boolean, null: false, default: false
  end
end
