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

      expect(computer.compute(enumerable, 'age-18')).to eq(2)
      expect(computer.compute(enumerable, 'age-18', 'gender-male')).to eq(2)
      expect(computer.compute(enumerable, 'age-19', 'gender-male')).to eq(0)
      expect(computer.compute(enumerable, 'age-19', 'gender-female')).to eq(1)
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

      expect(computed).to eq([
        ['age|18',         2, 1, 2, 1],
        ['age|19',         2, 1, 1, 1],
        ['gender|male',    3, 1, 3, 1],
        ['gender|female',  1, 1, 0, 1],
        ['tags|happy',     2, 2, 1, 1],
        ['tags|sad',       3, 1, 3, 1],
        ['tags|mad',       2, 1, 1, 2]
      ])
    end
  end

  describe '.compute_sum' do
    it 'tabulates all rows against all columns combined' do
      enumerable = [
        { age: 18, gender: 'male',   tags: %w[happy sad] },
        { age: 19, gender: 'female', tags: %w[happy mad] },
        { age: 18, gender: 'male',   tags: %w[mad sad] },
        { age: 19, gender: 'male',   tags: %w[happy sad] }
      ]

      computed = computer.compute_sum(enumerable,
        { age: [18, 19], gender: %w[male female], tags: %w[happy sad mad] },
        { tags: %w[happy sad] }
      )

      expect(computed).to eq([
        ['age|18',         2, 1],
        ['age|19',         2, 1],
        ['gender|male',    3, 2],
        ['gender|female',  1, 0],
        ['tags|happy',     3, 2],
        ['tags|sad',       3, 2],
        ['tags|mad',       2, 0]
      ])
    end
  end
end
