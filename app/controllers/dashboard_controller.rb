class DashboardController < ApplicationController
  def show
    access_token = current_user.connected_accounts.first.access_token # TO DO - Considèrer une approche plus robuste
    service = GoogleMyBusinessService.new(access_token)
    account_id = service.fetch_accounts
    @reviews = service.fetch_all_reviews(account_id)
  end
end
