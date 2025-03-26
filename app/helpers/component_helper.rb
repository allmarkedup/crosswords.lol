module ComponentHelper
  # Elements

  def icon(name, **)
    render "components/elements/icon", name: name, **
  end

  def button(*args, **, &)
    if args.size == 1
      label, icon = args.first.is_a?(Symbol) ? [nil, args.first] : [args.first, nil]
    else
      label, icon = args
    end

    render "components/elements/button", label:, icon:, **, &
  end

  def modal(**, &)
    render "components/elements/modal", **, &
  end

  # Forms

  def form_errors(errors)
    render "components/forms/errors", errors:
  end
end
