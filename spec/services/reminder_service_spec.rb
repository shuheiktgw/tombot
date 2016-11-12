require_relative '../../app/services/reminder_service'

class ReminderServiceSpec
  describe('ResponseService') do
    describe('#check_garbage_reminder') do
      it('should return Moerugomi reminder if today is Tuesday') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 8))
        expected = '今日は燃えるゴミの日ですよ~ 捨てられるものは捨ててしまいましょう!'
        actual = reminder_service.check_garbage_reminder

        expect(actual).to eq(expected)
      end

      it('should return Moerugomi reminder if today is Friday') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 11))
        expected = '今日は燃えるゴミの日ですよ~ 捨てられるものは捨ててしまいましょう!'
        actual = reminder_service.check_garbage_reminder

        expect(actual).to eq(expected)
      end

      it('should return Shigen reminder if today is Saturday') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 12))
        expected = '今日は資源ごみの日ですよ~, カン･ビン･ペットボトル･ダンボールを捨てましょう!'
        actual = reminder_service.check_garbage_reminder

        expect(actual).to eq(expected)
      end

      it('should be empty if today is Monday') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 7))
        actual = reminder_service.check_garbage_reminder

        expect(actual).to be_empty
      end
    end

    describe('#check_payment_reminder') do
      it('should return Oneshasu reminder if today is 25th') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 25))
        expected = '今日は25日です. 家賃の振り込みをおねシャッス!'
        actual = reminder_service.check_payment_reminder

        expect(actual).to eq(expected)
      end

      it('should return Masaka reminder if today is 28th') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 28))
        expected = '今日は28日です. まさかまだ家賃振り込んでない人なんていないよね...'
        actual = reminder_service.check_payment_reminder

        expect(actual).to eq(expected)
      end

      it('should be empty if today is 1st') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 1))
        actual = reminder_service.check_payment_reminder

        expect(actual).to be_empty
      end
    end
  end
end