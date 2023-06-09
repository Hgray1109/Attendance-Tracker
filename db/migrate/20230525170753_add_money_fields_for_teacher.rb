class AddMoneyFieldsForTeacher < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :teacher_price, :integer, default: 0, null: false
    add_column :lessons, :teacher_price_start, :integer, default: 0, null: false
    add_column :lessons, :teacher_price_final, :integer, default: 0, null: false
    add_column :users, :teacher_price_total, :integer, default: 0, null: false
  end
end
