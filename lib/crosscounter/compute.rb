require 'crosscounter/util'
require 'set'

module Crosscounter
  module Compute
    extend self

    def compute(enumerable, properties)
      enumerable.count do |set|
        properties.all? { |prop| set.member?(prop) }
      end
    end

    def compute_all(enumerable, rows, columns)
      setified = enumerable.map { |hash| Util.setify(hash) }

      Util.stringify(rows).map do |row|
        initial = [row, compute(setified, [row])]

        Util.stringify(columns).inject(initial) do |rows, col|
          rows << compute(setified, [row, col])
        end
      end
    end
  end
end
