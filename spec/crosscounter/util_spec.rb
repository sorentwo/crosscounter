require 'crosscounter/util'

describe Crosscounter::Util do
  describe '.regexify' do
    it 'generates a regular expression that matches complete tab delimited words' do
      regex = Crosscounter::Util.regexify('word')

      ["word", "\tword", "word\t"].each do |word|
        word.should match(regex)
      end
    end

    it 'generates a regular expression that does not match incomplete words' do
      regex = Crosscounter::Util.regexify('word')

      ["great word", "inside,word,list"].each do |word|
        word.should_not match(regex)
      end
    end
  end

  describe '.tuplize' do
    it 'unzips the hash into key/value tuples' do
      Crosscounter::Util.tuplize(age: [18, 19, 20]).should == [['age', 18], ['age', 19], ['age', 20]]
    end
  end
end
