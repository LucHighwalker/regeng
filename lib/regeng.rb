require 'regeng/version'

# A gem which creates regular expressions using plain english.
module Regeng
  class Error < StandardError; end

  def self.get_expression(string)
    array = string.split(' and ')
    start = ''
    middle = ''
    ending = ''
    if string =~ /(any){1}/
      if string =~ /(character){1}/
        if string =~ /[a-z]-[a-z]/i
          character_mod = string.match(/[a-z]-[a-z]/i)
          character_mod = "^#{character_mod}" if string =~ /(except){1}/
          middle = "#{middle}[#{character_mod}]"
        elsif string =~ /(uppercase){1}/
          middle = "#{middle}[A-Z]"
        elsif string =~ /(lowercase){1}/
          middle = "#{middle}[a-z]"
        else
          middle = "#{middle}[A-Za-z]"
        end
      elsif string =~ /(digits){1}/
        if string =~ /([0-9]+-[0-9]+){1}/
          character_mod = string.match(/([0-9]+-[0-9]+){1}/)
          character_mod = "^#{character_mod}" if string =~ /(except){1}/
          middle = "#{middle}[#{character_mod}]"
        else
          middle = "#{middle}[0-9]"
        end
      end
      if string =~ /(at){1}/
        if string =~ /(start of){1}/
          if string =~ /(line)?/
            start = "#{start}^"
          elsif string =~ /(string){1}/
            start = "#{start}\\A"
          end
        elsif string =~ /(end of){1}/
          if string =~ /(line){1}/
            start = "#{start}$"
          elsif string =~ /(string){1}/
            start = "#{start}\\z"
          end
        end
      end
    end
    "#{start}#{middle}#{ending}"
  end
end
