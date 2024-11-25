defmodule RealtimeTodoWeb.TodoLive.Index do
  use RealtimeTodoWeb, :live_view

  alias RealtimeTodo.Todos
  alias Phoenix.PubSub

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe(RealtimeTodo.PubSub, "todos")

    {:ok,
     socket
     |> assign(:todos, Todos.list_todos())
     |> assign(:mouse_positions, %{})}
  end

  def handle_event("add_todo", %{"title" => title}, socket) do
    {:ok, _todo} = Todos.create_todo(%{title: title, completed: false})
    PubSub.broadcast(RealtimeTodo.PubSub, "todos", {:todo_updated})
    {:noreply, socket}
  end

  def handle_event("toggle_complete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    {:ok, _todo} = Todos.update_todo(todo, %{completed: !todo.completed})
    PubSub.broadcast(RealtimeTodo.PubSub, "todos", {:todo_updated})
    {:noreply, socket}
  end

  def handle_info({:todo_updated}, socket) do
    {:noreply, assign(socket, :todos, Todos.list_todos())}
  end

  def handle_event("track_mouse", %{"x" => x, "y" => y}, socket) do
    id = socket.id || Enum.random(1..1000)
    updated_positions = Map.put(socket.assigns.mouse_positions, id, %{x: x, y: y})
    {:noreply, assign(socket, :mouse_positions, updated_positions)}
  end

  def handle_event("add_todo", %{"title" => title}, socket) do
    {:ok, _todo} = Todos.create_todo(%{title: title, completed: false})
    PubSub.broadcast(RealtimeTodo.PubSub, "todos", {:todo_updated})
    {:noreply, socket}
  end

  def handle_event("toggle_complete", %{"id" => id}, socket) do
    todo = Todos.get_todo!(id)
    {:ok, _todo} = Todos.update_todo(todo, %{completed: !todo.completed})
    PubSub.broadcast(RealtimeTodo.PubSub, "todos", {:todo_updated})
    {:noreply, socket}
  end

  def handle_event("track_mouse", %{"x" => x, "y" => y}, socket) do
    id = socket.id || Enum.random(1..1000)
    updated_positions = Map.put(socket.assigns.mouse_positions, id, %{x: x, y: y})
    {:noreply, assign(socket, :mouse_positions, updated_positions)}
  end

end
