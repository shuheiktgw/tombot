require 'date'
require 'singleton'

class CleaningDateService
  include Singleton

  attr_accessor :scheduled_cleaning_date

  def initialize
    @scheduled_cleaning_date = Date::new(2016, 11, 5)
  end

  def reminder(today)
    if @scheduled_cleaning_date - today == 3
      return "次の掃除は#{@scheduled_cleaning_date.strftime("%m/%d")}です.忘れないようにしましょう.参加できない場合は代わりに1000円ですよ~"
    elsif @scheduled_cleaning_date == today
      return '今日は掃除の日です.参加できない場合は代わりに1000円ですよ~'
    end

    if @scheduled_cleaning_date.month != today.month && @scheduled_cleaning_date.month != today.month + 1
      case today.day
        when 1
          '月初なので, 今月の掃除日を決めましょう!'
        when 5, 10, 20
          'まだ今月の掃除日が決まっていないみたいです... 今日中に必ず決めましょう!'
        when 29
          '今月掃除してないです... おこですよ!!'
        else
          ''
      end
    else
      ''
    end
  end
end