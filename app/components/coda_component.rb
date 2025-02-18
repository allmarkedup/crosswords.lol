class CodaComponent < BaseComponent
  renders_one :next_link, ->(href:, disabled: false) do
    helpers.link_to "Next", href, class: ["coda-link coda-link-next", {disabled:}], "@click.prevent": "hijax"
  end

  renders_one :previous_link, ->(href:, disabled: false) do
    helpers.link_to "Previous", href, class: ["coda-link coda-link-previous", {disabled:}], "@click.prevent": "hijax"
  end

  renders_one :random_link, ->(href:) do
    helpers.link_to "Random", href, class: ["coda-link coda-link-random"], "@click.prevent": "hijax"
  end
end
