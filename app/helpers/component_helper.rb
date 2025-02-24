module ComponentHelper
  def icon(name, **)
    render IconComponent.new(name: name, **)
  end

  def button(*args, **)
    if args.size == 1
      label, icon = args.first.is_a?(Symbol) ? [nil, args.first] : [args.first, nil]
    else
      label, icon = args
    end
    render ButtonComponent.new(label:, icon:, **)
  end
end
