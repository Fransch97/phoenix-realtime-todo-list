defmodule RealtimeTodo.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RealtimeTodo.Todo` context.
  """

  @doc """
  Generate a list.
  """
  def list_fixture(attrs \\ %{}) do
    {:ok, list} =
      attrs
      |> Enum.into(%{
        completed: true,
        list: "some list",
        title: "some title"
      })
      |> RealtimeTodo.Todo.create_list()

    list
  end
end
