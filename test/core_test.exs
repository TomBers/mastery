defmodule CoreTest do
  use ExUnit.Case
  alias Mastery.Core.{Template, Quiz, Response}

  test "functional core" do
    generator = %{left: [1, 2, 3], right: [1, 2, 3]}
    checker = fn(sub, answer) -> sub[:left] + sub[:right] == String.to_integer(answer) end

    quiz =
      Quiz.new(title: "Addition", mastery: 2)
      |> Quiz.add_template(
        name: :single_digit_addition,
        category: :addition,
        instructions: "Add the numbers",
        raw: "<%= @left %> + <%= @right %>",
        generators: generator,
        checker: checker
      )
      |> Quiz.select_question()

      email = "bill@example.com"

      response = Response.new(quiz, email, "0")

      quiz = Quiz.answer_question(quiz, response)

      quiz.record |> dbg
    assert true
  end

end
