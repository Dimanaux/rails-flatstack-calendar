class AccountsController < ApplicationController
  before_action :set_account, only: [:show]

  def show
    @events = @account.events
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:id)
  end
end
