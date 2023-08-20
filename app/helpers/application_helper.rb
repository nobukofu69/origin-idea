module ApplicationHelper
  def translate_gender(gender)
    case gender
    when 'male'
      '男性'
    when 'female'
      '女性'
    when 'other'
      'その他'
    else
      '未設定'
    end
  end

  def hide_navbar?
    (controller_name == 'home' && action_name == 'top') ||
      (controller_path == 'devise/registrations' && action_name == 'new') ||
      (controller_path == 'devise/sessions' && action_name == 'new')
  end
end
