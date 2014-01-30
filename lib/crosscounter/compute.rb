require 'crosscounter/util'

module Crosscounter
  module Compute
    extend self

    def compute(enumerable, properties)
      enumerable.count do |object|
        properties.all? do |key, value|
          extracted = (object[key] || object[key.sub('_', '')])

          if extracted.kind_of?(Array)
            extracted.include?(value)
          else
            extracted == value
          end
        end
      end
    end

    def compute_all(enumerable, rows, columns)
      enumerable = Crosscounter::Util.stringify_all(enumerable)

      Crosscounter::Util.tuplize(rows).map do |tuple|
        initial = [tuple.last, compute(enumerable, tuple.first => tuple.last)]

        Crosscounter::Util.tuplize(columns).inject(initial) do |rows, column|
          rows << compute(enumerable,
                          tuple.first => tuple.last,
                          "_#{column.first}" => column.last)
        end
      end
    end
  end
end
