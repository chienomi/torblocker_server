class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :count, default: 0, index: true
      t.integer :count_w, default: 0, index: true
    end
  end
end
