module ReviewsHelper
  def extract_original_text(text)
    match_data = text.match(/^(.+)\s*\(Translated by Google\)/m)
    match_data ? match_data[1].strip : text
  end
end
