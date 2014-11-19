FactoryGirl.define do
  factory :metric_snapshot, class: KalibroClient::Configurations::MetricSnapshot do
    id 1
    type "NativeMetricSnapshot"
    name "Lines of Code"
    description ""
    code "loc"
    metric_collector_name "Analizo"
    scope "CLASS"
  end
end
