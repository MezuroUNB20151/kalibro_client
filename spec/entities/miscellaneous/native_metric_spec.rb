require 'spec_helper'

describe KalibroClient::Entities::Miscellaneous::NativeMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE)
        languages = [:C, :CPP, :JAVA]
        metric_collector_name = "Analizo"
        native_metric = KalibroClient::Entities::Miscellaneous::NativeMetric.new(name, code, scope, languages, metric_collector_name)

        it 'should return an instance of NativeMetric' do
          expect(native_metric).to be_a(KalibroClient::Entities::Miscellaneous::NativeMetric)
        end
      end
    end

    describe 'to_object' do
      subject{ FactoryGirl.build(:loc) }

      context 'with a hash' do
        it 'is expected to create a object from the hash' do
          subject_hash = Hash[subject.to_hash.map { |k,v| if v.is_a?(Array) then [k.to_s, v] else [k.to_s, v.to_s] end}]
          expect(KalibroClient::Entities::Miscellaneous::NativeMetric.to_object(subject_hash)).to eq(subject)
        end
      end

      context 'with a metric' do
        it 'is expected to be the same object as the argument' do
          expect(KalibroClient::Entities::Miscellaneous::NativeMetric.to_object(subject)).to eq(subject)
        end
      end
    end
  end
end
