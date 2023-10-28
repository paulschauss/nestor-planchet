require "json"
require "faraday"

class GoogleMyBusinessService
  def initialize(access_token)
    @access_token = access_token
  end

  def fetch_accounts
    response = connection.get("https://mybusinessaccountmanagement.googleapis.com/v1/accounts")
    accounts = JSON.parse(response.body)
    accounts["accounts"].first["name"] || []
  end

  def fetch_all_locations(account_id)
    fields_needed = "name,title,websiteUri,languageCode,phoneNumbers,serviceArea"

    response = connection.get(
      "https://mybusinessbusinessinformation.googleapis.com/v1/#{account_id}/locations",
      {parent: account_id, readMask: fields_needed}
    )
    locations = JSON.parse(response.body)
    locations["locations"]
  end

  def fetch_all_reviews(account_id)
    all_reviews = []
    locations = fetch_all_locations(account_id)
    locations.each do |location|
      location_id = location["name"]
      reviews = fetch_reviews(account_id, location_id)
      reviews&.each { |r| r["location_name"] = location["title"] }
      all_reviews.concat(reviews) if reviews
    end
    all_reviews
  end

  def fetch_reviews(account_id, location_id)
    response = connection.get("https://mybusiness.googleapis.com/v4/#{account_id}/#{location_id}/reviews")
    JSON.parse(response.body)["reviews"]
  end

  def reply_to_review(review_id, reply_text)
    body = {
      comment: reply_text
    }

    response = connection.put(
      "https://mybusiness.googleapis.com/v4/#{review_id}/reply",
      body.to_json,
      "Content-Type" => "application/json"
    )

    JSON.parse(response.body)
  end

  private

  def connection
    Faraday.new(url: "https://mybusiness.googleapis.com") do |conn|
      conn.headers["Authorization"] = "Bearer #{@access_token}"
      conn.adapter Faraday.default_adapter
    end
  end
end
