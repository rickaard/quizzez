defmodule Quizzez.Helpers do
  @moduledoc """
  A module with a set of helper functions to be used in the projekt
  """

  def upcase_first_letter(<<first::utf8, rest::binary>>) do
    String.upcase(<<first::utf8>>) <> rest
  end
end
