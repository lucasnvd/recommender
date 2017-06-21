require_relative 'cluster'
module Receiver
  class Recommender

    def initialize
      load_clusters
    end

    def call(url)
      scores = @clusters.map do |cluster|
        cluster.match(url)
      end

      puts 'URL'
      puts url
      puts '--------------------------------------'

      puts 'Resultados'

      scores.each do |score|
        puts '--------------------------------------'
        puts 'Cluster: ' + score[:name]
        puts 'Matches: ' + score[:score].to_s
      end

    end

    private

    def load_clusters
      @clusters = Cluster.load
    end

  end
end