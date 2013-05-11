class Teacher < ActiveRecord::Base

  attr_accessor :first_name, :last_name, :email, :phone

  has_many :students

  validates :email, uniqueness: true

end