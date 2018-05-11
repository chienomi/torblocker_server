class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_with_omniauth(auth)
    find_by(uid: auth['uid'], provider: auth['provider'])
  end

  def self.create_with_omniauth(auth)
    Identity.create(
      uid: auth.uid,
      provider: auth.provider,
      urls: auth['info']['urls'].to_json
    )
  end
end
