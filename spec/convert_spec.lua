local argparse = require "argparse"

describe("tests related to converters", function()
   it("converts arguments", function()
      local parser = argparse.parser()
      parser:argument "numbers" {
         convert = tonumber,
         args = "+"
      }

      local args = parser:parse{"1", "2", "500"}
      assert.same({numbers = {1, 2, 500}}, args)
   end)

   it("raises an error when it can't convert", function()
      local parser = argparse.parser()
      parser:argument "numbers" {
         convert = tonumber,
         args = "+"
      }

      assert.has_error(function() parser:parse{"foo", "bar", "baz"} end, "malformed argument foo")
   end)

   it("second return value is used as error message", function()
      local parser = argparse.parser()
      parser:argument "numbers" {
         convert = function(x) return tonumber(x), x .. " is not a number" end
      }

      assert.has_error(function() parser:parse{"foo"} end, "foo is not a number")
   end)
end)
