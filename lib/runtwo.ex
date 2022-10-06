defmodule Runtwo do
  alias Mastery.Examples.Math

  def run do
    email1 = "bob@example.com"
    email2 = "bill@e.com"

    title = Math.quiz().title

    Mastery.build_quiz(Math.quiz_fields)
    Mastery.add_template(title, Math.template_fields)

    user1 = Mastery.take_quiz(title, email1)
    user2 = Mastery.take_quiz(title, email2)
  end


end
