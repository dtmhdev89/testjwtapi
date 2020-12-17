class Recipe < ApplicationRecord
  validates :name, :ingredients, :instruction, presence: true
  before_validation :set_default_image, on: :create, if: ->{self.image.blank?}

  private

  def set_default_image
    self.image = ActionController::Base.helpers.asset_path("Sammy_Meal.jpg")
  end
end
