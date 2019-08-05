class BooksController < ApplicationController
  def index
    @books = Book.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @books.map{|t| {label: t.name, value: t.id}}
  end

  def search
    @books = Book.all
    @books = Book.search(params[:q]) if params[:q]
  end

  def show
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:warrning] = t "book_not_found"
    redirect_to root_path
  end
end
