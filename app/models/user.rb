class User < ActiveRecord::Base
  before_create :set_token

  has_many :identities, dependent: :destroy

  has_many :userips, dependent: :destroy
  has_many :ips, through: :userips, source: :ip

  has_many :onlineforms, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,
    :lockable, :omniauthable, :omniauth_providers => [:facebook, :twitter, :google, :stripe_connect]

  # user name should be unique
  validates :user_name, presence: true, uniqueness: true

  # upload user icon to s3
  has_attached_file :image_user, styles:
  {
    medium: {geometry: "64x64>", format: 'png'},
    thumb: {geometry: "32x32>", format: 'png'},
  },
  preserve_files: false,
  :storage => :s3,
  :path => ":attachment/:id/:style/:filename",
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :url => ':s3_alias_url',
    :s3_alias_url => "i.torblocker.com",
    :s3_host_alias => 'i.torblocker.com',
    :s3_protocol => :https

  validates_attachment_content_type :image_user,
    content_type: /\Aimage\/.*\Z/,
    message: 'only jpeg, gif, png'

  validates_attachment_size :image_user,
    less_than: 1.megabyte,
    message: 'Check if the image is less than 1MB'

  def self.find_for_oauth(auth, this_user)
    # Find an identity here
    @identity = Identity.find_with_omniauth(auth)
    # If no identity was found, create a brand new one here
    if @identity.nil?
      @identity = Identity.create_with_omniauth(auth)
    end

    if this_user != nil
      if @identity.user == this_user
        # Identity is already associated with this user
      else
        # Identity is not associated with the current_user
        @identity.user = this_user
        @identity.save
      end
      user = this_user
    else
      if @identity.user.present?
        # Identity has a user associated with it
        user = @identity.user
      else
        # No user associated with the identity so we need to create a new one
        user = User.where(user_name: auth.info.name).first
        if user == nil
          user = User.create(
            user_name: auth.info.name,
            email:    User.get_email(auth),
            password: Devise.friendly_token[6, 30],
            image_user: auth.info.image
          )
        else
          user = User.create(
          user_name: auth.info.name + "_" + [*('a'..'z'),*('0'..'9')].shuffle[0,3].join,
          email: User.get_email(auth),
          password: Devise.friendly_token[6, 30],
          image_user: auth.info.image
          )

        end
        @identity.user = user
        @identity.save
      end
    end
    user
  end

  private
  def set_token
    return if auth_token.present? # guard clause
    self.auth_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end

  def self.get_email(auth)
    email = auth.info.email
    email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    email
  end
end
