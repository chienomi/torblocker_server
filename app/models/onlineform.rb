class Onlineform < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
end
