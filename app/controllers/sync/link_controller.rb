module Sync
  class LinkController < ApplicationController
    rate_limit to: 3, within: 1.minute, only: [:create]

    before_action :ensure_devmode
    before_action :redirect_if_syncing, only: [:new, :create]

    layout "page"

    def new
      @account = Account.new
    end

    def create
      account = Account.find_by!(key: account_params[:key].downcase)
      session[:current_account_id] = account.id

      redirect_to sync_path, notice: "Syncing enabled"
    rescue ActiveRecord::RecordNotFound
      @account = Account.new
      @account.errors.add(:base, "Invalid sync key")
      render :new, status: :unprocessable_entity
    end

    def destroy
      session.delete(:current_account_id)
      Current.account = nil

      redirect_to new_sync_path, notice: "Syncing disabled", status: :see_other
    end

    private

    def account_params
      params.require(:account).permit(:key)
    end
  end
end
