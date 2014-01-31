require 'crosscounter/util'

module Crosscounter
  module Compute
    extend self

    def compute(sets, prop_a, prop_b = nil)
      sets.count do |set|
        set.member?(prop_a) && (!prop_b || set.member?(prop_b))
      end
    end

    def compute_all(enumerable, rows, columns)
      setified = enumerable.map { |hash| Util.setify(hash) }
      scolumns = Util.stringify(columns)

      Util.stringify(rows).map do |row|
        initial = [row, compute(setified, row)]

        scolumns.inject(initial) do |rows, col|
          rows << compute(setified, row, col)
        end
      end
    end
  end
end
