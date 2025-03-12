module ApplicationHelper
  def back_to_crosswords_link
    link_to(
      "Back to the crossword#{"s" unless session[:latest_crossword_number]}",
      session[:latest_crossword_number] ? crossword_path(session[:latest_crossword_number]) : root_path
    )
  end
end
