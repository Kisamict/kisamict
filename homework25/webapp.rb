require "sinatra/main"
require_relative 'requireable'

class App < Sinatra::Base
  helpers do
    def create_station(params)
      Station.new(params['name'])
    end

    def create_train(params)
      case params['type']
      when 'CargoTrain'
        CargoTrain.new(params['number'])
      when 'PassengerTrain'
        PassengerTrain.new(params['number'])
      else
        Train.new(params['number'])
      end
    end

    def create_route(stations)
      first_station = Station.all.find { |station| station&.name == stations['first_station'] }
      last_station = Station.all.find { |station| station&.name == stations['last_station'] }

      Route.new(first_station, last_station)
    end

    def save_info(path, info)
      File.open(path, 'a+') do |f|
        f.puts "#{f.readlines.size + 1}. #{info}"
      end
    end

    def read_info(path)
      File.open(path) do |f|
        f.readlines
      end
    end
  end

  get '/' do
    erb :index
  end

  get '/trains' do
    @trains_info = read_info('data/trains.txt')
    erb :trains
  end

  get '/stations' do
    @stations_info = read_info('data/stations.txt')
    erb :stations
  end

  get '/routes' do
    @stations = Station.all
    @routes_info = read_info('data/routes.txt')
    erb :routes
  end

  get '/error' do
    erb :error
  end

  post '/stations' do
    station = create_station(params)

    if station.valid
      station_info = {class: station.class, name: station.name, created_at: Time.now}

      save_info('data/stations.txt', station_info)

      redirect '/stations'
    else
      redirect '/error'
    end
  end

  post '/trains' do
    train = create_train(params)

    if train.valid
      train_info = {class: train.class, name: train.number, created_at: Time.now}

      save_info('data/trains.txt', train_info)

      redirect '/trains'
    else
      redirect '/error'
    end
  end

  post '/routes' do
    route = create_route(params)

    if route.valid
      route_info = {class: route.class, name: route.name, created_at: Time.now}

      save_info('data/routes.txt', route_info)

      redirect '/routes'
    else
      redirect '/error'
    end
  end

  run! if app_file == $0
end
