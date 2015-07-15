#!/usr/bin/env ruby
require 'json'

def encode(h)
    val = "|" + h.each {|k, v| v.to_s }.join("|") + "|"
    puts val
end

file = File.open(ARGV[0]);
#puts "input:" + file.read.encoding.to_s;
output = JSON.pretty_generate(JSON.parse(file.read));
#puts output.force_encoding('IBM866').encode('UTF-8');
#output.encode!('UTF-8');
#puts "output:" + file.read.encoding.to_s;
    
File.open(ARGV[1], 'w').write(output)
