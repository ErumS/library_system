class CategoriesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @categories = Category.all
    if @categories
      respond_to do |format|
        format.json {render json: {categories: @categories}, status: :ok }
      end
    else
      respond_to do |format| 
        format.json {render json: {error: @categories.errors}, status: :not_found}
    	end
    end
  end 

  def show
    begin
      @category = Category.find(params[:id])
      respond_to do |format|
        format.json {render json: {category: @category}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @category = Category.new
  end 

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.create(category_params)
    @library = Library.find_by_id(params[:library_id])
    if @category.save
      respond_to do |format|
        format.json {render json: {category: @category}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @category.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @category = Category.find(params[:id]) 
      if @category.update(category_params)  
        respond_to do |format|
          format.json {render json: {category: @category}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @category.errors}, status: :unprocessable_entity}
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
      @category = Category.find(params[:id])
      if @category.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @category.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def category_params
      params.require(:category).permit(:department, :library_id)
    end
end