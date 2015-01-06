module KalibroClient
  module Configurations
    class Base
      include Her::Model
      use_api CONFIGURATIONS_API
    end
  end
end
