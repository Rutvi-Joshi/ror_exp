class TeamMembershipsController < ApplicationController
  before_action :set_team
  before_action :authorize_team_owner, only: %i[create destroy]

  # POST /teams/:team_id/memberships
  def create
    user = User.find_by(id: params[:user_id])
    return render json: { status: 404, success: false, message: "User not found" } unless user

    return render json: { status: 404, success: false, message: "Team not found" } unless @team

    # If the team and user exist, add the user to the team
    record = @team.members.uniq
    if record << user
      TeamMembership.create(user_id: user.id, team_id: @team.id)
      render json: { status: 201, success: true, message: "Team member added", data: record.as_json(except: [:password, :password_digest]) }
    else
      render json: { status: 500, success: false, message: "Failed to add team member" }
    end
  end

  # DELETE /teams/:team_id/memberships/:id
  def destroy
    membership = @team.team_memberships.find_by(user_id: params[:id])
    if membership.present?
      membership&.destroy
      render json: { status: 200, success: true, message: "Member Deleted" }
    else
      render json: { status: 404, success: false, message: "Membership not found" }
    end
  end

  # GET /teams/:team_id/memberships
  def index
    members = @team.members
    render json: { status: 200, success: true, message: "List team members", data: members }
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def authorize_team_owner
    render json: { error: 'Not authorized' }, status: :forbidden unless @team.owner == current_user
  end
end
