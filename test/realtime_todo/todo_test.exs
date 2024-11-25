defmodule RealtimeTodo.TodoTest do
  use RealtimeTodo.DataCase

  alias RealtimeTodo.Todo

  describe "lists" do
    alias RealtimeTodo.Todo.List

    import RealtimeTodo.TodoFixtures

    @invalid_attrs %{list: nil, title: nil, completed: nil}

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Todo.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Todo.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      valid_attrs = %{list: "some list", title: "some title", completed: true}

      assert {:ok, %List{} = list} = Todo.create_list(valid_attrs)
      assert list.list == "some list"
      assert list.title == "some title"
      assert list.completed == true
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      update_attrs = %{list: "some updated list", title: "some updated title", completed: false}

      assert {:ok, %List{} = list} = Todo.update_list(list, update_attrs)
      assert list.list == "some updated list"
      assert list.title == "some updated title"
      assert list.completed == false
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_list(list, @invalid_attrs)
      assert list == Todo.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Todo.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Todo.change_list(list)
    end
  end
end
