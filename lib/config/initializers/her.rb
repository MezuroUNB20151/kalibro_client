CONFIGURATIONS_API = Her::API.new
CONFIGURATIONS_API.setup url: "http://localhost:8083" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

PROCESSOR_API = Her::API.new
PROCESSOR_API.setup url: "http://localhost:8082" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
