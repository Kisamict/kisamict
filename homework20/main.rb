require_relative "requireable"

class App
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
    @named_stations = stations_names
  end

  def call
    loop do
      puts INTERFACE_OPTIONS
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
      when "15"
        stations
      else
        invalid_input
      end
    end
  end

  private

  attr_accessor :named_stations

  INTERFACE_OPTIONS = [
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
  ].map(&:freeze).freeze

  TYPES = ["Пассажирский", "Грузовой"].map(&:freeze).freeze

  def create_station
    print "Название новой станции: "
    @stations << Station.new(accept_input)
    self.named_stations = stations_names
  end

  def create_train
    numered_list(TYPES)
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
      puts invalid_input
    end
  end

  def create_route
    numered_list(named_stations)
    puts "Выберите начальную и конечную станции"
    @routes << Route.new(find_object(@stations), find_object(@stations))
    puts "Маршрут создан"
  end

  def create_wagon
    numered_list(TYPES)
    case accept_input
    when "1"
      print "Количество мест: "
      @wagons << PassengerWagon.new(accept_input.to_i)
      puts "Вагон создан"
    when "2"
      print "Объем: "
      @wagons << CargoWagon.new(accept_input.to_i)
      puts "Вагон создан"
    else
      puts invalid_input
    end
  end

  def add_station
    route = choose_route
    puts "Станция добавлена" if route.add(choose_station)
  end

  def remove_station
    route = choose_route
    puts "Станция удалена" if route.remove(choose_station)
  end

  def assign_route
    train = choose_train
    puts "Маршрут назначен"if train.route=(choose_route)
  end

  def hook_wagon
    train = choose_train
    puts "Вагон прицплен" if train.hook(choose_wagon)
  end

  def unhook_wagon
    train = choose_train
    puts "Вагон отцеплен" if train.unhook(choose_wagon)
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
    numered_list(named_stations)
  end

  def trains_on_station
    numered_list(choose_station.trains)
  end

  def choose_train
    puts "Поезд?"
    numered_list(@trains)
    find_object(@trains)
  end

  def choose_station
    puts "Станция?"
    numered_list(named_stations)
    find_object(@stations)
  end

  def choose_route
    puts "Маршрут?"
    numered_list(@routes)
    find_object(@routes)
  end

  def choose_wagon
    puts "Вагон?"
    numered_list(@wagons)
    find_object(@wagons)
  end

  def find_object(array)
    input = accept_input
    return puts invalid_input if input.to_i > array.length || input == 0
    array[input.to_i-1]
  end

  def numered_list(array)
    array.each.with_index(1) {|element, index| puts "###{index}: #{element}"}
  end

  def stations_names
    @stations.map(&:name)
  end

  def invalid_input
    "Неправильный ввод"
  end

  def accept_input
    gets.chomp.strip
  end
end

App.new.call
