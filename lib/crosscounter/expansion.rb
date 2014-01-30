module Crosscounter
  module Expansion
    extend self

    def expand(keywords, expansions)
      keywords.inject({}) do |hash, keyword|
        hash[keyword] = resolved(expansions, keyword)
        hash
      end
    end

    def replace(enumerable, replacements)
      enumerable.map do |object|
        replacements.inject({}) do |hash, replacement|
          hash[replacement.first] = replacement.last.call(object)

          hash
        end
      end
    end

    def resolved(expansions, keyword)
      value = expansions.fetch(keyword)

      value.respond_to?(:call) ? value.call : value
    end
  end
end
