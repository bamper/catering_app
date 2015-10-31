class User < ActiveRecord::Base
  belongs_to :daily_ration

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_authentication_token

  def role?(r)
    role.include? r.to_s
  end

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def reset_authentication_token
    # Generate new token after user logs out. Just for security.
    # I don't think that after log out we'd set token as nil.
    self.authentication_token = generate_authentication_token
  end

  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
