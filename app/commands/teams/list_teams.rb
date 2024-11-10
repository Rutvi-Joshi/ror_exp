module Teams
class ListTeams
    prepend SimpleCommand

    # attr_accessor :params, :user, :teams
  
    def initialize(params, user, teams)
      @params = params
      @user = user
      @teams = teams
    end
  
    def call
        begin
            # Apply search
            if @params[:search].present?
                teams = @teams.where("name ILIKE ? OR description ILIKE ?", "%#{@params[:search]}%", "%#{@params[:search]}%")
            end
            
            # Apply sort
            if @params[:sort_by].present? && @params[:sort_order].present?
                sort_order = %w[asc desc].include?(@params[:sort_order].downcase) ? @params[:sort_order] : 'asc'
                teams = @teams.order("#{@params[:sort_by]} #{sort_order}")
            end
        
            # Pagination
            @teams.paginate(page: @params[:page], per_page: @params[:per_page])
            return { status: 200, success: true, message: "Team Listing", data: @teams } 
        rescue => e
            return errors.add(:base, { status: 801, success: false, message: e.message })
        end
    end
  end
end