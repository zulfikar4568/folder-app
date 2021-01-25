class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


belongs_to :role, optional: true
has_many :folders, dependent: :destroy
# has_many :documents, dependent: :destroy

validates_presence_of :first_name, :last_name, :username
before_save :assign_role

def full_name
  "#{first_name} #{last_name}"
end

def assign_role
  self.role = Role.find_by name: 'Guest' if role.nil?
end

def admin?
  role.name == 'Admin'
end

def user?
  role.name == 'User'
end

def guest?
  role.name == 'Guest'
end
end
