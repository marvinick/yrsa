module ReviewsHelper

  def count_details
    keys = []
    set_item.reviews.each do |review|
      review.properties.each_key do |k|
        keys << k
      end
    end
    keys.count
  end

  def count_reviews
    set_item.reviews.count
  end

  def show_value
    values = []
    set_item.reviews.each do |review|
      review.properties.each_value do |v|
        if v == '5'
          values << v.to_i
        end
      end
    end
    values
  end

  #calculate average rating for each review
  def each_review_rating
    keys = []
    values = []
    set_item.reviews.each do |review|
      review.properties.each do |k,v|
        keys << k
        values << v.to_i
      end
      return (values.sum.to_f / keys.uniq.size).round(1)
    end

  end

  #how many times a "key" got each "value" e.g a name "height" got 5 times of value "4", 2 times of value "1", 3 times of value "5", etc
  def count_value_frequency
    frequency = []
    set_item.reviews.each do |review|
      review.properties.each do |k, v|
        frequency << k
        frequency << v
      end
    end
    frequency.each_slice(2).to_a
  end


  def keys_and_values
    keys_values = []
    set_item.reviews.each do |review|
      review.properties.each do |k,v|
        keys_values << k.gsub(" ", "")
        keys_values << + v.to_i
      end
    end
    keys_values.each_slice(2).to_a
  end

  #sum all values for each key
  def total_keys_and_values
    result = Hash.new(0)
    keys_and_values.each { |subarray| result[subarray[0]] += subarray[1] }
    result
  end



end


#how many times total a value appears for each item
