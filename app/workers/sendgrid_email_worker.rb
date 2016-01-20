class SendgridEmailWorker
  include Sidekiq::Worker

  def perform
    NotificationsMailer.send_stolen_alert.deliver_now
  end
end
