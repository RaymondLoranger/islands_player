# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the book "Functional Web Development" by Lance Halvorsen. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Islands.Player do
  @moduledoc """
  Creates a player struct for the _Game of Islands_.

  The player struct contains the fields:

    - `name`
    - `gender`
    - `pid`
    - `board`
    - `guesses`

  representing the properties of a player in the _Game of Islands_.

  ##### Based on the book [Functional Web Development](https://pragprog.com/titles/lhelph/functional-web-development-with-elixir-otp-and-phoenix/) by Lance Halvorsen.
  """

  alias __MODULE__
  alias Islands.{Board, Guesses}

  @genders [:f, :m]

  @derive {JSON.Encoder, only: [:name, :gender, :board, :guesses]}
  @enforce_keys [:name, :gender, :pid, :board, :guesses]
  defstruct [:name, :gender, :pid, :board, :guesses]

  @typedoc "Player's gender"
  @type gender :: :f | :m
  @typedoc "Player's name"
  @type name :: String.t()
  @typedoc "A player struct for the Game of Islands"
  @type t :: %Player{
          name: name,
          gender: gender,
          pid: pid | nil,
          board: Board.t(),
          guesses: Guesses.t()
        }

  @doc """
  Creates a player struct from `name`, `gender` and `pid`.

  ## Examples

      iex> alias Islands.{Board, Guesses, Player}
      iex> Player.new("Joe", :m, nil)
      %Player{
        name: "Joe",
        gender: :m,
        pid: nil,
        board: Board.new(),
        guesses: Guesses.new()
      }
  """
  @spec new(name, gender, pid | nil) :: t | {:error, atom}
  def new(name, gender, pid)
      when is_binary(name) and gender in @genders and
             (is_pid(pid) or is_nil(pid)) do
    %Player{
      name: name,
      gender: gender,
      pid: pid,
      board: Board.new(),
      guesses: Guesses.new()
    }
  end

  def new(_name, _gender, _pid), do: {:error, :invalid_player_args}
end
