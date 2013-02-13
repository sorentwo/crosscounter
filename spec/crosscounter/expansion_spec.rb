require 'crosscounter/expansion'

describe Crosscounter::Expansion do
  subject(:expansion) { Crosscounter::Expansion }

  describe '.expand' do
    it 'replaces a set of keywords with statically defined values' do
      expanded = expansion.expand([:days], days: %w[sunday monday])

      expanded.should == { days: %w[sunday monday] }
    end

    it 'replaces a keyword with dynamically defined values' do
      expanded = expansion.expand([:ages], ages: -> { (18..21).map(&:to_s) })

      expanded.should == { ages: %w[18 19 20 21] }
    end
  end

  describe '.replace' do
    it 'replaces all objects with mapped values' do
      male_object   = mock(gender: 'male')
      female_object = mock(gender: 'female')

      replaced = expansion.replace([male_object, female_object],
                                   gender: -> object { object.gender.downcase })

      replaced.should == [{ gender: 'male' }, { gender: 'female' }]
    end
  end
end
