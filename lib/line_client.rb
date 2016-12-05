class LineClient
  END_POINT = "https://api.line.me"
  CHANNEL_ACCESS_TOKEN = ENV['CHANNEL_ACCESS_TOKEN']
  PUSH_TO_ID = ENV['PUSH_TO_ID']

  def initialize
    @channel_access_token = CHANNEL_ACCESS_TOKEN
  end

  def post(path, data)
    client = Faraday.new(:url => END_POINT) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
    end

    res = client.post do |request|
      request.url path
      request.headers = {
          'Content-type' => 'application/json',
          'Authorization' => "Bearer #{@channel_access_token}"
      }
      request.body = data
    end
    res
  end

  def reply(reply_token, text)
    messages = form_text_messages(text)

    body = {
        "replyToken" => reply_token,
        "messages" => messages
    }

    res = post('/v2/bot/message/reply', body.to_json)
  end

  def push(text)
    messages = form_text_messages(text)

    body = {
        "to" => PUSH_TO_ID,
        "messages" => messages
    }

    post('/v2/bot/message/push', body.to_json)
  end

  private
  def form_text_messages(*texts)
    messages = []

    texts.each do |text|
      messages << text_message(text)
    end

    messages
  end

  private
  def text_message(text)
    {
        "type" => "text",
        "text" => text
    }
  end

end
