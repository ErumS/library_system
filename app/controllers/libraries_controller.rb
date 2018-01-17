class LibrariesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @libraries = Library.all
    if @libraries
      respond_to do |format|
        format.json {render json: {library: @libraries}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @libraries.errors}, status: :not_found}
      end
    end
  end 

  def show
    begin
      @library = Library.find(params[:id])
      respond_to do |format|
        format.json {render json: {library: @library}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @library = Library.new
  end 

  def edit
    @library = Library.find(params[:id])
  end

  def create
    @library = Library.new(library_params)
    if @library.save
      respond_to do |format|
        format.json {render json: {library: @library}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @library.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @library = Library.find(params[:id]) 
      if @library.update(library_params)  
        respond_to do |format|
          format.json {render json: {library: @library}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @library.errors}, status: :unprocessable_entity}
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
      @library = Library.find(params[:id])
      if @library.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @library.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def library_params
      params.require(:library).permit(:name, :address, :phone_no)
    end
end