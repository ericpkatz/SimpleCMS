class AddPriorityToPages < ActiveRecord::Migration
  def change
    add_column :pages, :priority, :integer, default: 1
  end
end
