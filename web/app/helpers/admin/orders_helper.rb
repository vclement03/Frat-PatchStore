module Admin::OrdersHelper
  def sort_items(item)
    if item.club_id.nil?
      0
    else
      item.club_id
    end
  end
end
