module Crosscounter
  module Util
    extend self

    @@tuples = {}

    def stringify_keys(hash)
      hash.keys.each do |key|
        hash[key.to_s] = hash.delete(key)
      end

      hash
    end

    def stringify_all(array)
      array.map { |object| Crosscounter::Util.stringify_keys(object) }
    end

    def tuplize(hash)
      @@tuples[hash] ||= hash.flat_map do |tuple|
        tuple.last.map { |value| [tuple.first.to_s, value] }
      end
    end
  end
end
