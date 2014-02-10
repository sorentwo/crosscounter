require 'bundler'

Bundler.setup

require 'benchmark'
require 'crosscounter'
require 'json'

rows = JSON.load(IO.read('bench/rows.json'))
cols = JSON.load(IO.read('bench/cols.json'))
data = JSON.load(IO.read('bench/data.json'))

sub_cols = { 'answers' => cols['answers'].take(1), 'tags' => cols['tags'].take(2) }

if ENV['PROFILE']
  require 'ruby-prof'

  result = RubyProf.profile do
    Crosscounter::Compute.compute_all(data, rows, cols)
  end

  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT)
else
  Benchmark.bmbm do |x|
    x.report('compute_all') do
      Crosscounter::Compute.compute_all(data, rows, cols)
    end

    x.report('compute_sum') do
      Crosscounter::Compute.compute_all(data, rows, sub_cols)
    end
  end
end
