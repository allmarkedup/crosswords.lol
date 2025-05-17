ViewSpec.spec "icon" do
  scenario "basic" do
    param :name, :symbol, default: :edit

    preview do
      icon params[:name]
    end

    tests do
      test "it renders" do
        render_preview
        assert_selector(%([data-component="icon"]))
      end

      test "it displays the correct icon" do
        render_preview(name: :smile)
        assert_selector(%([data-component="icon"] [data-lucide="smile"]))
      end
    end
  end
end
