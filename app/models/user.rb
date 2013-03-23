
class User < ActiveRecord::Base
  belongs_to :role
  has_one :join_confirmation, :dependent => :destroy
  has_many :comments
  has_many :news
  has_many :articles
  has_many :works

  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :about_me

  has_attached_file :avatar, :styles => { :original => "400x400>" },
                    :url  => "/assets/avatars/users/:id/:style/:basename.:extension",
                    :default_url => "/assets/noavatar.gif",
                    :path => ":rails_root/app/assets/images/avatars/users/:id/:style/:basename.:extension"

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => { :message => "Name can't be blank" },
                   :length   => { :within => 6..30 }
  validates :email, :presence => true,
            :format   => { :with => email_regex },
            :uniqueness => {:case_sensitive => false}
  validates :password, :presence     => true,
            :confirmation => true,
            :length       => { :within => 6..20 }
  validates_attachment_content_type :avatar, :content_type => /^image\/(jpg|jpeg|pjpeg|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/gif images)'

  before_validation :encrypt_password
  after_create :send_registration_email

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user
      if user.join_confirmation == nil && user.has_password?(submitted_password)
        return user
      end
    end
    return nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def send_registration_email
    self.join_confirmation = JoinConfirmation.create(:activation_code => Array.new(45){(97 + rand(26)).chr}.join)
    RegistrationMailer.registration_email(self).deliver
  end

  def self.remove_not_activated
    JoinConfirmation.all.each do |activation|
      if activation.user.created_at < Time.now - 1.day
        activation.user.destroy
      end
    end
  end
end

