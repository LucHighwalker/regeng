RSpec.describe Regeng do
  it 'has a version number' do
    expect(Regeng::VERSION).not_to be nil
  end

  context '#get_expression' do
    it 'should return any characters' do
      string = 'any characters'
      expect(Regeng.get_expression(string)).to eq '[A-Za-z]'
    end
    it 'should return any lowercase characters' do
      string = 'any lowercase characters'
      expect(Regeng.get_expression(string)).to eq '[a-z]'
    end
    it 'should return any uppercase characters' do
      string = 'any uppercase characters'
      expect(Regeng.get_expression(string)).to eq '[A-Z]'
    end
    it 'should return any characters with modifier' do
      string = 'any characters b-w'
      expect(Regeng.get_expression(string)).to eq '[b-w]'
    end
    it 'should return any characters except modifier' do
      string = 'any characters except b-w'
      expect(Regeng.get_expression(string)).to eq '[^b-w]'
    end

    it 'should return any digits with modifier' do
      string = 'any digits 215-420'
      expect(Regeng.get_expression(string)).to eq '[215-420]'
    end
    it 'should return any digits except modifier' do
      string = 'any digits except 215-420'
      expect(Regeng.get_expression(string)).to eq '[^215-420]'
    end
  end
end
