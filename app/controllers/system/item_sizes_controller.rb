class System::ItemSizesController < ApplicationController
    def index
      @pagy, @item_sizes = pagy(ItemSize.all.order(id: :asc))
    end
end
