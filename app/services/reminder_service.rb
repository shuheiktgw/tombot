require 'date'

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
    garbage = GarbageService.instance
    garbage.reminder(@today)
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