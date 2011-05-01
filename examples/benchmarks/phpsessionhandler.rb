require 'rubygems'
require 'php_serialize'
require 'benchmark'
thing = {} ;
serialized_thing = ""
200.times do |i|
  thing.merge! :"#{i}" => i
end

Benchmark.bm(5) do |bm|
  bm.report('marshall dump') {serialized_thing = [Marshal.dump(thing)].pack("m*") }
  bm.report('marshal load') { Marshal.load(serialized_thing.unpack("m*").first) }
  bm.report('php dump'){serialized_thing = PHP::serialize(thing)}
  bm.report('php load'){PHP::unserialize(serialized_thing)}
end
