# frozen_string_literal: true

require 'regeng/version'

# A gem which creates regular expressions using plain english.
module Regeng
  class Error < StandardError; end

  CHARACTER_COND = /((any )?(character)(s)?( except)?( between)?( [a-zA-Z])+((-)|( through )|( to )|( and )){1}[a-zA-Z]){1}/.freeze
  CHARACTER_SIMP = /((any )?((uppercase )?|(lowercase )?)(character)(s)?){1}/.freeze

  DIGIT_COND = /((any )?((digit)|(number))(s)?( except)?( between)?( [0-9])+((-)|( through )|( to )|( and )){1}[0-9]){1}/.freeze
  DIGIT_SIMPLE = /(any ((digit)|(number))){1}/.freeze

  AT_COND = /( at )((start)|(end))( of )((line)|(string))/.freeze

  def self.expression(string)
    expression = ''
    if CHARACTER_COND.match?(string)
      expression = characters_condition(string)
    elsif CHARACTER_SIMP.match?(string)
      expression = characters_simple(string)
    elsif DIGIT_COND.match?(string)
      expression = digit_condition(string)
    elsif DIGIT_SIMPLE.match?(string)
      expression = digit_simple(string)
    end

    at_mod = at_condition(string) if AT_COND.match?(string)

    Regexp.new "#{at_mod}#{expression}"
  end

  def self.characters_condition(string)
    except = '^' if /(except)/.match?(string)
    multiples = '+' if /(character)(s)/.match?(string)
    if /( ([a-z])(-)(([a-z])))/i.match?(string)
      character_mod = string.match(/([a-z]-[a-z])/i)
    elsif /( ([a-z])(( through )|( to ))(([a-z])))/i.match?(string)
      unfiltered_mod = string.match(/(([a-z])(( through )|( to ))(([a-z])))/)
      character_mod = unfiltered_mod.to_s.sub(/( through )|( to )/, '-')
    elsif /( ([a-z] )+(and )([a-z]))/.match?(string)
      unfiltered_mod = string.match(/( ([a-z] )+(and )([a-z]))/)
      character_mod = unfiltered_mod.to_s.gsub(/( )|(and )/, '')
    end
    "[#{except}#{character_mod}]#{multiples}"
  end

  def self.characters_simple(string)
    character_mod = 'a-zA-Z'
    multiples = '+' if /(character)(s)/.match?(string)
    if /(uppercase)/.match?(string)
      character_mod = 'A-Z'
    elsif /(lowercase)/.match?(string)
      character_mod = 'a-z'
    end
    "[#{character_mod}]#{multiples}"
  end

  def self.digit_condition(string)
    except = '^' if /(except)/.match?(string)
    multiples = '+' if /((digit)|(number))(s)/.match?(string)
    if /( ([0-9])(-)(([0-9])))/.match?(string)
      digit_mod = string.match(/([0-9]-[0-9])/)
    elsif /( ([0-9])(( through )|( to ))(([0-9])))/i.match?(string)
      unfiltered_mod = string.match(/(([0-9])(( through )|( to ))(([0-9])))/)
      digit_mod = unfiltered_mod.to_s.sub(/( through )|( to )/, '-')
    elsif /((between) ([0-9])( and )([0-9]))/.match?(string)
      unfiltered_mod = string.match(/(([0-9])( and )([0-9]))/)
      digit_mod = unfiltered_mod.to_s.sub(/( and )/, '-')
      # elsif /( ([a-z] )+(and )([a-z]))/.match?(string)
      #   unfiltered_mod = string.match(/( ([a-z] )+(and )([a-z]))/)
      #   digit_mod = unfiltered_mod.to_s.gsub(/( )|(and )/, '')
    end
    "[#{except}#{digit_mod}]#{multiples}"
  end

  def self.digit_simple(string)
    digit_mod = '0-9'
    multiples = '+' if /((digit)|(number))(s)/.match?(string)
    "[#{digit_mod}]#{multiples}"
  end

  def self.at_condition(string)
    at_mod = '^' if /(start of line)/.match?(string)
    at_mod = '$' if /(end of line)/.match?(string)
    at_mod = '\A' if /(start of string)/.match?(string)
    at_mod = '\z' if /(end of string)/.match?(string)
    at_mod
  end
end
