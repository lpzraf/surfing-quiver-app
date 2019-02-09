class CreateSurfboardOwner < ActiveRecord::Migration[5.2]
    def change
      create_table :surfboard_owners do |t|
        t.string :first_name
        t.string :last_name
        t.string :email
        t.string :password_digest
        t.timestamps null: false
    end
  end
end
