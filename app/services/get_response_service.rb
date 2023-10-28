require "json"
require "faraday"

class GetResponseService
  BASE_URL = "https://hook.eu1.make.com/nk1ghfwxxigtnrjmf5mrw9br2k5ppwb8".freeze

  def initialize(location_name, review, business_type)
    @location_name = location_name
    @review = review
    @business_type = business_type
  end

  def call
    response = connection.post do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.body = URI.encode_www_form({
        Location_name: @location_name,
        Review: @review,
        Business_type: @business_type
      })
    end

    JSON.parse(response.body)
  end

  private

  def connection
    Faraday.new(url: BASE_URL) do |conn|
      conn.adapter Faraday.default_adapter
    end
  end
end
