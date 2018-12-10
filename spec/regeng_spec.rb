# frozen_string_literal: true

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
      string = 'any character b through w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters with modifier' do
      string = 'any character b-w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters with modifier' do
      string = 'any character between b and w'
      expect(Regeng.expression(string)).to eq(/[b-w]/)
    end
    it 'should return any characters except modifier' do
      string = 'any character except b through w'
      expect(Regeng.expression(string)).to eq(/[^b-w]/)
    end
    it 'should return any characters except specific modifier' do
      string = 'any character except b and w'
      expect(Regeng.expression(string)).to eq(/[^bw]/)
    end
  end

  context '#expression_digits' do
    it 'should return any digit' do
      string = 'any digit'
      expect(Regeng.expression(string)).to eq(/[0-9]+/)
    end
    it 'should return any digit between 5 and 9' do
      string = 'any digit between 5 and 9'
      expect(Regeng.expression(string)).to eq(/[0-9]+/)
    end
    it 'should return any digit between 5 and 9 with dash' do
      string = 'any digit 5-9'
      expect(Regeng.expression(string)).to eq(/[0-9]+/)
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
