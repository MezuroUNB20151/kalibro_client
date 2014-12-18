require 'kalibro_client'

describe KalibroClient::Configurations::KalibroRange, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:kalibro_range) }

    describe 'save' do
      context 'with a valid kalibro_range' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end

        it 'should save the kalibro_range' do
          KalibroClient::Configurations::Base.any_instance.expects(:save).returns(true)
          expect(subject.save).to be_truthy
          expect(subject.prefix_options[:metric_configuration_id]).to eq(subject.metric_configuration.id)
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end
      end

      context 'with an invalid kalibro_range' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end

        it 'should not save the kalibro_range' do
          expect(KalibroClient::Configurations::KalibroRange.new.save).to be_falsey
        end

        it 'should not modify the prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end
      end
    end


    describe 'destroy' do
      context 'with a valid kalibro_range' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end

        it 'should not modify the prefix options after deletion' do
          KalibroClient::Configurations::Base.any_instance.expects(:destroy)
          subject.destroy
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end
      end

      context 'with an invalid kalibro_range' do
        it 'should have the default prefix options' do
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end

        it 'should not modify the prefix options after exception' do
          KalibroClient::Configurations::KalibroRange.new.destroy
          expect(KalibroClient::Configurations::KalibroRange.prefix).to eq "/"
        end
      end
    end
  end
end
