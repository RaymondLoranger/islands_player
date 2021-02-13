# ┌────────────────────────────────────────────────────────────────────┐
# │ Based on the book "Functional Web Development" by Lance Halvorsen. │
# └────────────────────────────────────────────────────────────────────┘
defmodule Islands.Player do
  @moduledoc """
  Creates a `player` struct for the _Game of Islands_.

  ##### Based on the book [Functional Web Development](https://pragprog.com/book/lhelph/functional-web-development-with-elixir-otp-and-phoenix) by Lance Halvorsen.
  """

  alias __MODULE__
  alias Islands.{Board, Guesses}

  @genders [:f, :m]

  @derive {Poison.Encoder, only: [:name, :gender, :board, :guesses]}
  @derive {Jason.Encoder, only: [:name, :gender, :board, :guesses]}
  @enforce_keys [:name, :gender, :pid, :board, :guesses]
  defstruct [:name, :gender, :pid, :board, :guesses]

  @type gender :: :f | :m
  @type name :: String.t()
  @type t :: %Player{
          name: name,
          gender: gender,
          pid: pid | nil,
          board: Board.t(),
          guesses: Guesses.t()
        }

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
