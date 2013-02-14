require 'crosscounter/util'

module Crosscounter
  module Compute
    @@values = {}
    @@tuples = {}

    def self.compute(enumerable, properties)
      enumerable.count do |object|
        properties.all? do |key, value|
          extracted = (object[key] || object[key.sub('_', '')])

          if extracted.kind_of?(Array)
            extracted.join("\t") =~ regexify(value)
          else
            extracted == value
          end
        end
      end
    end

    def self.compute_all(enumerable, rows, columns)
      enumerable.map! { |object| Crosscounter::Util.stringify_keys(object) }

      tuplize(rows).map do |tuple|
        initial = [tuple.last, compute(enumerable, tuple.first => tuple.last)]

        tuplize(columns).inject(initial) do |rows, column|
          rows << compute(enumerable,
                          tuple.first => tuple.last,
                          "_#{column.first}" => column.last)
        end
      end
    end

    def self.regexify(value)
      @@values[value] ||= /(\A|\t)#{value}(\Z|\t)/
    end

    def self.tuplize(hash)
      @@tuples[hash] ||= hash.flat_map do |tuple|
        tuple.last.map { |value| [tuple.first.to_s, value] }
      end
    end
  end
end
