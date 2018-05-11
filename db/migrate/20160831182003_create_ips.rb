class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :a, index: true
      t.integer :d, default: 0
      t.integer :p, default: 0, index: true
    end
  end
end
