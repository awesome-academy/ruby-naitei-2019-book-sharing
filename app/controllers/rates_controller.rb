class RatesController < ApplicationController
  before_action :find_book, only: [:create]

  def create
    rate = if @book
             @book.rates.new rate_params
           else
             Rate.new rate_params
           end
    rate.user_id = current_user.id
    rate.save
  end

  private

  def find_book
    @book = Book.find_by id: params[:book_id]
    @rate = @book.rates.find_by user_id: current_user.id

    @rate&.destroy
  end

  def rate_params
    params.permit :score, :user_id, :book_id
  end
end
