require 'monorails/version'
require 'thread_hazardous'

require 'active_support/version'
require 'active_support/per_thread_registry'

if ActiveSupport.version < Gem::Version.new('4.1')
  require 'monorails/per_thread_registry_40'
else
  require 'monorails/per_thread_registry'
end

if ActiveSupport.version < Gem::Version.new('4.2')
  require 'active_record'
  require 'monorails/attribute_methods'
end
