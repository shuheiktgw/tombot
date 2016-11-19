class CreateCleaningDates < ActiveRecord::Migration[5.0]
  def change
    create_table :cleaning_dates do |t|
      t.date :cleaning_date, null: false

      t.timestamps
    end
  end
end
