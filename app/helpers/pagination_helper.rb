module PaginationHelper
  def pagination_meta(pagy)
    {
      current_page: pagy.page,
      next_page: pagy.next,
      prev_page: pagy.prev,
      total_pages: pagy.pages,
      total_count: pagy.count
    }
  end
end
