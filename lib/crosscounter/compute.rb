module Crosscounter
  module Compute
    def self.compute(enumerable, properties)
      enumerable.count do |object|
        properties.all? do |key, value|
          object.fetch(key.to_s.sub('_', '').to_sym).to_s =~ regexify(value)
        end
      end
    end

    def self.compute_all(enumerable, rows, columns)
      tuplize(rows).map do |tuple|
        initial = [tuple.last, compute(enumerable, tuple.first => tuple.last)]

        tuplize(columns).inject(initial) do |rows, column|
          rows << compute(enumerable, tuple.first => tuple.last, :"_#{column.first}" => column.last)
        end
      end
    end

    def self.regexify(value)
      @values ||= {}

      @values[value] ||= /(\A|\t)#{value}(\Z|\t)/
    end

    def self.tuplize(hash)
      @tuples ||= {}

      @tuples[hash] ||= hash.flat_map do |tuple|
        tuple.last.map { |value| [tuple.first, value] }
      end
    end
  end
end
