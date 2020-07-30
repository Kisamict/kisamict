require 'net/http'

class Request
  attr_reader :uri, :response

  def get(url, headers = {})
    http = init_http(url)

    request = Net::HTTP::Get.new(uri)
    headers.each { |key, value| request[key] = value }

    @response = http.request(request)
  end

  def resp_status
    response&.code
  end

  def resp_body
    response&.body
  end

  def resp_headers
    response&.each_header {}
  end

  private

  def init_http(url)
    @uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.instance_of?(URI::HTTPS)

    http
  end
end
