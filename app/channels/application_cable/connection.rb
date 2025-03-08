module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account

    def connect
      self.current_account = Account.find(cookies.encrypted["_crisscross_session"]["current_account_id"])

      reject_unauthorized_connection unless current_account
    end
  end
end
