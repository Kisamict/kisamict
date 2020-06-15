require_relative "requireable"

class App
  attr_accessor :break_loop
  attr_reader :stations, :trains, :wagons, :routes

  def initialize
    @stations = []
    @trains = []
    @wagons = []
    @routes = []
    @break_loop = false

    call
  end

  private

  def call
    puts "Приложение запущено!"
    until break_loop
      interface
      options
    end
  end

  def interface
    puts "...Главное меню..."
    my_puts [
      "1. Управление станциями",
      "2. Управление поездами",
      "3. Управление маршрутами",
      "4. Управление вагонами",
      "0. Выйти из программы"
    ]
  end

  def my_puts(array)
    array.each{ |element| puts element; sleep 0.1}
  end

  def options
    case accept_input
    when "1"
      station_interface
      station_options
    when "2"
      train_interface
      train_options
    when "3"
      route_interface
      route_options
    when "4"
      wagon_interface
      wagon_options
    when "0"
      self.break_loop = true
    else
      invalid_input
    end
  end

  def numered_list(array)
    return puts "Список пуст!" if array.empty?
    array.each_with_index { |element, index| puts "##{index+1}: #{element}" }
  end

  def accept_input
    gets.chomp.strip
  end

  def choose_type
    types = ["Пассажирский", "Грузовой"]
    puts "Выберите тип:"
    numered_list(types)
    accept_input
  end

  def invalid_input
    puts "ОШИБКА: Неправильный ввод!"
  end

  def station_interface
    puts "...Управление станциями"
    my_puts [
      "1. Создать станцию",
      "2. Список станций",
      "3. Список поездов на станции",
      "0. Назад"
    ]
  end

  def station_options
    case accept_input
    when "1"
      create_station
    when "2"
      numered_list(stations.map(&:name))
    when "3"
      return if stations_empty?
      return if trains_empty?
      trains_on_station
    when "0"
      return
    else
      invalid_input
    end
  end

  def stations_empty?
    stations.empty? ? (puts "ОШИБКА: Станций нет!" ; true) : false
   end

  def choose_station
    puts "Выберите станцию:"
    numered_list(stations.map(&:name))
    stations.my_find(accept_input)
  end

  def trains_on_station
    numered_list(choose_station.trains)
  end

  def create_station
    puts "Введите название станции"
    stations <<  Station.new(accept_input)
    puts "Новая станция успешно создана!"
  end

  def enough_stations?
    stations.length >= 2
  end

  def train_interface
    puts "...Управление поездами..."
    my_puts [
      "1. Создать поезд",
      "2. Показать список всех поездов",
      "3. Назначить маршрут",
      "4. Отправить на следующую станцию",
      "5. Отправить на предыдущую станцию",
      "0. Назад"
    ]
  end

  def train_options
    case accept_input
    when "0"
      return
    when "1"
      create_train
    when "2"
      numered_list(trains)
    when "3"
      return if routes_empty?
      return if trains_empty?
      assign_route
    when "4"
      return if trains_empty?
      move_forward
    when "5"
      return if trains_empty?
      move_backward
    else
      invalid_input
    end
  end

  def choose_train
    puts "Выберите поезд"
    numered_list(trains)
    trains.my_find(accept_input)
  end

  def move_forward
    train = choose_train
    return puts "ОШИБКА: Маршрут не назначен!" if train.route.nil?
    train.move_forward ? (puts "Поезд отправился на станцию #{train.current_station.name}") : (puts "ОШИБКА: Это конечная станция!")
  end

  def move_backward
    train = choose_train
    return puts "ОШИБКА: Маршрут не назначен!" if train.route.nil?
    train.move_backward ? (puts "Поезд вернулся на станцию #{train.current_station.name}") : (puts "ОШИБКА: Это начальная станция!")
  end

  def assign_route
    choose_train.route = choose_route
  end


  def create_train
    case choose_type
    when "1"
      puts "Введите номер поезда:"
      trains << PassengerTrain.new(accept_input)
      puts "Пассажирский поезд успешно создан!"
    when "2"
      puts "Введите номер поезда:"
      trains << CargoTrain.new(accept_input)
      puts "Грузовой поезд успешно создан!"
    else
      invalid_input
    end
  end

  def trains_empty?
    trains.empty? ? (puts "ОШИБКА: Поездов нет!" ; true) : false
  end

  def route_interface
    puts "...Управление маршрутами..."
    my_puts [
     "1. Создать маршрут",
     "2. Добавить станцию в маршрут",
     "3. Удалить станцию из маршрута",
     "0. Назад"
    ]
  end

  def route_options
    case accept_input
    when "0"
      return
    when "1"
      return puts "ОШИБКА: Вам нужно как минимум две станции чтобы создать маршрут!" unless enough_stations?

      numered_list(stations.map(&:name))
      create_route
    when "2"
      return if routes_empty?
      add_station
    when "3"
      return if routes_empty?
      remove_station
    else
      invalid_input
    end
  end

  def routes_empty?
    routes.empty? ? (puts "ОШИБКА: Нет маршрутов!" ; true) : false
  end

  def choose_route
    puts "Выберите маршрут:"
    numered_list(routes)
    routes.my_find(accept_input)
  end

  def create_route
    puts "Выберите начальную станцию:"
    from = stations.my_find(accept_input)

    puts "Выберите конечную станцию:"
    to = stations.my_find(accept_input)

    return puts "ОШИБКА: Маршрут не может состоять из одной станции!" if from == to

    @routes << Route.new(from, to)

    puts "Маршрут #{from.name}-#{to.name} успешно создан!"
  end

  def remove_station
    choose_route.remove(choose_station) ? (puts "Станция успешно удалена из маршрута!") : (puts "ОШИБКА: Нельзя удалить начальную или конечную станцию!")
  end

  def add_station
    choose_route.add(choose_station) ? (puts "Станция успешно добавлена в маршрут!") : (puts "ОШИБКА: Эта станция уже присутствует в маршруте!")
  end

  def wagon_interface
    puts "...Управление вагонами..."
    my_puts [
      "1. Создать вагон",
      "2. Прицепить вагон к поезду",
      "3. Отцепить вагон от поезда",
      "0. Назад"
    ]
  end

  def wagon_options
    case accept_input
    when "1"
      create_wagon
    when "2"
      return if trains_empty?
      return if wagons_empty?
      hook_wagon
    when "3"
      return if trains_empty?
      return if wagons_empty?
      unhook_wagon
    when "0"
      return
    else
      invalid_input
    end
  end

  def wagons_empty?
    wagons.empty? ? (puts "ОШИБКА: Вагонов нет!" ; true) : false
  end

  def choose_wagon
    puts "Выберите вагон:"
    numered_list(wagons)
    wagons.my_find(accept_input)
  end

  def hook_wagon
    train = choose_train
    wagon = choose_wagon

    return puts "ОШИБКА: Этот вагон уже присоединён к данному поезду!" if train.wagons.include?(wagon)

    train.hook(wagon) ? (puts "Вагон успешно прицеплен!") : (puts "ОШИБКА: Вагон не подходит к данному поезду!")
  end

  def unhook_wagon
    choose_train.unhook(choose_wagon) ? (puts "Вагон успешно отцеплен!") : (puts "Данный вагон не прицеплен к поезду!")
  end

  def create_wagon
    case choose_type
    when "1"
      puts "Введите количество мест в вагоне"
      @wagons << PassengerWagon.new(accept_input.to_i)
      puts "Пассажирский вагон успешно создан!"
    when "2"
      puts "Введите объем вагона"
      @wagons << CargoWagon.new(accept_input.to_i)
      puts "Грузовой вагон успешно создан!"
    else
      invalid_input
    end
  end
end

App.new
