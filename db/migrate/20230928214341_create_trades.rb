class CreateTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :trades do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :location
      t.decimal :price
      t.string :duration
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
