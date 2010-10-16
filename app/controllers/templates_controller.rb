class TemplatesController < ApplicationController
  layout 'wizard'
  before_filter :template, :only => [:edit, :show, :destroy, :compile]
    
  def create
    if @template = RailsTemplate.create(params[:rails_template])
      redirect_to edit_path(@template)
    else
      flash[:alert] = 'Unable to create a template. Something is wrong.'
      redirect_to root_path
    end
  end
  
  def edit
    params[:step] ||= 'app_info'
    @page_title = template.name
    @heading = params[:step].titleize
  end
  
  def compile
    render :action => 'compile', :content_type => 'text/plain', :layout => false
  end
  
  def update
    if template.update_attributes(params[:rails_template])
      redirect_to step_path(template, next_step)
    else
      flash.now[:alert] = 'Unable to update template.'
      render :action => params[:step]
    end
  end
  
  protected
  
  def template
    @template ||= RailsTemplate.from_param(params[:id])
  end
  helper_method :template
  
  def next_step
    RailsTemplate::STEPS[RailsTemplate::STEPS.index(params[:step]) + 1]
  end
  
  def previous_step
    RailsTemplate::STEPS[RailsTemplate::STEPS.index(params[:step]) - 1]
  end
  
  helper_method :next_step, :previous_step
end
