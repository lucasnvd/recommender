require 'bunny'
require_relative 'recommender'

module Receiver
  class Main

    def initialize
      create_connection
      create_channel
      create_recommender
    end

    # boostbox.com.br/api/v3/clusters.json

    def bind
      @queue.subscribe(block: true) do |delivery_info, properties, body|
        url = body.to_s
        @recommender.call(url)
        # puts 'Received: ' + body.to_s
        # delivery_info.consumer.cancel
      end
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

    def create_recommender
      @recommender = Recommender.new
    end

  end
end

receiver = Receiver::Main.new
receiver.bind
