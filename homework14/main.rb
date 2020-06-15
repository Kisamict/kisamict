require_relative "requireable"

class App
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def call
    loop do
      puts interface
      case accept_input
      when "0"
        return
      when "1"
        create_station
      when "2"
        create_train
      when "3"
        create_route
      when "4"
        create_wagon
      when "5"
        add_station
      when "6"
        remove_station
      when "7"
        assign_route
      when "8"
        hook_wagon
      when "9"
        unhook_wagon
      when "10"
        move_forward
      when "11"
        move_backward
      when "12"
        show_stations
      when "13"
        trains_on_station
      else
        invalid_input
      end
    end
  end

  private

  def interface
    [
      "1. Создать станцию",
      "2. Создать поезд",
      "3. Создать маршрут",
      "4. Создать вагон",
      "5. Добавить станцию в маршрут",
      "6. Удалить станцию из маршрута",
      "7. Назначить маршрут",
      "8. Прицепить вагон",
      "9. Отцепить вагон",
      "10. Начать движение поезда",
      "11. Вернуть поезд на предыдущую станцию",
      "12. Посмотреть список станций",
      "13. Посмотреть поезда на станции",
      "0. Выход"
    ]
  end

  def create_station
    print "Название новой станции: "
    @stations << Station.new(accept_input)
  end

  def create_train
    puts types
    case accept_input
    when "1"
      print "Номер поезда: "
      @trains << PassengerTrain.new(accept_input)
      puts "Поезд создан"
    when "2"
      print "Номер поезда: "
      @trains << CargoTrain.new(accept_input)
      puts "Поезд создан"
    else
      invalid_input
    end
  end

  def types
    ["1. Пассажирский", "2. Грузовой"]
  end

  def create_route
    numered_list(@stations.map(&:name))
    puts "Выберите начальную и конечную станции"
    @routes << Route.new(my_find(@stations), my_find(@stations))
    puts "Маршрут создан"
  end

  def create_wagon
    puts types
    case accept_input
    when "1"
      print "Количество мест: "
      @wagons << PassengerWagon.new(accept_input)
      puts "Вагон создан"
    when "2"
      print "Объем: "
      @wagons << CargoWagon.new(accept_input)
      puts "Вагон создан"
    else
      invalid_input
    end
  end

  def add_station
    puts "Станция добавлена" if choose_route.add(choose_station)
  end

  def remove_station
    puts "Станция удалена" if choose_route.remove(choose_station)
  end

  def assign_route
    puts "Маршрут назначен" if choose_train.route=(choose_route)
  end

  def hook_wagon
    puts "Вагон прицплен" if choose_train.hook(choose_wagon)
  end

  def unhook_wagon
    puts "Вагон отцеплен" if choose_train.unhook(choose_wagon)
  end

  def move_forward
    train = choose_train
    train.move_forward ? (puts "Поезд отправился тправился на станцию #{train.current_station.name}") : (puts "Ошибка")
  end

  def move_backward
    train = choose_train
    train.move_backward ? (puts "Поезд отправился на станцию #{train.current_station.name}") : (puts "Ошибка")
  end

  def show_stations
    numered_list(@stations.map(&:name))
  end

  def trains_on_station
    numered_list(choose_station.trains)
  end

  def my_find(array)
    array[accept_input.to_i - 1]
  end

  def numered_list(array)
    array.each.with_index(1) {|element, index| puts "#{index}: #{element}"}
  end

  def choose_train
    puts "Поезд?"
    numered_list(@trains)
    @trains[accept_input.to_i-1]
  end

  def choose_station
    puts "Станция?"
    numered_list(@stations.map(&:name))
    @stations[accept_input.to_i-1]
  end

  def choose_route
    puts "Маршрут?"
    numered_list(@routes)
    @routes[accept_input.to_i-1]
  end

  def choose_wagon
    puts "Вагон?"
    numered_list(@wagons)
    @wagons[accept_input.to_i-1]
  end

  def invalid_input
    puts "Неправильный ввод"
  end

  def accept_input
    gets.chomp.strip
  end
end

App.new.call
