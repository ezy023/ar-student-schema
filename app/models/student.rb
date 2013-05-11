require_relative '../../db/config'
require 'date'

# implement your Student model here
class Student < ActiveRecord::Base

  has_many :classrooms
  has_many :teachers, through: :classroomms

  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,5}\z/i }
  validate  :validate_age  
  validates :phone, format: { with: /.{9,}/ }

  def name
    first_name + " " + last_name
  end

  def age
    (DateTime.now - birthday).to_i / 365
  end

  def validate_age
    if age < 5
      errors.add(:birthday, "This person is too young")
    end
  end
end