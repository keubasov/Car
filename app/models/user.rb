class User < ActiveRecord::Base

  after_initialize :default_values
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subscriptions, dependent: :destroy
  belongs_to :region

  validates :username, :t_username, :encrypted_password,  :chat_id, :region_id, presence: true
  validates :username, :t_username, length: {in: 3..30}


  def self.on_user (id)
    (User.where 'id = ? AND chat_id != 0', id).first
  end
  def email_required?
    false
  end
  def email_changed?
    false
  end
  def default_values
    self.verified ||= false
  end
end
