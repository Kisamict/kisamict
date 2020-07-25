module Logger
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def read_log
      File.open("logs/#{self}.log", 'r') do |f|
        f.each_line { |line| puts line }
      end
    end
  end

  module InstanceMethods
    def write_log(data)
      File.open("logs/#{self.class}.log", 'a+') do |f|
        f.puts "#{f.readlines.size + 1}. #{data}"
      end
    end

    def write_error(error, where_from)
      File.open('logs/Errors.log', 'a') do |f|
        f.puts "#{Time.now} | #{where_from} | #{error.message}"
      end
    end
  end
end
