# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the book "Functional Web Development" by Lance Halvorsen. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Islands.Player do
  use PersistConfig

  @book_ref Application.get_env(@app, :book_ref)

  @moduledoc """
  Creates a `player` struct for the _Game of Islands_.
  \n##### #{@book_ref}
  """

  alias __MODULE__
  alias Islands.{Board, Guesses}

  @genders [:f, :m]

  @derive {Poison.Encoder, only: [:name, :gender, :board, :guesses]}
  @derive {Jason.Encoder, only: [:name, :gender, :board, :guesses]}
  @enforce_keys [:name, :gender, :pid]
  defstruct name: nil,
            gender: nil,
            pid: nil,
            board: Board.new(),
            guesses: Guesses.new()

  @type gender :: :f | :m
  @type t :: %Player{
          name: String.t(),
          gender: gender,
          pid: pid | nil,
          board: Board.t(),
          guesses: Guesses.t()
        }

  @spec new(String.t(), gender, pid | nil) :: t | {:error, atom}
  def new(name, gender, pid)
      when is_binary(name) and gender in @genders and
             (is_pid(pid) or is_nil(pid)),
      do: %Player{name: name, gender: gender, pid: pid}

  def new(_name, _gender, _pid), do: {:error, :invalid_player_args}
end
