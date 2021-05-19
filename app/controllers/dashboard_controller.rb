class DashboardController < ApplicationController
  def index
    @calculator = Calculator.new(from_time: from_time, to_time: to_time)
  end

  private

  def from_time
    @from_time ||= begin
      if params[:from_date].blank?
        Date.today - 1.week
      else
        Date.strptime(params[:from_date], '%Y-%m-%d')
      end
    end.beginning_of_day
  end

  def to_time
    @to_time ||= begin
      if params[:to_date].blank?
        Date.today
      else
        Date.strptime(params[:to_date], '%Y-%m-%d')
      end
    end.end_of_day
  end
end
