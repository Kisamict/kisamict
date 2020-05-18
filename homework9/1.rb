$items = [{:name=>"Snickers", :code=>"A01", :quantity=>10, :price=>250},

       {:name=>"Pepsi", :code=>"A02", :quantity=>5, :price=>350},

       {:name=>"Orange Juice", :code=>"A03", :quantity=>10, :price=>400},

       {:name=>"Bon Aqua", :code=>"A04", :quantity=>7, :price=>120},

       {:name=>"Bounty", :code=>"A05", :quantity=>10, :price=>270}]


def vending_machine(code, sum)

  current_hash = $items.detect{|item| item if item[:code] == code}
  name = current_hash[:name]
  price = current_hash[:price]

  return puts "#{name}: закончился" if current_hash[:quantity] == 0

  if  price == sum
    puts name
    current_hash[:quantity] -= 1

  elsif sum > price
    puts "Ваша сдача: #{sum - price} рупий"
    current_hash[:quantity] -= 1

  else
   puts "Не хватает: #{price - sum} рупий"
  end
end
