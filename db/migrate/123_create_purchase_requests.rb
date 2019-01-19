class CreatePurchaseRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_requests do |t|
      t.references :user, foreign_key: true
      t.text :title, null: false
      t.text :author
      t.text :publisher
      t.string :isbn
      t.datetime :date_of_publication
      t.integer :price
      t.string :url
      t.text :note
      t.datetime :accepted_at
      t.datetime :denied_at
      t.string :state, index: true
      t.string :pub_date

      t.timestamps
    end
  end
end
