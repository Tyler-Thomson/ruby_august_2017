class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: EMAIL_REGEX}
  validates :password, presence: true
  
  before_save :downcase_email
  private
    def downcase_email
      email.downcase!
    end
end
