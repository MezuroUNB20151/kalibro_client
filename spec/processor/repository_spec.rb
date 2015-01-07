require 'kalibro_client'

describe KalibroClient::Processor::Repository, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:repository) }

    describe 'last_processing' do
      context 'with no processing at all' do
        before :each do
          KalibroClient::Processor::Repository.expects(:get_raw).with("/repositories/#{subject.id}/has_ready_processing").returns({parsed_data: {data: {has_ready_processing: false}}})
          KalibroClient::Processor::Repository.expects(:post_raw).with("/repositories/#{subject.id}/last_processing").returns({parsed_data: {data: nil}})
        end

        it 'should return nil' do
          expect(subject.last_processing).to be_a KalibroClient::Processor::Processing
        end
      end

      context 'with a ready processing' do
        let(:processing_params) { Hash[FactoryGirl.attributes_for(:processing)] }
        let(:processing) { FactoryGirl.build(:processing) }
        before :each do
          KalibroClient::Processor::Repository.expects(:get_raw).with("/repositories/#{subject.id}/has_ready_processing").returns({parsed_data: {data: {has_ready_processing: true}}})
        end

        it 'should return a ready processing processing' do
          KalibroClient::Processor::Repository.expects(:get_raw).with("/repositories/#{subject.id}/last_ready_processing").returns({parsed_data: {data: {last_ready_processing: processing_params}}})

          expect(subject.last_processing).to eq(processing)
        end
      end

      context 'with no ready processing' do
        let(:processing_params) { Hash[FactoryGirl.attributes_for(:processing, state: 'COLLECTING')] }
        let(:processing) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        before :each do
          KalibroClient::Processor::Repository.expects(:get_raw).with("/repositories/#{subject.id}/has_ready_processing").returns({parsed_data: {data: {has_ready_processing: false}}})
        end

        it 'should return the latest processing' do
          KalibroClient::Processor::Repository.expects(:post_raw).with("/repositories/#{subject.id}/last_processing").returns({parsed_data: {data: processing_params}})

          expect(subject.last_processing).to eq(processing)
        end
      end
    end

    describe 'has_processing' do
      it 'is expected to return true when there is a processing' do
        KalibroClient::Processor::Repository.expects(:get_raw).with("/repositories/#{subject.id}/has_processing").returns({parsed_data: {data: {has_processing: true}}})

        expect(subject.has_processing).to be_truthy
      end
    end

    describe 'module_result_history_of' do
      let!(:module_result) {FactoryGirl.build(:module_result)}
      # let(:module_result_params) { Hash[FactoryGirl.attributes_for(:module_result).map { |k,v| [k.to_s, v.to_s] }] } #FIXME: Mocha is creating the expectations with strings, but FactoryGirl r
      let!(:time) { Time.now }
      before :each do
        date_module_result = mock(:date_module_result)
        date_module_result.expects(:date).returns(time)
        date_module_result.expects(:module_result).returns(module_result)

        KalibroClient::Processor::Repository.expects(:post_raw).with("/repositories/#{subject.id}/module_result_history_of", module_id: module_result.kalibro_module.id).returns({parsed_data: {data: [[time, module_result]]}})
        #KalibroClient::Miscellaneous::DateModuleResult.expects(:new).with(date: time, module_result: module_result).returns(date_module_result)

        @history = subject.module_result_history_of(module_result)
      end

      it 'is expected to return just one DateModuleResult' do
        expect(@history.count).to eq(1)
      end

      it 'is expected to return the given module result and date' do
        expect(@history.first.date).to eq(Time.parse(time.to_json))
        expect(@history.first.module_result).to eq(module_result)
      end
    end

    describe 'metric_result_history_of' do
      let!(:module_result) {FactoryGirl.build(:module_result)}
      let!(:metric_result) {FactoryGirl.build(:metric_result)}
      let!(:time) { Time.now }
      before :each do
        response = mock('response')
        response.expects(:body).returns({metric_result_history_of: [[time, module_result]]}.to_json)
        subject.expects(:post).with(:metric_result_history_of, module_id: module_result.kalibro_module.id, metric_name: metric_result.metric.name).returns(response)

        @history = subject.metric_result_history_of(module_result, metric_result)
      end

      it 'is expected to return just one DateMetricResult' do
        expect(@history.count).to eq(1)
      end

      it 'is expected to return the given metric result and date' do
        expect(@history.first.date).to eq(Time.parse(time.to_json))
        expect(@history.first.metric_result).to eq(metric_result)
      end
    end
  end
end
