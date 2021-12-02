class CreateJoinTableRestaurantsShifts < ActiveRecord::Migration[6.1]
  def change
    create_join_table :restaurants, :shifts do |t|
      t.index %i[restaurant_id shift_id]
    end
  end
end
