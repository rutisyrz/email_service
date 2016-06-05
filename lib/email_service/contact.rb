require 'mosaic-lyris'

module EmailService
  class Contact < Base
    # Request Params:
    # options = {
    #   email: 'abc@example.com',
    #   list: :master,
    #   state: 'trashed',
    #   attributes: {
    #     first_name: 'abc',
    #     last_name: 'xyz'
    #     #more attributes
    #   }
    # }
    # Response Hash:
    # { success: true, message: '' }
    # { success: false, message: error_message }

    class << self
      # Define methods :add, :update
      [:add, :update].each do |method_name|
        define_method(method_name) do |options|
          begin
            validate_user_details(options)
            details = parse_options(options)
            response = Mosaic::Lyris::Record.send(method_name, options[:email], details)
            response.is_a?(Mosaic::Lyris::Record) ? request_success : request_failed
          rescue Exception => e
            request_failed(e, options)
          end
        end
      end

      def query(email, list=nil)
        list_id = EmailService::List.list_id(list)
        response = Mosaic::Lyris::Record.query(email, { list_id: list_id })
        response.is_a?(Mosaic::Lyris::Record) ? request_success : request_failed
      rescue Exception => e
        request_failed(e)
      end

      # options = {email: 'abc@example.com', list: :master}
      def delete(options)
        options.merge!(state: 'trashed')
        update(options)
      end

      private
        def validate_user_details(options)
          raise 'User :email is mandatory' unless options[:email].present?
          EmailService::List.validate(options[:list])
          EmailService::Attribute.validate(options[:attributes])
          #validate state? already checked in lyris
        end

        def parse_options(options)
          {
            list_id: EmailService::List.list_id(options[:list]),
            state: options[:state] || 'active',
            demographics: EmailService::Attribute.parse_attributes(options[:attributes] || {})
          }
        end
    end
  end
end