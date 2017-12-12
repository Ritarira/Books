class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    render json: Book.all, include: { author: { only: [:first_name, :last_name] } }
  end

  def show
    render json: @book, include: { author: { only: [:first_name, :last_name] } }
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head 204
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.permit(:author_id, :title, :description, :rating)
  end
end
