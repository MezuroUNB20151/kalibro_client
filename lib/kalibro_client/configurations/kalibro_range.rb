module KalibroClient
  module Configurations
    class KalibroRange < Base
      belongs_to :reading, class_name: KalibroClient::Configurations::Reading
      belongs_to :metric_configuration, class_name: KalibroClient::Configurations::MetricConfiguration

      def save
        default_prefix = KalibroRange.prefix
        KalibroRange.prefix = "/metric_configurations/:metric_configuration_id/"
        begin
          @prefix_options[:metric_configuration_id] = metric_configuration.id
          saved = super
        rescue NoMethodError, ActiveResource::ResourceNotFound, ActiveResource::BadRequest
          saved = false
        ensure
          KalibroRange.prefix = default_prefix
        end
        return saved
      end

      def destroy
        default_prefix = KalibroRange.prefix
        KalibroRange.prefix = "/metric_configurations/:metric_configuration_id/"
        begin
          @prefix_options[:metric_configuration_id] = metric_configuration.id
          super
        rescue NoMethodError, ActiveResource::ResourceNotFound
        ensure
          KalibroRange.prefix = default_prefix
        end
      end
    end
  end
end

