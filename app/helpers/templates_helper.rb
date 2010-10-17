module TemplatesHelper
  def step(name, &block)
    if template
      link_to step_path(template, name), :class => step_class(name), &block
    else
      link_to '#', :class => 'disabled', &block
    end
  end
  
  def step_class(step)
    classes = []
    classes << 'current' if step == params[:step]
    classes << 'complete' if template.respond_to?(step + '?') && template.send("#{step}?")
    classes.join(' ')
  end
end
