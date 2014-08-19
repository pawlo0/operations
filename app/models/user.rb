class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]
         
  belongs_to :plant
  
  validates :username, :uniqueness => {:case_sensitive => false}

  before_save do
    self.name = self.name.split.map(&:capitalize).join(' ')
  end
         
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
end
