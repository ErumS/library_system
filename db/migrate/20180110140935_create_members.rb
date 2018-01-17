class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.string :name
    	t.text :address
    	t.bigint :phone_no
    	t.integer :gender
    	t.string :code
    	t.date :validity_date
    	t.boolean :is_author, default: false
      t.references :library, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end