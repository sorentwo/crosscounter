module Crosscounter
  module Util
    @@tuples  = {}
    @@regexes = {}

    def self.stringify_keys(hash)
      hash.keys.each do |key|
        hash[key.to_s] = hash.delete(key)
      end

      hash
    end

    def self.stringify_all(array)
      array.map { |object| Crosscounter::Util.stringify_keys(object) }
    end

    def self.prepared(array)
      array.map { |value| normalize(value) }.join("\t")
    end

    def self.regexify(value)
      @@regexes[value] ||= /(\A|\t)#{normalize(value)}(\Z|\t)/
    end

    def self.normalize(value)
      value.downcase.gsub(/[^a-z]/, '')
    end

    def self.tuplize(hash)
      @@tuples[hash] ||= hash.flat_map do |tuple|
        tuple.last.map { |value| [tuple.first.to_s, value] }
      end
    end
  end
end
