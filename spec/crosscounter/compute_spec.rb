require 'crosscounter/compute'

describe Crosscounter::Compute do
  subject(:computer) { Crosscounter::Compute }

  describe '.compute' do
    it 'counts the number of cross occurring values between all properties' do
      enumerable = [
        { 'age' => 18, 'gender' => 'male' },
        { 'age' => 19, 'gender' => 'female' },
        { 'age' => 18, 'gender' => 'male' }
      ]

      computer.compute(enumerable, 'age' => 18).should == 2
      computer.compute(enumerable, 'age' => 18, 'gender' => 'male').should   == 2
      computer.compute(enumerable, 'age' => 19, 'gender' => 'male').should   == 0
      computer.compute(enumerable, 'age' => 19, 'gender' => 'female').should == 1
    end

    it 'matches against regular expressions' do
      enumerable = [
        { 'age' => 18, 'tags' => %w[happy sad] },
        { 'age' => 19, 'tags' => %w[happy mad] },
        { 'age' => 18, 'tags' => %w[mad sad] },
        { 'age' => 18, 'tags' => %w[sad] }
      ]

      computer.compute(enumerable, 'age' => 18, 'tags' => 'sad').should   == 3
      computer.compute(enumerable, 'age' => 18, 'tags' => 'happy').should == 1
    end

    it 'compensates for duplicate keys by normalizing leading underscores' do
      enumerable = [
        { 'age' => '18', 'tags' => %w[happy sad] },
        { 'age' => '19', 'tags' => %w[happy mad] },
        { 'age' => '18', 'tags' => %w[mad sad] },
        { 'age' => '18', 'tags' => %w[sad] }
      ]

      computer.compute(enumerable, 'tags' => 'sad', '_tags' => 'happy').should == 1
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
        [18,       2, 1, 2, 1],
        [19,       2, 1, 1, 1],
        ['male',   3, 1, 3, 1],
        ['female', 1, 1, 0, 1],
        ['happy',  2, 2, 1, 1],
        ['sad',    3, 1, 3, 1],
        ['mad',    2, 1, 1, 2]
      ]
    end
  end
end
