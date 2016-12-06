class WebhookController < ApplicationController
  protect_from_forgery with: :null_session

  EVENT_TYPE_MESSAGE = 'message'

  def callback
    logger.info(params)

    res = reply(params)

    logger.info(res.body) if res.present?
    render :nothing => true, status: :ok
  end

  def reminder
    reminders = get_reminders
    logger.info(reminders)

    reminders.each do |reminder|
      res = line_client.push(reminder)
      logger.info(res.body)
    end
  end

  private
  def reply(params)
    response_service = response_service(params)
    response_text, reply_token  = response_service.form_response

    line_client.reply(reply_token, response_text)  if response_text.present?
  end

  def get_reminders
    reminder_service.execute
  end

  def response_service(input_text)
    ResponseService.new(input_text)
  end

  def reminder_service
    ReminderService.new
  end

  def line_client
    @line_client ||= LineClient.new
  end
end