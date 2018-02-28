defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule.Task

  def index(conn, _params) do
    render conn, "index.html"
  end

  def agenda(conn, _params) do
    # for the following code I referred https://til.hashrocket.com/posts/vikw0jg3hh-phoenix-select-form-helper
    allusers = Tasktracker.Accounts.list_users()
    users = Tasktracker.Accounts.list_users()
            |> Enum.map(&{"#{&1.name}",&1.id})
    #######################
    underling_users = Tasktracker.Accounts.list_users()
            |> Enum.filter(fn(x) -> x.manager_id == conn.assigns.current_user.id end)
            |> Enum.map(&{"#{&1.name}",&1.id})
    tasks = Tasktracker.Schedule.list_tasks()

    changeset = Tasktracker.Schedule.change_task(%Task{})
    render conn, "agenda.html", users: users, underling_users: underling_users ,tasks: tasks, changeset: changeset, allusers: allusers
  end

end
