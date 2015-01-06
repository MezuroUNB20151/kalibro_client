module KalibroClient
  module Configurations
    class KalibroRange < Base
      belongs_to :reading, class_name: KalibroClient::Configurations::Reading
      belongs_to :metric_configuration, class_name: KalibroClient::Configurations::MetricConfiguration

      collection_path "/metric_configurations/:metric_configuration_id/kalibro_ranges"
    end
  end
end

