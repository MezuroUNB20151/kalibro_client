module KalibroClient
  module Configurations
    class Reading < Base
      belongs_to :reading_group, class_name: KalibroClient::Configurations::ReadingGroup
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      collection_path "/reading_groups/:reading_group_id/readings"

      def self.find(id)
        Reading.collection_path "/readings"
        reading = super(id)
        Reading.collection_path "/reading_groups/:reading_group_id/readings"
        reading
      end
    end
  end
end

