defmodule QuestionTest do
  use ExUnit.Case
  use QuizBuilders

  test "building chooses substitutes" do
    question = build_question(generators: addition_generators([1], [2]))

    assert question.subsitutions == [left: 1, right: 2]
  end

  test "function generators are called" do
    generators = addition_generators(fn -> 42 end, [0])
    subsitutions = build_question(generators: generators).subsitutions

    assert Keyword.fetch!(subsitutions, :left) == generators.left.()
  end

  test "building creates a question text" do
    question = build_question(generators: addition_generators([1], [2]))
    assert question.asked == "1 + 2"
  end

  test "a random choice is made from the list of generators" do
    generators = addition_generators(Enum.to_list(1..9), [0])

    assert eventually_match(generators, 1)
    assert eventually_match(generators, 9)
  end

  def eventually_match(generators, answer) do
    Stream.repeatedly(fn -> build_question(generators: generators).subsitutions end)
    |> Enum.find(fn sub -> Keyword.fetch!(sub, :left) == answer end)
  end
end
