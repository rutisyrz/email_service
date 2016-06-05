# require 'mosaic-lyris'

module EmailService
  class Attribute < Base

    # Request:
    #
    # options = {
    #   name: 'Date of Birth',
    #   type: :date,
    #   list_id: :master, #optional
    #   enabled: true,    #optional
    #   group: 'Test'     #optional
    # }
    #
    # options = {
    #   name: 'User type',
    #   type: :radio_button,
    #   list_id: :master,               #optional
    #   enabled: true,                  #optional
    #   group: 'Test',                  #optional
    #   options: ['service_seeker', 'service_provider'] #only for select attr types
    # }
    #
    # Response Hash:
    # { success: true, message: '' }
    # { success: false, message: error_message }

    class << self

      def add(options={})
        begin
          validate_add_options(options)
          details = parse_options(options)
          response = Mosaic::Lyris::Demographic.add(options[:type], options[:name], details)
          response.is_a?(Mosaic::Lyris::Demographic) ? request_success : request_failed
        rescue Exception => e
          request_failed(e, options)
        end
      end

      # Request
      # options={ name: 'Date of Birth', list: :master}
      # def delete(options={})
      #   begin
      #     validate_delete_options(options)
      #   rescue Exception => e
      #     request_failed(e, options)
      #   end
      # end

      def query_all
        EmailService::Constants::LISTS.inject({}) do |hash, list|
          name, id = list
          hash[name] = list_attributes(id)
          hash
        end
      end

      def validate(attributes={})
        attribute_names = valid_attributes.keys
        raise "Valid enabled :attributes are #{attribute_names}" if attributes.present? && !(attributes.keys - attribute_names).empty?
      end

      def parse_attributes(attributes={})
        attributes.inject({}) do |hash, pair|
          key, value = pair
          hash[valid_attributes[key]] = value
          hash
        end
      end

      def attributes_mapping
        @@attributes_mapping
      end

      def valid_attributes
        @@valid_attributes
      end

      private
        def list_attributes(list_id)
          objects = Mosaic::Lyris::Demographic.query(:all, {:list_id => list_id}).select{|x| x.enabled}
          objects.inject({}) { |hash, obj| hash[symbolize(obj.name)] = obj.id; hash }
        rescue
          {}
        end

        def validate_add_options(options)
          raise 'Attribute option :name is mandatory' unless options[:name].present?
          raise 'Attribute option :type is mandatory' unless options[:type].present?
        end

        def parse_options(options)
        {
          list_id: EmailService::List.list_id(options[:list]),
          enabled: options[:enabled] || true,
          options: options[:options]
        }
        end
    end

    @@attributes_mapping ||= self.query_all
    @@valid_attributes ||= @@attributes_mapping.values.reduce(&:merge)
  end
end