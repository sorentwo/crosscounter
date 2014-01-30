require 'bundler'

Bundler.setup

require 'benchmark/ips'
require 'crosscounter'
require 'crosscounter/compute'
require 'json'

rows = JSON.load(IO.read('bench/rows.json'))
cols = JSON.load(IO.read('bench/cols.json'))
data = JSON.load(IO.read('bench/data.json'))

Benchmark.ips do |x|
  x.report('compute_all' ) { Crosscounter::Compute.compute_all(data, rows, cols) }
end
