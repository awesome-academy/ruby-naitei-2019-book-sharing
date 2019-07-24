class BooksController < ApplicationController
  def index; end

  def show
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:warrning] = t "book_not_found"
    redirect_to root_path
  end
end
