defmodule Quizzez.HelpersTest do
  use Quizzez.DataCase, async: true

  alias Quizzez.Helpers

  describe "upcase_first_letter/1" do
    test "makes first letter uppercase" do
      assert "Food" = Helpers.upcase_first_letter("food")
      assert "Cinema" = Helpers.upcase_first_letter("cinema")
      assert "Santa" = Helpers.upcase_first_letter("santa")
    end

    test "handles unicode characters" do
      assert "Gröt" = Helpers.upcase_first_letter("gröt")
      assert "Jätteödla" = Helpers.upcase_first_letter("jätteödla")
    end

    test "handles 1 character" do
      assert "A" = Helpers.upcase_first_letter("a")
    end
  end
end
