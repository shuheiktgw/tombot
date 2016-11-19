require 'date'
require_relative '../models/cleaning_date'

class CleaningDateService

  def initialize(cleaning_date_model = CleaningDate)
    @cleaning_date_model = cleaning_date_model
  end

  def reminder(today)
    if scheduled_cleaning_date - today == 3
      return "次の掃除は#{scheduled_cleaning_date.strftime("%m/%d")}です.忘れないようにしましょう.参加できない場合は代わりに1000円ですよ~"
    elsif scheduled_cleaning_date == today
      return '今日は掃除の日です.参加できない場合は代わりに1000円ですよ~'
    end

    if scheduled_cleaning_date.month != today.month && scheduled_cleaning_date.month != today.month + 1
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

  def scheduled_cleaning_date
    @cleaning_date_model.last.cleaning_date
  end

  def scheduled_cleaning_date=(date)
    @cleaning_date_model.create(cleaning_date: date)
  end
end