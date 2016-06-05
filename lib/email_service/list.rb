require 'mosaic-lyris'

module EmailService
  class List < Base
    LISTS = EmailService::Constants::LISTS

    class << self
      def parse_list_name(list)
        list_name = list.present? ? list.to_s : 'master'
        environment = Rails.env rescue 'staging'
        (EmailService::Constants::LIST_PREFIX[environment] + list_name).to_sym
      end

      def list_id(list)
        EmailService::Constants::LISTS[parse_list_name(list)]
      end

      def validate(list)
        list_names = LISTS.keys
        raise "Valid :list options are #{list_names}" if !list_names.include?(parse_list_name(list))
      end
    end
  end
end