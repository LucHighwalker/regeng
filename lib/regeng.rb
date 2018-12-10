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
    if string =~ /(at start of ){1}/
      if string =~ /( line){1}/
        result = '^'
      elsif string =~ /( string){1}/
        result = '\A'
      end
    elsif string =~ /(at end of ){1}/
      if string =~ /( line){1}/
        result = '$'
      elsif string =~ /( string){1}/
        result = '\z'
      end
    end
    result
  end

  def self.process_any(string)
    result = ''
    if string =~ /( character){1}/
      if string =~ /( [a-z]-[a-z])/i
        character_mod = string.match(/( [a-z]-[a-z])/i)
        character_mod = "^#{character_mod}" if string =~ /( except ){1}/
        result = "[#{character_mod}]"
      elsif string =~ /( uppercase ){1}/
        result = '[A-Z]'
      elsif string =~ /( lowercase ){1}/
        result = '[a-z]'
      else
        result = '[A-Za-z]'
      end
    elsif string =~ /( digit){1}/
      if string =~ /( [0-9]+-[0-9]+){1}/
        digit_mod = string.match(/( [0-9]+-[0-9]+){1}/)
        digit_mod = "^#{digit_mod}" if string =~ /(except){1}/
        result = "[#{digit_mod}]"
      else
        result = '[0-9]+'
      end
    end
    result
  end
end
