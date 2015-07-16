#!/usr/bin/env ruby
require 'json'

@fields = ["id", "name", "type", "text", "attack", "health", "cost", "durability", "playerClass", "mechanics", "race",  "rarity", "faction",  "flavor"]

def encode(hash)
    sets = hash.each{|h| h[0] }
    puts "Found #{sets.size} sets"
    cards = []
    sets.each {|s| cards.concat(s[1]) }
    puts "Found #{cards.size} cards"

    encoded = cards.map{ |c| @fields.map { |f| c[f] }.join("|").gsub("\n", "") }
    shuffled = encoded.concat(encoded).concat(encoded).concat(encoded).shuffle

    shuffled.join("\n\n\n")
end

file = File.open(ARGV[0], 'r:UTF-8')
output = encode(JSON.parse(file.read))
File.open(ARGV[1], 'w:UTF-8').write(output)
