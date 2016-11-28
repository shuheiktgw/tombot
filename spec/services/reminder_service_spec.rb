require_relative '../../app/services/reminder_service'

class ReminderServiceSpec
  describe('ReminderService') do
    describe('#check_payment_reminder') do
      it('should return Oneshasu reminder if today is 25th') do
        reminder_service = ReminderService.new(Date::new(2016, 11, 25))
        expected = "今日は25日です. 家賃の振り込みをおねシャッス!口座は以下です\n"
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