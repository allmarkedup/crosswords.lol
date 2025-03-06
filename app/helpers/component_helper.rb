module ComponentHelper
  def icon(name, **)
    render IconComponent.new(name: name, **)
  end

  def button(*args, **, &block)
    if args.size == 1
      label, icon = args.first.is_a?(Symbol) ? [nil, args.first] : [args.first, nil]
    else
      label, icon = args
    end

    render ButtonComponent.new(label:, icon:, **), &block
  end

  def form_errors(errors)
    render FormErrorsComponent.new(errors:)
  end
end
