defmodule Tasktracker.Schedule.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Schedule.Timeblock


  schema "timeblocks" do
    field :endtime, :utc_datetime
    field :starttime, :utc_datetime
    belongs_to :task, Tasktracker.Schedule.Task

    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:endtime, :starttime, :task_id])
    |> validate_required([:starttime, :endtime, :task_id])
  end
end
