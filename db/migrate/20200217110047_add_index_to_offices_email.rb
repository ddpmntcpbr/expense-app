class AddIndexToOfficesEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :offices, :email, unique: true
  end
end
