class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def reply
    review_id = params[:id]
    reply_text = params[:reply]

    access_token = current_user.connected_accounts.first.access_token # TO DO - Considèrer une approche plus robuste
    service = GoogleMyBusinessService.new(access_token)
    response = service.reply_to_review(review_id, reply_text)

    if response["comment"]
      redirect_to user_root_path, notice: "Votre réponse a été envoyée avec succès."
    else
      redirect_to user_root_path, alert: "Il y a eu un problème lors de l'envoi de la réponse."
    end
  end
end
