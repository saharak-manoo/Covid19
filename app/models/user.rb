class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  ROLE_CUSTOMER = :customer
  ROLE_ADMIN = :admin

  has_attached_file :photo, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'https://placehold.it/300x300.jpg&text=Photo'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def assign_default_role
    self.add_role(ROLE_CUSTOMER) if self.roles.blank?
  end

  def full_name
    "#{first_name} #{last_name}"
  end  
end
