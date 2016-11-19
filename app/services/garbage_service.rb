require 'date'
require_relative '../models/garbage'

class GarbageService
  MEMBER_LIST = ['岡川', '楠本', '谷沢', '北川']

  def initialize(garbage_model = Garbage)
    @garbage_model = garbage_model
  end

  def reminder(today)
    # 0 = 日曜日, 6 = 土曜日
    day_of_week = today.wday

    case day_of_week
      when 0
        set_person_in_charge(select_random)
        "明日からのゴミ出し大臣は#{get_person_in_charge}さんです! よろしくお願いします!"
      when 2, 5
        "今日は燃えるゴミの日です. ゴミ出し大臣の#{get_person_in_charge}さんは燃えるゴミをお願いします!"
      when 6
        "今日は資源ごみの日です, ゴミ出し大臣の#{get_person_in_charge}さんはカン･ビン･ペットボトル･ダンボールのゴミ出しをお願いします!"
      else
        ''
    end
  end

  def get_person_in_charge
    @garbage_model.last.name
  end

  private
  def set_person_in_charge(name)
    @garbage_model.create(name: name)
  end

  private
  def select_random
    MEMBER_LIST.sample
  end
end