require_relative '../../app/services/cleaning_date_service'

class CleaningDateServiceSpec
  describe('CleaningService') do
    before do
      @cleaning_data_instance = CleaningDateService.instance
    end

    describe('#reminder') do
      it 'should return next cleaning date 3 days before' do
        expected = '次の掃除は11/05です.忘れないようにしましょう.参加できない場合は代わりに1000円ですよ~'
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 11, 2))

        expect(actual).to eq(expected)
      end

      it 'should return today reminder if today is cleaning date' do
        expected = '今日は掃除の日です.参加できない場合は代わりに1000円ですよ~'
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 11, 5))

        expect(actual).to eq(expected)
      end

      it 'should remind to set if cleaning date is not scheduled on 1st of the month' do
        expected = '月初なので, 今月の掃除日を決めましょう!'
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 12, 1))

        expect(actual).to eq(expected)
      end

      it 'should remind to set if cleaning date is not scheduled on 5th of the month' do
        expected = 'まだ今月の掃除日が決まっていないみたいです... 今日中に必ず決めましょう!'
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 12, 5))

        expect(actual).to eq(expected)
      end

      it 'should get angry if cleaning date is not scheduled on 29th of the month' do
        expected = '今月掃除してないです... おこですよ!!'
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 12, 29))

        expect(actual).to eq(expected)
      end

      it 'should not return anything on 10th if cleaning date is already scheduled this month' do
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 11, 10))

        expect(actual).to be_empty
      end

      it 'should not return anything on 10th if cleaning date is already scheduled next month' do
        actual   = @cleaning_data_instance.reminder(Date::new(2016, 10, 10))

        expect(actual).to be_empty
      end
    end
  end

end