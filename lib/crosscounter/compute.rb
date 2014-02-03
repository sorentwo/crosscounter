require 'crosscounter/util'

module Crosscounter
  module Compute
    extend self

    def compute(hashes, prop_a, prop_b = nil)
      count = 0
      index = 0
      length = hashes.length

      while index < length
        if hashes[index].member?(prop_a) && (!prop_b || hashes[index].member?(prop_b))
          count += 1
        end

        index += 1
      end

      count
    end

    def compute_all(enumerable, rows, columns)
      setified = enumerable.map { |hash| Util.hashify(hash) }
      scolumns = Util.stringify(columns)

      Util.stringify(rows).map! do |row|
        initial = [row, compute(setified, row)]

        scolumns.each do |col|
          initial << compute(setified, row, col)
        end

        initial
      end
    end
  end
end
