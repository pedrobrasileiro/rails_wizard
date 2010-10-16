class RecipesController < ApplicationController
  before_filter do
    @page_title = "RailsWizard Recipes"
  end
  
  def new
    @heading = "Create a New Recipe"
  end
  
  protected
  
  def recipe
    @recipe ||= Recipe.from_param(params[:id]) || Recipe.new
  end
  helper_method :recipe
end
