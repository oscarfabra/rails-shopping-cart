class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.references :customer, index: true

      t.timestamps
    end
  end
end
