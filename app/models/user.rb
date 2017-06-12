class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :collaborators

  enum role: [:standard, :premium, :admin]

  after_initialize :init

  def init
    self.role ||= :standard
  end

end
