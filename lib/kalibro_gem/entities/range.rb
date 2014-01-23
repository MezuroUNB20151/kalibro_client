# This file is part of KalibroGem
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "kalibro_gem/entities/model"

module KalibroGem
  module Entities
    class Range < Model

      attr_accessor :id, :beginning, :end, :reading_id, :comments

      def id=(value)
        @id = value.to_i
      end

      def reading_id=(value)
        @reading_id = value.to_i
      end

      def beginning=(value)
        @beginning = value == "-INF" ? value : value.to_f  
      end

      def end=(value)
        @end = value == "INF" ? value : value.to_f
      end

      def label
        reading.label
      end

      def grade
        reading.grade
      end

      def color
        reading.color
      end

      def self.ranges_of(metric_configuration_id)
        self.create_objects_array_from_hash request(:ranges_of, {metric_configuration_id: metric_configuration_id} )[:range]
      end

      def save(metric_configuration_id)
        begin
          @id = self.class.request(:save_range, {:range => self.to_hash, :metric_configuration_id => metric_configuration_id})[:range_id]
          true
        rescue Exception => exception
          add_error exception
          false
        end
      end

      private

      def reading
        @reading ||= KalibroGem::Entities::Reading.find(reading_id)
        @reading
      end

      def self.all
        metric_configurations = []
        ranges = []
        configurations = Configuration.all

        configurations.each do |config|
          metric_configurations.concat(MetricConfiguration.metric_configurations_of(config.id))
        end

        metric_configurations.each do |metric_config|
          ranges.concat(self.ranges_of(metric_config.id))
        end

        return ranges
      end

      def self.find(id)
        self.all.each do |range|
          return range if range.id == id
        end 
        raise KalibroGem::Errors::RecordNotFound
      end

      def self.exists?(id)
        begin
          return true unless self.find(id).nil?
        rescue KalibroGem::Errors::RecordNotFound
          return false
        end
      end
    end
  end
end