module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      reject_unauthorized_connection unless current_user
    end

    private

    # 認証済みのユーザーがいない場合､接続を拒否する
    def find_verified_user
      env['warden'].user || reject_unauthorized_connection
    end
  end
end
