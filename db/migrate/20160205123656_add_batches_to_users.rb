class AddBatchesToUsers < ActiveRecord::Migration
  def change
    # prepare batches for paid user
  	add_column :users, :stripe_1, :integer, default: 0
    add_column :users, :badge_1, :integer, default: 0
    add_column :users, :badge_2, :integer, default: 0

    # track paid user
    add_column :users, :price, :integer, index: true, default: 0
    add_column :users, :paid, :integer, index: true, default: 0
    add_column :users, :urls, :string, index: true
    add_column :users, :array_b, :integer, array:true, default: []
    add_column :users, :cus_id, :string

    # prepare user icon
    add_column :users, :image_u_id, :string
    add_column :users, :image_u_size, :integer

    add_column :users, :slug, :string, index: true

    add_column :users, :publishable_key, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :access_code, :string

    # core features of torblocker: ip blacklists
    add_column :users, :auth_token, :string, index: true
    add_column :users, :tor, :integer, default: 1
    add_column :users, :blacklist, :integer, default: 1
    add_column :users, :custom, :integer, default: 1

    # make user settings trackable
    add_column :users, :history, :integer, array: true, default: []
    add_column :users, :full_history, :integer, array: true, default: []
  end
end
