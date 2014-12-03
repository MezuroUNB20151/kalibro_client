require 'kalibro_client'
require 'json'

describe KalibroClient::Processor::MetricCollector, :type => :model do
  describe 'methods' do
    let(:metric_collector_name) { "Analizo" }

    describe 'all_names' do
      context 'with available metric collectors' do
        before :each do
          response = {"all_names" => [metric_collector_name]}.to_json
          KalibroClient::Processor::MetricCollector.expects(:get).with(:all_names).returns(response)
        end

        it 'should return a list of names' do
          expect(KalibroClient::Processor::MetricCollector.all_names).to eq([metric_collector_name])
        end
      end
      
      context 'without available metric collectors' do
        before :each do
          response = {"all_names" => []}.to_json
          KalibroClient::Processor::MetricCollector.expects(:get).with(:all_names).returns(response)
        end

        it 'should return a list of names' do
          expect(KalibroClient::Processor::MetricCollector.all_names).to eq([])
        end
      end
    end
    
    describe 'find' do
      let(:metric_collector_details_attributes) { FactoryGirl.attributes_for(:metric_collector_details) }
      let(:metric_collector_details) { FactoryGirl.build(:metric_collector_details) }
      context 'Succesfully found' do
        before :each do
          response = mock("response")
          response.expects(:body).returns(JSON.generate({metric_collector_details: metric_collector_details_attributes}))
          KalibroClient::Processor::MetricCollector.expects(:post).with(:find, {name: metric_collector_details_attributes[:name]}).returns(response)
        end

        it 'should return a hash containing the metric collector details' do
          expect(KalibroClient::Processor::MetricCollector.find(metric_collector_details_attributes[:name])).to eq(metric_collector_details)
        end
      end
      
      context 'Not found' do
        before :each do
          response = mock("response")
          response.expects(:body).returns({error: "Metric Collector name not found."}.to_json)
          KalibroClient::Processor::MetricCollector.expects(:post).returns(response)
        end

        it 'should return a error' do
          expect(KalibroClient::Processor::MetricCollector.find("name")).to be_nil
        end
      end

    end
  end
end
