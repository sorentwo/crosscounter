require 'crosscounter/util'

describe Crosscounter::Util do
  describe '.tuplize' do
    it 'unzips the hash into key/value tuples' do
      Crosscounter::Util.tuplize(age: [18, 19, 20]).should == [['age', 18], ['age', 19], ['age', 20]]
    end
  end
end
