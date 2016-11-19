require_relative '../../app/services/garbage_service'
require_relative '../../app/models/garbage'
require 'rails_helper'

class GarbageServiceSpec
  describe('GarbageServiceSpec') do
    before do
      @garbage_instance = GarbageService.new
      Garbage.create(name: '北川')
    end

    describe ('#reminder') do
      it('should return Moerugomi reminder if today is Tuesday') do
        expected = '今日は燃えるゴミの日'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 8))

        expect(actual).to start_with(expected)
      end

      it('should return Moerugomi reminder if today is Friday') do
        expected = '今日は燃えるゴミの日'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 11))

        expect(actual).to start_with(expected)
      end

      it('should return Shigen reminder if today is Saturday') do
        expected = '今日は資源ごみの日です'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 12))

        expect(actual).to start_with(expected)
      end

      it('should return new Daijin reminder if today is Sunday') do
        expected = '明日からのゴミ出し大臣は'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 13))

        expect(actual).to start_with(expected)
      end

      it('should be empty if today is Monday') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 7))
        actual = reminder_service.check_garbage_reminder

        expect(actual).to be_empty
      end

      it('should return new Daijin name if today is Sunday') do
        expected = '明日からのゴミ出し大臣は'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 13))

        expect(actual).to start_with(expected)
      end
    end

    describe ('#set_person_in_charge_manually') do
      it('should return new daijin name if valid name is given') do
        expect = "今週のゴミ出し大臣を北川さんに設定しました"
        actual = @garbage_instance.set_person_in_charge_manually('北川')

        expect(actual).to eq(expect)
      end

      it('should return warning if invalid name is given') do
        expect = "名前が不正です"
        actual = @garbage_instance.set_person_in_charge_manually('不知火')

        expect(actual).to start_with(expect)
      end
    end
  end
end