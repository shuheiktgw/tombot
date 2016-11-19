class Garbage < ApplicationRecord
  def set_person_in_charge(name)
    self.name = name
    self.save
  end
end
