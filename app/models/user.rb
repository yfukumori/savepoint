class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sheets
  

  def forem_name
    #screen_name needs to be re-introduced, removed during the formatting of the user registration page.
  	screen_name
  end

  def forem_email
  	email
  end       
end
