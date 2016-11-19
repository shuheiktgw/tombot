require_relative '../../app/models/garbage'
require 'rails_helper'

class GarbageSpec
  describe('GarbageSpec') do
    it('should be able to set person in Charge through create') do
      expect = '北川'
      Garbage.create(name: expect)
      actual = Garbage.last.name

      expect(actual).to eq(expect)
    end
  end
end