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
end
