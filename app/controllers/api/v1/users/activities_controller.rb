class Api::V1::Users::ActivitiesContoller < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])
    if user
      hosted_parties = ViewingParty.where(host_id: user.id).map do |party|
  end
end