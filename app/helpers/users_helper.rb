module UsersHelper
  def bootstrap_alert(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "primary"
    when "error"
      "danger"
    end
  end
end
