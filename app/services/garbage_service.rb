require 'date'
require 'singleton'

class GarbageService
  include Singleton

  attr_accessor :person_in_charge

  def initialize
    @person_in_charge = '北川'
  end

  def reminder(today)
    # 0 = 日曜日, 6 = 土曜日
    day_of_week = today.wday

    case day_of_week
      when 0
        person_in_charge = select_random
        "明日からのゴミ出し大臣は#{person_in_charge}さんです! よろしくお願いします!"
      when 2, 5
        "今日は燃えるゴミの日です. ゴミ出し大臣の#{person_in_charge}さんは燃えるゴミをお願いします!"
      when 6
        "今日は資源ごみの日です, ゴミ出し大臣の#{person_in_charge}さんはカン･ビン･ペットボトル･ダンボールのゴミ出しをお願いします!"
      else
        ''
    end
  end

  private
  def select_random
    ['岡川', '谷沢', '楠本', '北川'].sample
  end
end