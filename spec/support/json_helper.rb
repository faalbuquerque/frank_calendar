module JsonHelper
  def json_parse
    JSON.parse(last_response.body)
  end
end
