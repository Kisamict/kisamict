def vending_machine(code, sum)

  items = [{:name=>"Snickers", :code=>"A01", :quantity=>10, :price=>250},

         {:name=>"Pepsi", :code=>"A02", :quantity=>5, :price=>350},

         {:name=>"Orange Juice", :code=>"A03", :quantity=>10, :price=>400},

         {:name=>"Bon Aqua", :code=>"A04", :quantity=>7, :price=>120},

         {:name=>"Bounty", :code=>"A05", :quantity=>10, :price=>270}]

  current_hash = items.select{|v| v if v[:code] == code}[0]
  name = current_hash[:name]
  price = current_hash[:price]

  case
  when current_hash[:quantity] == 0
   puts "#{name}: закончился"

  when price == sum
    puts name
    current_hash[:quantity] -= 1

  when sum > price
    puts "Ваша сдача: #{sum - price} рупий"
    current_hash[:quantity] -= 1

  when sum < price
   puts "Не хватает: #{price - sum} рупий"
  end
end
