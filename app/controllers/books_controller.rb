class BooksController < ApplicationController
  skip_before_action :authorized, only: :index

  def index
    render json: Book.all.as_json(except: [:created_at, :updated_at, :content])
  end

  def show
    render json: Book.find_by(id: params[:id]).as_json(except: [:created_at, :updated_at])
  end
end
