# frozen_string_literal: true

require 'regeng/version'

# A gem which creates regular expressions using plain english.
module Regeng
  CHARACTER_COND = /((any )?(character)(s)?( except)?( between)?( [a-zA-Z])+((-)|( through )|( to )|( and )){1}[a-zA-Z]){1}/.freeze
  CHARACTER_SIMP = /((any )?((uppercase )?|(lowercase )?)(character)(s)?){1}/.freeze

  DIGIT_COND = /((any )?((digit)|(number))(s)?( except)?( between)?( [0-9])(0)*((-)|( through )|( to )|( and )){1}([0-9])(0)*){1}/.freeze
  DIGIT_SIMPLE = /(any ((digit)|(number))(s)?){1}/.freeze

  AT_COND = /( at )((start)|(end))( of )((line)|(string))/.freeze

  # Regeng's error raiser.
  class Error < StandardError
    def self.invalid_expression(string)
      raise ArgumentError, "Invalid expression, check spelling: '#{string}'"
    end
  end

  # Returns a new regular expression using plain english.
  def self.new(string)
    expression(string)
  end

  # Processes plain english into a regular expression.
  def self.expression(string)
    if CHARACTER_COND.match?(string)
      expression = characters_condition(string)
    elsif CHARACTER_SIMP.match?(string)
      expression = characters_simple(string)
    elsif DIGIT_COND.match?(string)
      expression = digit_condition(string)
    elsif DIGIT_SIMPLE.match?(string)
      expression = digit_simple(string)
    end

    # Adds a 'at' modifier if one is present.
    at_mod = at_condition(string) if AT_COND.match?(string)

    Error.invalid_expression(string) if expression.nil?

    Regexp.new "#{at_mod}#{expression}"
  end

  #  Processes conditional character expressions.
  def self.characters_condition(string)
    except = '^' if /(except)/.match?(string)
    multiples = '+' if /(character)(s)/.match?(string)
    if /( ([a-z])(-)(([a-z])))/i.match?(string)
      character_mod = string.match(/([a-z]-[a-z])/i)
    elsif /( ([a-z])(( through )|( to ))(([a-z])))/i.match?(string)
      unfiltered_mod = string.match(/(([a-z])(( through )|( to ))(([a-z])))/)
      character_mod = unfiltered_mod.to_s.sub(/( through )|( to )/, '-')
    elsif /((between) ([a-z])( and )([a-z]))/.match?(string)
      unfiltered_mod = string.match(/(([a-z])( and )([a-z]))/)
      character_mod = unfiltered_mod.to_s.sub(/( and )/, '-')
    elsif /( ([a-z] )+(and )([a-z]))/.match?(string)
      unfiltered_mod = string.match(/( ([a-z] )+(and )([a-z]))/)
      character_mod = unfiltered_mod.to_s.gsub(/( )|(and )/, '')
    end

    character_mod = character_mod.to_s

    character_mod = if /(uppercase)/.match?(string)
                      character_mod.upcase
                    elsif /(lowercase)/.match?(string)
                      character_mod.downcase
                    else
                      "#{character_mod.upcase}#{character_mod.downcase}"
                    end

    Error.invalid_expression if character_mod.nil? || character_mod == '-'

    "[#{except}#{character_mod}]#{multiples}"
  end

  # Processes simple character expressions.
  def self.characters_simple(string)
    character_mod = 'A-Za-z'
    multiples = '+' if /(character)(s)/.match?(string)
    if /(uppercase)/.match?(string)
      character_mod = 'A-Z'
    elsif /(lowercase)/.match?(string)
      character_mod = 'a-z'
    end
    "[#{character_mod}]#{multiples}"
  end

  # Processes conditional digit/number expressions.
  def self.digit_condition(string)
    complex = false
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
    elsif /( ([0-9] )+(and )([0-9])+)/.match?(string)
      unfiltered_mod = string.match(/( ([0-9] )+(and )([0-9]))/)
      digit_mod = unfiltered_mod.to_s.gsub(/( )|(and )/, '')
    elsif /( ([0-9](0)+ )((and )|(to ))([1-9](0)+))/.match?(string)
      unfiltered_mod = string.match(/(([0-9](0)+ )((and )|(to ))([1-9](0)+))/)
      digit_mod = complex_numbers(unfiltered_mod.to_s)
      complex = true
    end

    Error.invalid_expression if digit_mod.nil? || digit_mod == '-'

    if complex
      digit_mod.to_s
    else
      "[#{except}#{digit_mod}]#{multiples}"
    end
  end

  # Processes simple digit expressions.
  def self.digit_simple(string)
    digit_mod = '0-9'
    multiples = '+' if /((digit)|(number))(s)/.match?(string)
    "[#{digit_mod}]#{multiples}"
  end

  # Processes 'at end/start of' expression modifier.
  def self.at_condition(string)
    at_mod = '^' if /(start of line)/.match?(string)
    at_mod = '$' if /(end of line)/.match?(string)
    at_mod = '\A' if /(start of string)/.match?(string)
    at_mod = '\z' if /(end of string)/.match?(string)
    at_mod
  end

  # Helpers
  def self.complex_numbers(string)
    # extracts first number
    first_number = string.match(/([0-9](0)* )((and )|(to ))/)
    first_number = first_number.to_s.gsub(/( )|(and )/, '')

    # extracts second number
    second_number = string.match(/( [1-9](0)+)/)
    second_number = second_number.to_s.sub(/( )/, '')

    process_complex_numbers(first_number, second_number)
  end

  def self.process_complex_numbers(first_number, second_number)
    mod_array = []

    first_digit = first_number.sub(/(0)+/, '')
    first_zeros = first_number.match(/(0)+/)
    zeros_length = first_zeros.to_s.length

    second_digit = second_number.sub(/(0)+/, '')

    (first_digit...second_digit).to_a.each do |digit|
      modifier = "(#{digit}"
      zeros_length.times do |_|
        modifier = "#{modifier}[0-9]"
      end
      modifier = "#{modifier})"
      mod_array.push(modifier)
    end

    "#{mod_array.join('|')}|(#{second_number})"
  end
end
