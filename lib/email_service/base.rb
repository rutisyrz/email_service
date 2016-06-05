require 'mosaic-lyris'

module EmailService
  class Base

    class << self

      #Method called when a class inherits Base class, ensuring lyris initialization.
      def inherited(child_class)
        load_configuration
        super
      end

      def load_configuration
        Mosaic::Lyris::Object.configuration= EmailService::Constants::CONFIGURATION
        Mosaic::LyrisDeliveryMethod.extend ActionView::Helpers::SanitizeHelper::ClassMethods
      end

      def send_error_mail(error, options)
        mail_defaults = EmailService::Constants::MAIL_DEFAULTS
        recipients = EmailService::Constants::TECH_DEVS
        environment = Rails.env rescue 'staging'
        mail_defaults.merge!({
          message: "<html>[#{environment}]#{error}<p>#{error.backtrace.join("<br>")}<br>#{options}</p></html>",
          subject: error.message
        })
        Mosaic::Lyris::Trigger.fire(mail_defaults[:trigger_id], recipients, mail_defaults)
      end

      def request_failed(*args)
        error, options = *args
        send_error_mail(error, options)
        { success: false, message: error.present? ? error.message : 'Request Failed' }
      end

      def request_success
        { success: true }
      end

      def symbolize(name)
        name.gsub(/[^\w]/, ' ').gsub(/\s+/, ' ').gsub(/[^\w]/, '_').downcase.to_sym
      end
    end
  end
end
