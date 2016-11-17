require 'date'
require '../../lib/name_list'

class ReminderService
  def initialize(today = Date::today)
    @today = today
  end

  def execute
    check_reminders
  end

  def check_reminders
    reminders = []

    garbage_reminder       = check_garbage_reminder
    payment_reminder       = check_payment_reminder
    cleaning_date_reminder = check_cleaning_date_reminder

    reminders << garbage_reminder       if garbage_reminder.present?
    reminders << payment_reminder       if payment_reminder.present?
    reminders << cleaning_date_reminder if cleaning_date_reminder.present?

    reminders
  end

  def check_garbage_reminder
    MEMBER_LIST

    # 0 = 日曜日, 6 = 土曜日
    day_of_week = @today.wday

    case day_of_week
      when 2, 5
        '今日は燃えるゴミの日ですよ~ 捨てられるものは捨ててしまいましょう!'
      when 6
        '今日は資源ごみの日ですよ~, カン･ビン･ペットボトル･ダンボールを捨てましょう!'
      else
        ''
    end
  end

  def check_payment_reminder
    if(@today.day == 25)
      '今日は25日です. 家賃の振り込みをおねシャッス!'
    elsif(@today.day == 28)
      '今日は28日です. まさかまだ家賃振り込んでない人なんていないよね...'
    else
      ''
    end
  end

  def check_cleaning_date_reminder
    cleaning_date = CleaningDateService.instance
    cleaning_date.reminder(@today)
  end
end