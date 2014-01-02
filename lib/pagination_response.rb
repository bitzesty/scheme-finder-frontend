class PaginationResponse
  include Enumerable

  delegate :each, to: :records

  attr_accessor :records, :total_count, :current_page, :limit

  def initialize(records, total_count_count, current_page, limit)
    @records = records
    @total_count = total_count
    @current_page = current_page
    @limit = limit
  end

  def for_kaminari
    Kaminari.paginate_array(records,
                            total_count: total_count,
                            limit: limit).page(current_page)
  end
end
