require 'spec_helper'

describe KalibroClient::Miscellaneous::CompoundMetric, :type => :model do
  describe 'methods' do
    describe 'initialize' do
      context 'with valid attributes' do
        name = "Sample name"
        code = "sample_code"
        scope = KalibroClient::Miscellaneous::Granularity.new(:SOFTWARE)
        script = "return 0;" #TODO Decide what script will be.
        compound_metric = KalibroClient::Miscellaneous::CompoundMetric.new(name, code, scope, script)

        it 'should return an instance of CompoundMetric' do
          expect(compound_metric).to be_a(KalibroClient::Miscellaneous::CompoundMetric)
        end
        it 'should have the right attributes' do #FIXME This test is testing our knowledge of Ruby, delete it at your will.
          expect(compound_metric.compound).to be_truthy
          expect(compound_metric.name).to eq(name)
          expect(compound_metric.code).to eq(code)
          expect(compound_metric.scope).to eq(scope)
        end
      end
    end
  end
end