module KalibroClient
  module Processor
    class Base
      include Her::Model
      use_api PROCESSOR_API
    end
  end
end
