require 'net/http'
require 'json'

module ApplicationHelper
  def make_api_request(method, auth, route, body = {})
    api_url = 'http://localhost:3000'
    api_token = cookies[:auth_token]

    uri = URI("#{api_url}/#{route}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme == 'https'

    request = case method
              when :get
                Net::HTTP::Get.new(uri.request_uri)
              when :post
                Net::HTTP::Post.new(uri.request_uri)
              when :put
                Net::HTTP::Put.new(uri.request_uri)
              when :delete
                Net::HTTP::Delete.new(uri.request_uri)
              else
                raise ArgumentError, "Invalid method: #{method}"
              end

    if auth
      request['Authorization'] = api_token
    end
    request['Content-Type'] = 'application/json'
    request.body = body.to_json

    response = http.request(request)

    return response
  rescue StandardError => e
    handle_api_error(e.message)
  end

  private

  def handle_api_error(error_message)
    puts error_message
  end
end
