class WebhookController < ApplicationController
  protect_from_forgery with: :null_session

  EVENT_TYPE_MESSAGE = 'message'
  CHANNEL_SECRET = ENV['CHANNEL_SECRET']
  OUTBOUND_PROXY = ENV['OUTBOUND_PROXY']
  CHANNEL_ACCESS_TOKEN = ENV['CHANNEL_ACCESS_TOKEN']

  def initialize
    @line_client ||= LineClient.new(CHANNEL_ACCESS_TOKEN, OUTBOUND_PROXY)
  end

  def callback
    event = params["events"][0]
    event_type = event["type"]
    reply_token = event["replyToken"]
    input_text = (event["message"]["text"] if event_type == EVENT_TYPE_MESSAGE) || ''

    reply(input_text, reply_token)

    render :nothing => true, status: :ok
  end

  def push
    test_text = "test"
    res = @line_client.push(test_text)

    logger.info(res.body)
  end

  private
  def reply(input_text, reply_token)
    response_service = response_service(input_text)
    response_text = response_service.form_response

    @line_client.reply(reply_token, response_text)  if response_text.present?
  end

  private
  def response_service(input_text)
    ResponseService.new( input_text)
  end
end