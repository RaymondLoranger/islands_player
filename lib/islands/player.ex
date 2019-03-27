# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the book "Functional Web Development" by Lance Halvorsen. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Islands.Player do
  use PersistConfig

  @book_ref Application.get_env(@app, :book_ref)

  @moduledoc """
  Models a `Player` for the _Game of Islands_.
  \n##### #{@book_ref}
  """

  alias __MODULE__
  alias Islands.{Board, Guesses, Island}

  @derive {Poison.Encoder, only: [:name]}
  @derive {Jason.Encoder, only: [:name]}
  @enforce_keys [:name, :pid]
  defstruct name: "", pid: nil, board: Board.new(), guesses: Guesses.new()

  @type t :: %Player{
          name: String.t(),
          pid: pid | nil,
          board: Board.t(),
          guesses: Guesses.t()
        }

  @spec new(String.t(), pid | nil) :: t | {:error, atom}
  def new(name, pid) when is_binary(name) and (is_pid(pid) or is_nil(pid)),
    do: %Player{name: name, pid: pid}

  def new(_name, _pid), do: {:error, :invalid_player_args}

  @spec forested_types(t) :: [Island.type()]
  def forested_types(%Player{} = player) do
    player.board.islands
    |> Map.values()
    |> Enum.filter(&Island.forested?/1)
    |> Enum.map(& &1.type)
  end
end
