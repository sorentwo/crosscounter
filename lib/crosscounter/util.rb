require 'set'

module Crosscounter
  module Util
    extend self

    def hashify(hash)
      stringify(hash).inject({}) do |memo, key|
        memo[key] = 0
        memo
      end
    end

    def stringify(hash, sep = '|')
      hash.flat_map do |key, value|
        if value.kind_of?(Enumerable)
          value.map { |elem| "#{key}#{sep}#{elem}" }
        else
          ["#{key}#{sep}#{value}"]
        end
      end
    end
  end
end
