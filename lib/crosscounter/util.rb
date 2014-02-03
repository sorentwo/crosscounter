require 'set'

module Crosscounter
  DEFAULT_SEPARATOR = '|'

  module Util
    extend self

    def separator=(sep)
      @@separator = sep
    end

    def separator
      @@separator ||= DEFAULT_SEPARATOR
    end

    def hashify(hash)
      stringify(hash).inject({}) do |memo, key|
        memo[key] = true
        memo
      end
    end

    def stringify(hash, sep = separator)
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
