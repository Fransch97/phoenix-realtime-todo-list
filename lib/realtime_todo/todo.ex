defmodule RealtimeTodo.Todo do
  alias RealtimeTodo.Repo
  alias RealtimeTodo.Todos.Todo

  # Elenco tutti i To-Do
  def list_todos do
    Repo.all(Todo)
  end

  # Crea un nuovo To-Do
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end

  # Ottieni un To-Do per ID
  def get_todo!(id), do: Repo.get!(Todo, id)

  # Aggiorna un To-Do
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  # Elimina un To-Do
  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end
end
