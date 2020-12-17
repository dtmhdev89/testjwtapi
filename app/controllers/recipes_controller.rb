class RecipesController < ApplicationController
  # before_action :authorized, only: :create

  def index
    recipe = Recipe.all.order(created_at: :desc)
    render json: recipe
  end

  def create
  end

  def show
  end

  def destroy
  end
end
