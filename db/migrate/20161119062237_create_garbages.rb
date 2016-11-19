class CreateGarbages < ActiveRecord::Migration[5.0]
  def change
    create_table :garbages do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
