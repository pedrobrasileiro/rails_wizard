class TemplatesController < ApplicationController
  layout 'wizard'
  before_filter :template, :only => [:edit, :show, :destroy, :compile]
  
  def create
    if @template = RailsTemplate.create(params[:rails_template])
      redirect_to edit_path(@template) + '/#/app_info'
    else
      flash[:alert] = 'Unable to create a template. Something is wrong.'
      redirect_to root_path
    end
  end
  
  def edit
    @page_title = template.name
  end
  
  def compile
    render :action => 'compile', :content_type => 'text/plain', :layout => false
  end
  
  protected
  
  def template
    @template ||= RailsTemplate.from_param(params[:id]) || RailsTemplate.new
  end
  helper_method :template
end
