class ResponseService
  PREFIX_KEY = 'tmb'
  EVENT_TYPE_MESSAGE = 'message'
  COMMANDS = {PING: 'ping', SET_CLEANING_DATE: 'set-cleaning-date', HELP: 'help'}

  def initialize(params, cleaning_date = CleaningDateService.instance)
    event = params["events"][0]
    event_type = event["type"]
    input_text = (event["message"]["text"] if event_type == EVENT_TYPE_MESSAGE) || ''
    @reply_token = event["replyToken"]
    @prefix, @command, @data = input_text.split('_')
    @cleaning_date = cleaning_date
  end

  def form_response
    return '' unless @prefix == PREFIX_KEY

    case @command
      when COMMANDS[:PING]
        ['pong', @reply_token]
      when COMMANDS[:SET_CLEANING_DATE]
        [set_cleaning_date, @reply_token]
      when COMMANDS[:HELP]
        [help, @reply_token]
      else
        ''
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
  def help
    arr = COMMANDS.values.unshift('選択可能なコマンドは以下のとおりです')
    arr.join('\n')
  end
end