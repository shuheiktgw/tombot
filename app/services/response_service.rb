require_relative '../../config/initializers/constants'

class ResponseService
  def initialize(params, cleaning_date = CleaningDateService.new, garbage = GarbageService.new)
    event = params["events"][0]
    event_type = event["type"]
    input_text = (event["message"]["text"] if event_type == Constants::EVENT_TYPE_MESSAGE) || ''
    @reply_token = event["replyToken"]
    @source_id = (event["source"]["userId"] || event["source"]["groupId"]) if ENV['RAILS_ENV'] == 'production'
    @prefix, @command, @data = input_text.split('_')
    @cleaning_date = cleaning_date
    @garbage = garbage
  end

  def form_response
    return '' unless @prefix == Constants::PREFIX_KEY
    return '' unless eligible_source?

    case @command
      when Constants::COMMANDS[:PING]
        ['pong', @reply_token]
      when Constants::COMMANDS[:SET_CLEANING_DATE]
        [set_cleaning_date, @reply_token]
      when Constants::COMMANDS[:GET_CLEANING_DATE]
        [get_cleaning_date, @reply_token]
      when Constants::COMMANDS[:SET_DAIJIN]
        [set_daijin, @reply_token]
      when Constants::COMMANDS[:GET_DAIJIN]
        [get_daijin, @reply_token]
      when Constants::COMMANDS[:GET_ACCOUNT]
        [get_account, @reply_token]
      when Constants::COMMANDS[:HAT]
        [hat, @reply_token]
      when Constants::COMMANDS[:HELP]
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

  def get_cleaning_date
    date = @cleaning_date.scheduled_cleaning_date
    "現在掃除は#{date}に設定されています"
  end

  def set_daijin
    @garbage.set_person_in_charge_manually(@data)
  end

  def get_daijin
    person_in_charge = @garbage.get_person_in_charge
    "今週のゴミ出し大臣は#{person_in_charge}さんです."
  end

  def get_account
    "家賃の振り込み口座は以下です.\n#{Constants::ACCOUNT}"
  end

  def hat
    person = Constants::MEMBER_LIST.sample
    "#{person}さん,Youいっちゃいなyo!"
  end

  def help
    arr = Constants::COMMANDS.values.unshift('選択可能なコマンドは以下のとおりです')
    arr.join("\n")
  end

  def eligible_source?
    if ENV['RAILS_ENV'] == 'production'
      Rails.logger.info(Constants::ELIGIBLE_SOURCE)
      Rails.logger.info(@source_id)
      Constants::ELIGIBLE_SOURCE.include?(@source_id)
    else
      true
    end
  end
end