class DashboardController < ApplicationController
  def index
    @calculator = Calculator.new(from_date: from_date, to_date: to_date)
  end

  private

  def from_date
    return Date.today - 1.month if params[:from_date].blank?

    Date.strptime(params[:from_date], '%Y-%m-%d')
  end

  def to_date
    return Date.today if params[:to_date].blank?

    Date.strptime(params[:to_date], '%Y-%m-%d')
  end
end
