task :reminder_task => :environment do
  webhook_controller = WebhookController.new
  webhook_controller.reminder
end