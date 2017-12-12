class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    render json: Author.all
  end

  def show
    render json: @author
  end

  def create
    author = Author.new(params.permit(:first_name, :last_name))
    
    if author.save
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render json: @author, status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if referential_integrity_errors = check_referential_integrity
      render json: { errors: referential_integrity_errors }, status: :unprocessable_entity
    else
      @author.destroy
      head 204
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.permit(:first_name, :last_name)
  end

  def check_referential_integrity
    'Author has books' if @author.books.any?
  end
end
