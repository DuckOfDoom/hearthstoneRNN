# encoding: UTF-8
require 'json'

if ARGV.size < 3
    puts "Usage: \"encode_decode.rb -[e,d] input_file output file\"" 
    exit
end

@encoded_fields = ["id", "name", "type", "text", "attack", "health", "cost", "durability", "playerClass", "mechanics", "race",  "rarity", "faction",  "flavor"]

# We can convert to json if it has at least ID, Name, Type and Text
@decode_regexp = /.+\|.+\|.+\|.+\|/

def encode(input)
    sets = input.each { |h| h[0] }
    puts "Found #{sets.size} sets"
    cards = []
    sets.each {|s| cards.concat(s[1]) }
    puts "Found #{cards.size} cards"

    encoded = cards.map{ |c| @encoded_fields.map { |f| c[f] }.join("|").gsub("\n", "") }
    shuffled = encoded.concat(encoded).concat(encoded).concat(encoded).shuffle

    shuffled.join("\n\n\n")
end

# Decoding is lossy(can't decode all the stuff) because we can't ensure RNN will output valid strings
def decode(input)
    input.lines.select { |c| @decode_regexp.match(c) }.map do |card| 
        card_fields = card.split ("|")
        hash = {}
        @encoded_fields.each_with_index do |f, i|
            hash[f] = card_fields[i] unless !card_fields[i]
        end
        hash
    end
end

# Fixing invalid characters encoding because RNN can output some non-UTF-8 characters
contents = File.open(ARGV[1], 'r:UTF-8').read.chars.select(&:valid_encoding?).join

case ARGV[0]
when '-e'
    output = encode JSON.parse contents
when '-d'
    output = JSON.pretty_generate decode contents
else
    puts "Something went wrong"
end

File.open(ARGV[2], 'w').write(output)
