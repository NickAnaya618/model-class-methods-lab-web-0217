require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.sailors_motor_boat
    self.joins(:classifications).where("classifications.name = 'Motorboat'").uniq
  end

  def self.sailboat_array
    self.sailors.each.map do |element|
      element.name
    end
  end

  def self.motorboat_array
    self.sailors_motor_boat.each.map do |element|
      element.name
    end
  end

  def self.talented_seamen
    where(name: (self.sailboat_array & self.motorboat_array))
  end

  def self.non_sailors
     where.not(name: self.sailboat_array)
  end
end
