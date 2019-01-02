# frozen_string_literal: true

RSpec.describe Regeng do
  it 'has a version number' do
    expect(Regeng::VERSION).not_to be nil
  end

  context '#expression_characters' do
    it 'should return any character' do
      string = 'any character'
      expect(Regeng.expression(string)).to eq(/[a-zA-Z]/)
    end
    it 'should return any characters' do
      string = 'any characters'
      expect(Regeng.expression(string)).to eq(/[a-zA-Z]+/)
    end

    it 'should return any lowercase character' do
      string = 'any lowercase character'
      expect(Regeng.expression(string)).to eq(/[a-z]/)
    end
    it 'should return any lowercase characters' do
      string = 'any lowercase characters'
      expect(Regeng.expression(string)).to eq(/[a-z]+/)
    end
    it 'should return any uppercase character' do
      string = 'any uppercase character'
      expect(Regeng.expression(string)).to eq(/[A-Z]/)
    end
    it 'should return any uppercase characters' do
      string = 'any uppercase characters'
      expect(Regeng.expression(string)).to eq(/[A-Z]+/)
    end

    it 'should return any characters with through modifier' do
      string = 'any character b through w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters with through modifier' do
      string = 'any characters b through w'
      expect(Regeng.expression(string)).to eq(/[b-w]+/)
    end
    it 'should return any character except through modifier' do
      string = 'any character except b through w'
      expect(Regeng.expression(string)).to eq(/[^b-w]/)
    end
    it 'should return any characters except through modifier' do
      string = 'any characters except b through w'
      expect(Regeng.expression(string)).to eq(/[^b-w]+/)
    end

    it 'should return any characters with dash modifier' do
      string = 'any character b-w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters except dash modifier' do
      string = 'any character except b-w'
      expect(Regeng.expression(string)).to eq(/[^b-w]/)
    end
    it 'should return characters with specific modifier' do
      string = 'character b and w'
      expect(Regeng.expression(string)).to eq(/[bw]/)
    end
    it 'should return characters with specific modifier' do
      string = 'characters b and w'
      expect(Regeng.expression(string)).to eq(/[bw]+/)
    end
    it 'should return many characters with specific modifier' do
      string = 'character a b c d e and w'
      expect(Regeng.expression(string)).to eq(/[abcdew]/)
    end
    it 'should return many characters with specific modifier' do
      string = 'characters a b c d e and w'
      expect(Regeng.expression(string)).to eq(/[abcdew]+/)
    end
    it 'should return any characters except specific modifier' do
      string = 'any character except b and w'
      expect(Regeng.expression(string)).to eq(/[^bw]/)
    end
    it 'should return any characters except many specific modifier' do
      string = 'any character except a b c d e and w'
      expect(Regeng.expression(string)).to eq(/[^abcdew]/)
    end
  end

  context '#expression_digits' do
    it 'should return any digit' do
      string = 'any digit'
      expect(Regeng.expression(string)).to eq(/[0-9]/)
    end
    it 'should return any digits' do
      string = 'any digits'
      expect(Regeng.expression(string)).to eq(/[0-9]+/)
    end
    it 'should return any digit 5 through 9' do
      string = 'digit 5 through 9'
      expect(Regeng.expression(string)).to eq(/[5-9]/)
    end
    it 'should return any digits 5 through 9' do
      string = 'digits 5 through 9'
      expect(Regeng.expression(string)).to eq(/[5-9]+/)
    end
    it 'should return any digit 5 to 9' do
      string = 'digit 5 to 9'
      expect(Regeng.expression(string)).to eq(/[5-9]/)
    end
    it 'should return any digits 5 to 9' do
      string = 'digits 5 to 9'
      expect(Regeng.expression(string)).to eq(/[5-9]+/)
    end
    it 'should return any digit between 5 and 9' do
      string = 'digit between 5 and 9'
      expect(Regeng.expression(string)).to eq(/[5-9]/)
    end
    it 'should return any digits between 5 and 9' do
      string = 'digits between 5 and 9'
      expect(Regeng.expression(string)).to eq(/[5-9]+/)
    end
    it 'should return any digit between 5 and 9 with dash' do
      string = 'any digit 5-9'
      expect(Regeng.expression(string)).to eq(/[5-9]/)
    end
    it 'should return any digit between 20 and 60' do
      string = 'any digit between 20 and 60'
      expect(Regeng.expression(string)).to eq(/(2[0-9])|(3[0-9])|(4[0-9])|(5[0-9])|(60)/)
    end
    it 'should return any digit between 400 and 600' do
      string = 'any digit between 400 and 600'
      expect(Regeng.expression(string)).to eq(/(4[0-9][0-9])|(5[0-9][0-9])|(600)/)
    end
    it 'should return any digit between 7000 and 9000' do
      string = 'any digit between 7000 and 9000'
      expect(Regeng.expression(string)).to eq(/(7[0-9][0-9][0-9])|(8[0-9][0-9][0-9])|(9000)/)
    end
    it 'should return any digit between 80 and 300' do
      string = 'any digit between 80 and 300'
      expect(Regeng.expression(string)).to eq(/(8[0-9])|(9[0-9])|(1[0-9][0-9])|(2[0-9][0-9])|(300)/)
    end
  end

  context '#expression_at' do
    it 'should return any digit at start of line' do
      string = 'any digit at start of line'
      expect(Regeng.expression(string)).to eq(/^[0-9]/)
    end
    it 'should return any digit at end of line' do
      string = 'any digit at end of line'
      expect(Regeng.expression(string)).to eq(/$[0-9]/)
    end

    it 'should return any digit at start of string' do
      string = 'any digit at start of string'
      expect(Regeng.expression(string)).to eq(/\A[0-9]/)
    end
    it 'should return any digit at end of string' do
      string = 'any digit at end of string'
      expect(Regeng.expression(string)).to eq(/\z[0-9]/)
    end
  end
end
