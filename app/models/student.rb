require_relative '../../db/config'
require 'date'

# implement your Student model here
class Student < ActiveRecord::Base

  # attr_accessor :first_name, :last_name, :birthday, :gender, :email, :phone

  # before_save :validations
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,5}\z/i }
  validate  :validate_age  
  validates :phone, format: { with: /.{9,}/ }

  # def initialize(attributes={})
  #   @first_name = attributes[:first_name]
  #   @last_name = attributes[:last_name]
  #   @birthday = attributes[:birthday]
  #   @gender = attributes[:gender]
  #   @email = attributes[:email]
  #   @phone = attributes[:phone]
  # end

  def name
    first_name + " " + last_name
  end

  def age
    (DateTime.now - birthday).to_i / 365
  end

  # def validations
  #   validates_presence_of :user_id
  #   validates_presence_of :song
  #   validates_presence_of :title
  #   validates_presence_of :artist
  #   validates_presence_of :genre
  # end

  def validate_age
    if age < 5
      errors.add(:birthday, "This person is too young")
    end
  end
end