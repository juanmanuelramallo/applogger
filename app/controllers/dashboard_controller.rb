class DashboardController < ApplicationController
  def index
    @dashboard = DashboardPresenter.new(from_time: from_time, to_time: to_time)
    @calculator = Calculator.new(entries)
  end

  private

  def entries
    @entries ||= begin
      where_options = entries_params.to_h.select { |_key, value| value.present? }
      Entry.where(where_options.merge(timestamp: from_time..to_time))
    end
  end

  def entries_params
    params.permit(:user_agent, :path, :country_code)
  end

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
