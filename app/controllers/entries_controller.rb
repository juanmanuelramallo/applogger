class EntriesController < ApplicationController
  def index
    @pagy, entries = pagy(Entry.all.order(timestamp: :desc))
    @entries = EntryPresenter.all(entries)
  end

  def show
    @entry = EntryPresenter.new(
      Entry.includes(:log).find(params[:id])
    )
  end
end
