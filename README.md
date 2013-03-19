[![Code Climate](https://codeclimate.com/github/sorentwo/crosscounter.png)](https://codeclimate.com/github/sorentwo/crosscounter)
[![Build Status](https://travis-ci.org/sorentwo/crosscounter.png?branch=master)](https://travis-ci.org/sorentwo/crosscounter)

# Crosscounter

A set of functional tools for generating cross tabulations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crosscounter', '~> 0.3.0'
```

## Usage

Crosscounter works entirely with standard data structures, i.e. arrays and
hashes. General usage is to provide an enumerable containing hashes of values,
followed by a rows hash and a columns hash.


```ruby
enumerable = [
  { age: 18, gender: 'male',   tags: %w[happy sad] },
  { age: 19, gender: 'female', tags: %w[happy mad] },
  { age: 18, gender: 'male',   tags: %w[mad sad] },
  { age: 19, gender: 'male',   tags: %w[sad] }
]

rows = {
  age: [18, 19],
  gender: %w[male female],
  tags: %w[happy sad mad]
}

cols = { tags: %w[happy sad mad] }

computer.compute_all(enumerable, rows, cols) #=> [
  [18,       2, 1, 2, 1],
  [19,       2, 1, 1, 1],
  ['male',   3, 1, 3, 1],
  ['female', 1, 1, 0, 1],
  ['happy',  2, 2, 1, 1],
  ['sad',    3, 1, 3, 1],
  ['mad',    2, 1, 1, 2]
]
```

The resulting output is an array of arrays mapping out every row value against
every column value. In the example above the columns are:

| key | all | tags['happy'] | tags['sad'] | tags['mad'] |
| --- | --- | ------------- | ----------- | ----------- |
| 18  | 2   | 1             | 2           | 1           |

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
