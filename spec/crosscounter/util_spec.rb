require 'crosscounter/util'

describe Crosscounter::Util do
  describe '.stringify' do
    it 'unzips a hash into key-value strings' do
      expect(Crosscounter::Util.stringify(age: [18, 19, 20])).to eq([
        'age|18', 'age|19', 'age|20'
      ])
    end

    it 'unzips a key/value hash into key/value tuples' do
      expect(Crosscounter::Util.stringify(gender: 'male', name: 'Tom')).to eq([
        'gender|male',
        'name|Tom'
      ])
    end
  end
end
