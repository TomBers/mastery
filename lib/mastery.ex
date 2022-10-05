#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery do
  alias Mastery.Boundary.{QuizSession, QuizManager}
  alias Mastery.Boundary.{TemplateValidator, QuizValidator}
  alias Mastery.Core.Quiz
  
  def start_quiz_manager() do
    GenServer.start_link(QuizManager, %{}, name: QuizManager)
  end

  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <-GenServer.call(QuizManager, {:build_quiz, fields}), 
    do: :ok, else: (error -> error)
  end
  
  def add_template(title, fields) do
    with :ok <- TemplateValidator.errors(fields), 
         :ok <- GenServer.call(QuizManager, {:add_template, title, fields}), 
    do: :ok, else: (error -> error)
  end
  
  def take_quiz(title, email) do
    with %Quiz{}=quiz <- QuizManager.lookup_quiz_by_title(title), 
         {:ok, session} <- GenServer.start_link(QuizSession, {quiz, email}) 
    do
      session
    else
      error -> error
    end
  end
  
  def select_question(session) do
    GenServer.call(session, :select_question)
  end

  def answer_question(session, answer) do
    GenServer.call(session, {:answer_question, answer})
  end
end

