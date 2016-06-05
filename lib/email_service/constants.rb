require 'yaml'

module EmailService
  module Constants

    CONFIGURATION = YAML.load_file(File.join(File.dirname(__FILE__),'lyris_config.yml'))
    TECH_DEVS = %w{ tech.devs@xyz.com }  ## Email id where you would like to send Error reports
    LIST_PREFIX = {"development" => "s_", "staging" => "s_", "production" => "", "test" => "t_"}
    LISTS = {
      master: '241982',
      s_master: '247972'
    }
    MAIL_DEFAULTS = {
      list_id: '241986',
      trigger_id: '19268',
      from_email: 'notification.service@xyz.com',
      from_name: 'EmailService'
    }
  end
end