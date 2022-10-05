#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery.Boundary.QuizValidator do
  import Mastery.Boundary.Validator

  def errors(fields) when is_map(fields) do
    [ ]
    |> require(fields, :title, &validate_title/1)
    |> optional(fields, :mastery, &validate_mastery/1)
  end
  def errors(_fields), do: [{nil, "A map of fields is required"}]

  def validate_title(title) when is_binary(title) do
    check(String.match?(title, ~r{\S}), {:error, "can't be blank"})
  end
  def validate_title(_title), do: {:error, "must be a string"}

  def validate_mastery(mastery) when is_integer(mastery) do
    check(mastery >= 1, {:error, "must be greater than zero"})
  end
  def validate_mastery(_mastery), do: {:error, "must be an integer"}
end
