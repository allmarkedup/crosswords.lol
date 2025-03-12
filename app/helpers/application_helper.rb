module ApplicationHelper
  def crosswords_dot_lol
    link_to root_path, class: "crosswords-dot-lol" do
      safe_join([
        image_tag("icon.svg", alt: "Crosswords.lol logo"),
        tag.span("crosswords.lol")
      ])
    end
  end

  def recent_crossword_path
    session[:latest_crossword_number] ? crossword_path(session[:latest_crossword_number]) : root_path
  end

  def back_to_crosswords_link
    link_to(
      "Back to the crossword#{"s" unless session[:latest_crossword_number]}",
      recent_crossword_path,
      "@click.prevent": "hijax"
    )
  end
end
