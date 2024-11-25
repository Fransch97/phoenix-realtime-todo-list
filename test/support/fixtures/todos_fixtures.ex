defmodule RealtimeTodo.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealtimeTodo.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        completed: true,
        title: "some title"
      })
      |> RealtimeTodo.Todos.create_todo()

    todo
  end
end
