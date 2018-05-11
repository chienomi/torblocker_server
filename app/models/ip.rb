class Ip < ActiveRecord::Base
    has_many :userips, dependent: :destroy
    has_many :users, through: :userips, source: :user

    validates :a,
      presence: true,
      format: { with: /(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/},
      uniqueness: {case_sensitive: false}
end
