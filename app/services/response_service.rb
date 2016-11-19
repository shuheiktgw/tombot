require_relative '../../config/initializers/constants'

class ResponseService
  PREFIX_KEY = 'tmb'
  EVENT_TYPE_MESSAGE = 'message'
  COMMANDS = {PING: 'ping', SET_CLEANING_DATE: 'set-cleaning-date', GET_CLEANING_DATE: 'get-cleaning-date', SET_DAIJIN: 'set-daijin',GET_DAIJIN: 'get-daijin', HAT: 'hat' , HELP: 'help'}

  def initialize(params, cleaning_date = CleaningDateService.new, garbage = GarbageService.new)
    event = params["events"][0]
    event_type = event["type"]
    input_text = (event["message"]["text"] if event_type == EVENT_TYPE_MESSAGE) || ''
    @reply_token = event["replyToken"]
    @prefix, @command, @data = input_text.split('_')
    @cleaning_date = cleaning_date
    @garbage = garbage
  end

  def form_response
    return '' unless @prefix == PREFIX_KEY

    case @command
      when COMMANDS[:PING]
        ['pong', @reply_token]
      when COMMANDS[:SET_CLEANING_DATE]
        [set_cleaning_date, @reply_token]
      when COMMANDS[:GET_CLEANING_DATE]
        [get_cleaning_date, @reply_token]
      when COMMANDS[:SET_DAIJIN]
        [set_daijin, @reply_token]
      when COMMANDS[:GET_DAIJIN]
        [get_daijin, @reply_token]
      when COMMANDS[:HAT]
        [hat, @reply_token]
      when COMMANDS[:HELP]
        [help, @reply_token]
      else
        ['コマンドが認識できませんでした. tmb_helpでコマンドの一覧を確認することができます.', @reply_token]
    end
  end

  private
  def set_cleaning_date
    begin
      date = Date.parse(@data)
      @cleaning_date.scheduled_cleaning_date = date
      "次の掃除を#{date}に設定しました"
    rescue ArgumentError => e
      '日付の形式が正しくありません'
    end
  end

  private
  def get_cleaning_date
    date = @cleaning_date.scheduled_cleaning_date
    "現在掃除は#{date}に設定されています"
  end

  private
  def set_daijin
    @garbage.set_person_in_charge_manually(@data)
  end

  private
  def get_daijin
    person_in_charge = @garbage.get_person_in_charge
    "今週のゴミ出し大臣は#{person_in_charge}さんです."
  end

  private
  def hat
    person = Constants::MEMBER_LIST.sample
    "#{person}さん,Youいっちゃいなyo!"
  end

  private
  def help
    arr = COMMANDS.values.unshift('選択可能なコマンドは以下のとおりです')
    arr.join("\n")
  end
end