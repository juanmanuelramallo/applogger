class EntriesController < ApplicationController
  def index
    @pagy, @entries = pagy(Entry.all.order(timestamp: :desc))
  end
end
