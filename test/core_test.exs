defmodule CoreTest do
  use ExUnit.Case
  alias Mastery.Core.{Template, Quiz, Response}

  test "incorrect response" do
    generator = %{left: [1, 2, 3], right: [1, 2, 3]}
    calc = fn sub -> sub[:left] + sub[:right] end
    checker = fn(sub, answer) -> calc.(sub) == String.to_integer(answer) end

    quiz =
      Quiz.new(title: "Addition", mastery: 2)
      |> Quiz.add_template(
        name: :single_digit_addition,
        category: :addition,
        instructions: "Add the numbers",
        raw: "<%= @left %> + <%= @right %>",
        generators: generator,
        checker: checker,
        calc_fn: calc
      )
      |> Quiz.select_question()
      # |> dbg

      email = "bill@example.com"

      response = Response.new(quiz, email, "0")

      quiz = Quiz.answer_question(quiz, response)

      # quiz.record |> dbg
    assert quiz.record == %{}
  end

  test "correct response" do
    generator = %{left: [1, 2, 3], right: [1, 2, 3]}
    calc = fn sub -> sub[:left] + sub[:right] end
    checker = fn(sub, answer) -> calc.(sub) == String.to_integer(answer) end

    quiz =
      Quiz.new(title: "Addition", mastery: 2)
      |> Quiz.add_template(
        name: :single_digit_addition,
        category: :addition,
        instructions: "Add the numbers",
        raw: "<%= @left %> + <%= @right %>",
        generators: generator,
        checker: checker,
        calc_fn: calc
      )
      |> Quiz.select_question()

      email = "bill@example.com"

      response = Response.new(quiz, email, "#{quiz.current_question.answer}")

      quiz = Quiz.answer_question(quiz, response)

      quiz.record |> dbg
    assert quiz.record == %{single_digit_addition: 1}
  end

end
