defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Schedule
  alias Tasktracker.Schedule.Task

  def index(conn, _params) do
    tasks = Schedule.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Schedule.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Schedule.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        underling_users = Tasktracker.Accounts.list_users()
                |> Enum.filter(fn(x) -> x.manager_id == conn.assigns.current_user.id end)
                |> Enum.map(&{"#{&1.name}",&1.id})

        render(conn, "new.html", underling_users: underling_users, changeset: changeset) # changed here from new.html to show.html
    end
  end

  def show(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    underling_users = Tasktracker.Accounts.list_users()
            |> Enum.filter(fn(x) -> x.manager_id == conn.assigns.current_user.id end)
            |> Enum.map(&{"#{&1.name}",&1.id})
    task = Schedule.get_task!(id)
    changeset = Schedule.change_task(task)
    timeblocks = Schedule.list_timeblocks()
                |> Enum.filter(fn(x) -> x.task_id == task.id end)
    render(conn, "edit.html", task: task, underling_users: underling_users, changeset: changeset, timeblocks: timeblocks)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schedule.get_task!(id)

    case Schedule.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        underling_users = Tasktracker.Accounts.list_users()
                |> Enum.filter(fn(x) -> x.manager_id == conn.assigns.current_user.id end)
                |> Enum.map(&{"#{&1.name}",&1.id})
        timeblocks = Schedule.list_timeblocks()
                |> Enum.filter(fn(x) -> x.task_id == conn.assigns.task.id end)
        render(conn, "edit.html", task: task, underling_users: underling_users,changeset: changeset, timeblocks: timeblocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Schedule.get_task!(id)
    {:ok, _task} = Schedule.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: "/agenda")
  end
end
