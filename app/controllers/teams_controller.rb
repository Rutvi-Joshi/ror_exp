class TeamsController < ApplicationController
    before_action :fetch_team, only: %i[show update destroy]
    before_action :authorize_team_owner, only: %i[update destroy]

  # POST /teams
  def create
    @team = current_user.owned_teams.build(team_params)
    if @team.save
        render json: { status: 201, success: true, message: "Team created successfully", data: @team }
    else
        render json: { status: 422, success: false, message: @team.errors }
    end
  end

  # GET /teams
  def index
    @teams = Team.all
    command = ::Teams::ListTeams.call(params, current_user, @teams)
    if command.success?
        response = command.result
        render json: { status: response[:status], success:  response[:success], message: response[:message], data: response[:data]}
      else
        response = command.errors[:base].first
        render json: { status: response[:status], success:  response[:success], message: response[:message] }
      end
  end

  # GET /teams/:id
  def show
    if @team.present?
        render json: { status: 200, success: true, message: "Team Details", data: @team }
    else
        render json: { status: 404, success: false, message: "Team not found" }
    end
  end

  # PATCH/PUT /teams/:id
  def update
    if @team.update(team_params)
      render json: { status: 200, success: true, message: "Team Details", data: @team }
    else
      render json: { status: 422, success: false, message: @team.errors }
    end
  end

  # DELETE /teams/:id
  def destroy
    if @team.present?
        @team.destroy
        render json: { status: 200, success: true, message: "Team Deleted" }
    else
        render json: { status: 404, success: false, message: "Team not found" }
    end
  end

  private

  def fetch_team
    @team = Team.find(params[:id])
  end

  def authorize_team_owner
    render json: { error: 'You are not authorised to perform this action' }, status: :forbidden unless @team.owner == current_user
  end

  def team_params
    params.permit(:name, :description)
  end
end
