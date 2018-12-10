# frozen_string_literal: true

require 'regeng/version'

# A gem which creates regular expressions using plain english.
module Regeng
  class Error < StandardError; end

  def self.expression(string)
    start = ''
    middle = ''
    ending = ''

    start = process_at(string) if string =~ /( at ){1}/
    middle = process_any(string) if string =~ /(any ){1}/

    expression = "#{start}#{middle}#{ending}"
    Regexp.new expression
  end

  def self.process_at(string)
    result = ''
    if /(at start of ){1}/.match?(string)
      if /( line){1}/.match?(string)
        result = '^'
      elsif /( string){1}/.match?(string)
        result = '\A'
      end
    elsif /(at end of ){1}/.match?(string)
      if /( line){1}/.match?(string)
        result = '$'
      elsif /( string){1}/.match?(string)
        result = '\z'
      end
    end
    result
  end

  def self.process_any(string)
    result = ''
    if /( character){1}/.match?(string)
      if /( [a-z]-[a-z])/i.match?(string)
        character_mod = string.match(/([a-z]-[a-z])/i)
        character_mod = "^#{character_mod}" if string =~ /( except ){1}/
        result = "[#{character_mod}]"
      elsif /( uppercase ){1}/.match?(string)
        result = '[A-Z]'
      elsif /( lowercase ){1}/.match?(string)
        result = '[a-z]'
      else
        result = '[A-Za-z]'
      end
    elsif /( digit){1}/.match?(string)
      if /( [0-9]+-[0-9]+){1}/.match?(string)
        digit_mod = string.match(/([0-9]+-[0-9]+){1}/)
        digit_mod = "^#{digit_mod}" if string =~ /( except ){1}/
        result = "[#{digit_mod}]"
      else
        result = '[0-9]+'
      end
    end
    result
  end
end
