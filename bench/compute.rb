require 'bundler'

Bundler.setup

require 'benchmark'
require 'crosscounter'
require 'json'

rows = JSON.load(IO.read('bench/rows.json'))
cols = JSON.load(IO.read('bench/cols.json'))
data = JSON.load(IO.read('bench/data.json'))

if ENV['PROFILE']
  require 'ruby-prof'

  result = RubyProf.profile do
    Crosscounter::Compute.compute_all(data, rows, cols)
  end

  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT)
else
  Benchmark.bmbm do |x|
    x.report('compute_all' ) do
      Crosscounter::Compute.compute_all(data, rows, cols)
    end
  end
end
