require 'bunny'
require 'sinatra'

module Emitter
  class Main

    def initialize
      create_connection
      create_channel
    end

    def send_msg(msg)
      @channel.default_exchange.publish(msg, routing_key: @queue.name)
    end

    private

    def create_connection
      @connection = Bunny.new(host: 'localhost')
      @connection.start
    end

    def create_channel
      @channel = @connection.create_channel
      @queue = @channel.queue('bunny-test')
    end

  end
end

emitter = Emitter::Main.new
gif = File.open('pixel.gif')

get '/pixel' do
  puts 'chegou aqui'
  emitter.send_msg(params.fetch(:link, request.referrer))
  send_file(gif)
end