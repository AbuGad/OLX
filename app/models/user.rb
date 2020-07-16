class User < ActiveRecord::Base
	has_many :articles, dependent: :destroy
	before_save { self.email = email.downcase}
	validates :username, presence: true, uniqueness: { case_sensitive: false },length: { minimum: 3, maximum: 30 }
	validates :email, presence: true, length: { maximum: 100 }, uniqueness: true
	validates :email, email_format: { message: 'Invalid email format' }
	has_secure_password

end