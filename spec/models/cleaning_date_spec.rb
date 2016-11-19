require_relative '../../app/models/cleaning_date'
require 'rails_helper'

class CleaningDateSpec
  describe('CleaningDateSpec') do
    it('should be able to set cleaning date through create method') do
      expect = Date::new(2016, 1, 1)
      CleaningDate.create(cleaning_date: expect)
      actual = CleaningDate.last.cleaning_date

      expect(actual).to eq(expect)
    end
  end
end