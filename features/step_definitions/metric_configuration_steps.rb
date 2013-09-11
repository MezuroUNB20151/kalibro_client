Given(/^I have a metric configuration within the given configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, 
                    {id: nil,
                     reading_group_id: FactoryGirl.create(:reading_group).id,
                     configuration_id: @configuration.id})
end

When(/^I search a metric configuration with the same id of the given metric configuration$/) do
  @found_metric_configuration = KalibroEntities::Entities::MetricConfiguration.find(@metric_configuration.id)
end

When(/^I search an inexistent metric configuration$/) do
  @is_error = false
  inexistent_id = rand(Time.now.to_i)
  begin 
  	KalibroEntities::Entities::MetricConfiguration.find(inexistent_id)
  rescue KalibroEntities::Errors::RecordNotFound
  	@is_error = true 
  end
end

When(/^I request all metric configurations of the given configuration$/) do
  @metric_configurations = KalibroEntities::Entities::MetricConfiguration.metric_configurations_of(@configuration.id)
end

Then(/^it should return the same metric configuration as the given one$/) do
  @found_metric_configuration == @metric_configuration
end

Then(/^I should get a list of its metric configurations$/) do
  @metric_configurations == [@metric_configuration]
end

Then(/^I should get an empty list of metric configurations$/) do
  @metric_configurations == []
end
