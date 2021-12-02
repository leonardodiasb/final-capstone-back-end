class CreateShifts < ActiveRecord::Migration[6.1]
  def change
    create_table :shifts do |t|
      t.string :time
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
