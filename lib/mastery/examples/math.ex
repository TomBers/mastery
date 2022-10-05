#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery.Examples.Math do
  alias Mastery.Core.Quiz
  def template_fields() do
    [
      name: :single_digit_addition,
      category: :addition,
      instructions: "Add the numbers",
      raw: "<%= @left %> + <%= @right %>",
      generators: addition_generators(),
      checker: &addition_checker/2
    ]
  end

  def addition_checker(substitutions, answer) do
    left = Keyword.fetch!(substitutions, :left)
    right = Keyword.fetch!(substitutions, :right)
    to_string(left + right) == String.trim(answer)
  end

  def addition_generators() do
    %{left: Enum.to_list(0..9), right: Enum.to_list(0..9)}
  end

  def quiz_fields() do
    %{ mastery: 2, title: :simple_addition}
  end

def quiz() do
    quiz_fields()
    |> Quiz.new
    |> Quiz.add_template(template_fields())
  end
end
