class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :body
      t.integer :page_id
      t.integer :priority

      t.timestamps
    end
    add_foreign_key :contents, :pages
  end
end
