files_in_order = %w( constants base contact list attribute )
.each do |file|
  require File.join(File.dirname(__FILE__),'email_service',file)
end
