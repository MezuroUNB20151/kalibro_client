FactoryGirl.define do
  factory :kalibro_range, class: KalibroClient::Configurations::KalibroRange do
    id 1
    beginning 0.5
    self.end 1.5
    comments "Range comments"
    reading nil
    metric_configuration nil
  end

end
