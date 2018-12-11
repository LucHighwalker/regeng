# frozen_string_literal: true

require 'regeng/version'

# A gem which creates regular expressions using plain english.
module Regeng
  class Error < StandardError; end

  CHARACTER_COND = /(any character(s)?( except)?( between)?( [a-zA-Z])+((-)|( through )|( to )|( and )){1}[a-zA-Z]){1}/.freeze
  CHARACTER_SIMP = /(any ((uppercase )?|(lowercase )?)character){1}/.freeze

  def self.expression(string)
    expression = ''
    if CHARACTER_COND.match?(string)
      puts string.match(CHARACTER_COND)
      expression = characters_condition(string)
    elsif CHARACTER_SIMP.match?(string)
      puts string.match(CHARACTER_SIMP)
      expression = characters_simple(string)
    end

    Regexp.new expression
  end

  def self.characters_condition(string)
    result = ''
    character_mod = ''
    except = ''
    if /( ([a-z])(-)(([a-z])))/i.match?(string)
      character_mod = string.match(/([a-z]-[a-z])/i)
    elsif /( ([a-z])(( through )|( to ))(([a-z])))/i.match?(string)
      unfiltered_mod = string.match(/(([a-z])(( through )|( to ))(([a-z])))/)
      character_mod = unfiltered_mod.to_s.sub(/( through )|( to )/, '-')
    elsif /( ([a-z] )+(and )([a-z]))/.match?(string)
      unfiltered_mod = string.match(/( ([a-z] )+(and )([a-z]))/)
      character_mod = unfiltered_mod.to_s.gsub(/( )|(and )/, '')
    end
    except = '^' if /(except)/.match?(string)
    result = "#{result}[#{except}#{character_mod}]" if character_mod != ''
    result
  end

  def self.characters_simple(string)
    result = '[a-zA-Z]'
    if /(uppercase)/.match?(string)
      result = '[A-Z]'
    elsif /(lowercase)/.match?(string)
      result = '[a-z]'
    end
    result
  end
end
