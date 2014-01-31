require 'set'

module Crosscounter
  module Util
    extend self

    def setify(hash)
      Set.new(stringify(hash))
    end

    def stringify(hash)
      hash.flat_map do |key, value|
        if value.kind_of?(Enumerable)
          value.map { |elem| "#{key}-#{elem}" }
        else
          ["#{key}-#{value}"]
        end
      end
    end
  end
end
