require 'date'
require_relative '../models/garbage'
require_relative '../../config/initializers/constants'

class GarbageService
  def initialize(garbage_model = Garbage)
    @garbage_model = garbage_model
  end

  def reminder(today)
    # 0 = 日曜日, 6 = 土曜日
    day_of_week = today.wday

    case day_of_week
      when 0
        set_person_in_charge
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

  def set_person_in_charge_manually(name)
    if Constants::MEMBER_LIST.include?(name)
      @garbage_model.create(name: name)
      "今週のゴミ出し大臣を#{name}さんに設定しました"
    else
      "名前が不正です. セットすることができる名前はこちら#{Constants::MEMBER_LIST.join(', ')}"
    end
  end

  private
  def set_person_in_charge
    list = Constants::MEMBER_LIST
    previous = get_person_in_charge

    if previous == list.last
      @garbage_model.create(name: list.first)
    else
      next_index = list.index(previous) + 1
      @garbage_model.create(name: list[next_index])
    end
  end
end