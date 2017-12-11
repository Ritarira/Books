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
    @author.destroy
    head 204
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.permit(:first_name, :last_name)
  end
end
