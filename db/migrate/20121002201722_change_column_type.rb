class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column :pages, :long_description, :text
    change_column :pages, :short_description, :text
  end

  def down
  end
end