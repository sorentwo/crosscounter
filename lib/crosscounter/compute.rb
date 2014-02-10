require 'crosscounter/util'

module Crosscounter
  module Compute
    extend self

    def compute_all(enumerable, rows, cols)
      hashified = enumerable.map { |hash| Util.hashify(hash) }
      string_cols = Util.stringify(cols)
      string_rows = Util.stringify(rows)

      string_rows.map! do |row|
        initial = [row, compute(hashified, row)]

        string_cols.each do |col|
          initial << compute(hashified, row, col)
        end

        initial
      end
    end

    def compute_sum(enumerable, rows, cols)
      hashified = enumerable.map { |hash| Util.hashify(hash) }
      string_rows = Util.stringify(rows)
      string_cols = Util.stringify(cols)

      string_rows.map! do |row|
        computex(hashified, row, string_cols).unshift(row)
      end
    end

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

    def computex(hashes, base_prop, other_props)
      count = 0
      cross = 0
      index = 0
      length = hashes.length

      while index < length
        if hashes[index].member?(base_prop)
          count += 1
          cross += 1 if other_props.all? { |prop| hashes[index].member?(prop) }
        end

        index += 1
      end

      [count, cross]
    end
  end
end
