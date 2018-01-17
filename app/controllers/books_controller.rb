class BooksController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @books = Book.all
    if @books
      respond_to do |format|
        format.json {render json: {books: @books}, status: :ok }
      end
    else
      respond_to do |format|
        format.json {render json: {error: @books.errors}, status: :not_found}
    	end
    end
  end 

  def show
    begin
      @book = Book.find(params[:id])
      respond_to do |format|
        format.json {render json: {book: @book}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def new
    @book = Book.new
  end 

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @library = Library.find_by_id(params[:library_id])
    @category = Category.find_by_id(params[:category_id])
    if @book.save
      respond_to do |format|
        format.json {render json: {book: @book}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @book.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @book = Book.find(params[:id]) 
      if @book.update(book_params)  
        respond_to do |format|
          format.json {render json: {book: @book}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @book.errors}, status: :unprocessable_entity}
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
      @book = Book.find(params[:id])
      if @book.destroy
        respond_to do |format|
          format.json {render json: {message: 'Successfully deleted'}, status: :ok}
        end  
      else
        respond_to do |format|
          format.json {render json: {error: @book.errors}, status: :unprocessable_entity}
        end  
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def book_params
      params.require(:book).permit(:name, :code, :author, :price, :publication, :version, :library_id, :category_id)
    end
end