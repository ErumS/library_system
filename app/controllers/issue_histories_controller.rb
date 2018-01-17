class IssueHistoriesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @issue_histories = IssueHistory.all
    if @issue_histories
      respond_to do |format|
        format.json {render json: {issue_histories: @issue_histories}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @issue_histories.errors}, status: :not_found}
    	end
    end
  end 

  def show
    begin
      @issue_history = IssueHistory.find(params[:id])
      respond_to do |format|
        format.json {render json: {issue_history: @issue_history}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @issue_history = IssueHistory.new
  end 

  def edit
    @issue_history = IssueHistory.find(params[:id])
  end

  def create
    @issue_history = IssueHistory.new(issue_history_params)
    @member = Member.find_by_id(params[:member_id])    
    if @issue_history.save
      respond_to do |format|
        format.json {render json: {issue_history: @issue_history}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @issue_history.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @issue_history = IssueHistory.find(params[:id]) 
      if @issue_history.update(issue_history_params)  
        respond_to do |format|
          format.json {render json: {issue_history: @issue_history}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @issue_history.errors}, status: :unprocessable_entity}
        end
      end   
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end    
  end
  
  def destroy
    begin
      @issue_history = IssueHistory.find(params[:id])
      if @issue_history.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @issue_history.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def issue_history_params
      params.require(:issue_history).permit(:member_id, :book_id, :issue_date, :return_date, :copies)
    end
end