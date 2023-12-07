module ReviewsHelper
  def extract_original_text(text)
    match_data = text&.match(/\(Original\)(.+)/m)
    match_data ? match_data[1].strip : text
  end

  def string_to_integer(input)
    string_to_int_map = {
      "ZERO" => 0,
      "ONE" => 1,
      "TWO" => 2,
      "THREE" => 3,
      "FOUR" => 4,
      "FIVE" => 5
    }

    string_to_int_map[input]
  end
end
