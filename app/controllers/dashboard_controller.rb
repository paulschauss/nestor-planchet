class DashboardController < ApplicationController
  before_action :set_service, only: [:show]

  def show
    account_id = @service.fetch_accounts
    if account_id
      @reviews = @service.fetch_all_reviews(account_id)
    else
      sign_out(current_user)
      reset_session
      redirect_to new_user_session_path, alert: "Your session has expired. Please sign in again."
    end

    if request.patch?
      if current_user.update(business_type_params)
        redirect_to dashboard_path
      else
        render :show
      end
    end
  end

  def generate_response
    service = GetResponseService.new(params[:location_name], params[:review], params[:business_type])
    response = service.call
    render json: {response: response}
  end

  private

  def set_service
    access_token = current_user.connected_accounts.first.access_token # TO DO - Considèrer une approche plus robuste
    @service = GoogleMyBusinessService.new(access_token)
  end

  def business_type_params
    params.require(:user).permit(:business_type)
  end
end
