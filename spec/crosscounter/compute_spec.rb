require 'crosscounter/compute'

describe Crosscounter::Compute do
  subject(:computer) { Crosscounter::Compute }

  describe '.compute' do
    it 'counts the number of cross occurring values between all properties' do
      enumerable = [
        Set.new(['age-18', 'gender-male']),
        Set.new(['age-19', 'gender-female']),
        Set.new(['age-18', 'gender-male'])
      ]

      computer.compute(enumerable, 'age-18').should == 2
      computer.compute(enumerable, 'age-18', 'gender-male').should   == 2
      computer.compute(enumerable, 'age-19', 'gender-male').should   == 0
      computer.compute(enumerable, 'age-19', 'gender-female').should == 1
    end
  end

  describe '.compute_all' do
    it 'generates a list of all x properties against all y properties' do
      enumerable = [
        { age: 18, gender: 'male',   tags: %w[happy sad] },
        { age: 19, gender: 'female', tags: %w[happy mad] },
        { age: 18, gender: 'male',   tags: %w[mad sad] },
        { age: 19, gender: 'male',   tags: %w[sad] }
      ]

      computed = computer.compute_all(enumerable,
        { age: [18, 19], gender: %w[male female], tags: %w[happy sad mad] },
        { tags: %w[happy sad mad] }
      )

      computed.should == [
        ['age|18',         2, 1, 2, 1],
        ['age|19',         2, 1, 1, 1],
        ['gender|male',    3, 1, 3, 1],
        ['gender|female',  1, 1, 0, 1],
        ['tags|happy',     2, 2, 1, 1],
        ['tags|sad',       3, 1, 3, 1],
        ['tags|mad',       2, 1, 1, 2]
      ]
    end
  end
end
