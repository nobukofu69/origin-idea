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
end
