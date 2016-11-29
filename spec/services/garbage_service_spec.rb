require_relative '../../app/services/garbage_service'
require_relative '../../app/models/garbage'
require_relative '../../config/initializers/constants'
require 'rails_helper'

class GarbageServiceSpec
  describe('GarbageServiceSpec') do
    before do
      garbage_model_mock = double('Garbage model mock')
      allow(garbage_model_mock).to receive(:create)
      allow(garbage_model_mock).to receive_message_chain('last.name').and_return(Constants::MEMBER_LIST.first)
      @garbage_instance = GarbageService.new(garbage_model = garbage_model_mock)
    end

    describe ('#reminder') do
      it('should return Hunengomi if today is second Monday') do
        expect = '今日は不燃ゴミの日'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 14))

        expect(actual).to start_with(expect)
      end


      it('should return Hunengomi if today is fourth Monday') do
        expect = '今日は不燃ゴミの日'
        actual = @garbage_instance.reminder(Date::new(2016, 11, 28))

        expect(actual).to start_with(expect)
      end

      it('should return nothing if today is first Monday') do
        actual = @garbage_instance.reminder(Date::new(2016, 11, 7))

        expect(actual).to be_nil
      end

      it('should return nothing if today is third Monday') do
        actual = @garbage_instance.reminder(Date::new(2016, 11, 21))

        expect(actual).to be_nil
      end

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
    end

    describe ('#set_person_in_charge_manually') do
      it('should return new daijin name if valid name is given') do
        name = Constants::MEMBER_LIST.first

        expect = "今週のゴミ出し大臣を#{name}さんに設定しました"
        actual = @garbage_instance.set_person_in_charge_manually(name)

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