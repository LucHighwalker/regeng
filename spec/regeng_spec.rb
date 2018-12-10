RSpec.describe Regeng do
  it 'has a version number' do
    expect(Regeng::VERSION).not_to be nil
  end

  context '#expression_characters' do
    it 'should return any characters' do
      string = 'any character'
      expect(Regeng.expression(string)).to eq(/[A-Za-z]/)
    end
    it 'should return any lowercase characters' do
      string = 'any lowercase character'
      expect(Regeng.expression(string)).to eq(/[a-z]/)
    end
    it 'should return any uppercase characters' do
      string = 'any uppercase character'
      expect(Regeng.expression(string)).to eq(/[A-Z]/)
    end
    it 'should return any characters with modifier' do
      string = 'any character b-w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters except modifier' do
      string = 'any character except b-w'
      expect(Regeng.expression(string)).to eq(/[^b-w]/)
    end
  end

  context '#expression_digits' do
    it 'should return any digit' do 
      string = 'any digit'
      expect(Regeng.expression(string)).to eq(/[0-9]+/)
    end
    # TODO: Fix these
    # it 'should return any digits with modifier' do
    #   string = 'any digit 215-420'
    #   expect(Regeng.expression(string)).to eq(/[215-420]/)
    # end
    # it 'should return any digits except modifier' do
    #   string = 'any digit except 215-420'
    #   expect(Regeng.expression(string)).to eq(/[^215-420]/)
    # end
  end

  context '#expression_at' do
    it 'should return any digit at start of line' do
      string = 'any digit at start of line'
      expect(Regeng.expression(string)).to eq(/^[0-9]+/)
    end
    it 'should return any digit at end of line' do
      string = 'any digit at end of line'
      expect(Regeng.expression(string)).to eq(/$[0-9]+/)
    end

    it 'should return any digit at start of string' do
      string = 'any digit at start of string'
      expect(Regeng.expression(string)).to eq(/\A[0-9]+/)
    end
    it 'should return any digit at end of string' do
      string = 'any digit at end of string'
      expect(Regeng.expression(string)).to eq(/\z[0-9]+/)
    end
  end
end
