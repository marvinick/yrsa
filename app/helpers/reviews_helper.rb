module ReviewsHelper

  def count_details
    keys = []
    set_item.reviews.each do |review|
      review.properties.each_key do |k|
        keys << k
      end
    end
    keys.uniq.count
  end
end
