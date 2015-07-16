#!/usr/bin/env ruby
require 'json'

@fields = ["id", "name", "type", "faction", "race", "rarity", "cost", "attack", "durability", "health", "text", "flavor", "playerClass", "mechanics"]

def encode(hash)
    sets = hash.each{|h| h[0] }
    puts "Found #{sets.size} sets"
    cards = []
    sets.each {|s| cards.concat(s[1]) }
    puts "Found #{cards.size} cards"

    cards.map{ |c| @fields.map { |f| c[f] }.join("|")}
end

file = File.open(ARGV[0], 'r:UTF-8', &:read);
output = encode(JSON.parse(file.read))

#File.open(ARGV[1], 'w:UTF-8').write(output)
