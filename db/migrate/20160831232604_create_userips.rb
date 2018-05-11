class CreateUserips < ActiveRecord::Migration
  def change
    create_table :userips do |t|
      t.references :user, index: true, foreign_key: true
      t.references :ip, index: true, foreign_key: true
    end
  end
end
