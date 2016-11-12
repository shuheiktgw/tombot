class LineClient
  END_POINT = "https://api.line.me"

  def initialize(channel_access_token, proxy = nil)
    @channel_access_token = channel_access_token
    @proxy = proxy
  end

  def post(path, data)
    client = Faraday.new(:url => END_POINT) do |conn|
      conn.request :json
      conn.response :json, :content_type => /\bjson$/
      conn.adapter Faraday.default_adapter
      conn.proxy @proxy
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
        "to" => "Ua03a73001d39ec15b475b410a9df5f42", # TODO: toをtomboのグループに変更する
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
