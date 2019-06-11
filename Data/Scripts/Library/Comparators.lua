--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              [TR]Pox
--*   @Date:                2017-12-14T10:54:01+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            Comparators.lua
--*   @Last modified by:    Pox
--*   @Last modified time:  2018-01-05T18:18:28+01:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************


---@param num number
function EqualTo (num)
  return {
    number = num,
    evaluate = function(self, number)
      return self.number == number
    end
  }
end

function GreaterThan (num)
  return {
    number = num,
    evaluate = function(self, number)
      return self.number > number
    end
  }
end

function GreaterOrEqualTo (num)
  return {
    number = num,
    evaluate = function(self, number)
      return self.number >= number
    end
  }
end

function LessThan (num)
  return {
    number = num,
    evaluate = function(self, number)
      return self.number < number
    end
  }
end

function LessOrEqualTo (num)
  return {
    number = num,
    evaluate = function(self, number)
      return self.number <= number
    end
  }
end

function InInterval(lower, upper)
  return {
    lower = lower,
    upper = upper,
    evaluate = function(self, number)
      return number >= self.lower and number <= self.upper
    end
  }
end

function IsOneOf(tab)
  return {
    tab = tab,
    evaluate = function(self, value)
      for _, v in pairs(self.tab) do
        if v == value then
          return true
        end
      end
      return false
    end
  }
end