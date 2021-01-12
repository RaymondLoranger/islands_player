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

  @default_options %{basic: false}
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
          board: Board.t() | nil,
          guesses: Guesses.t() | nil
        }

  @spec new(name, gender, pid | nil, Keyword.t()) :: t | {:error, atom}
  def new(name, gender, pid, options \\ [])

  def new(name, gender, pid, options)
      when is_binary(name) and gender in @genders and is_list(options) and
             (is_pid(pid) or is_nil(pid)) do
    %{basic: basic?} = parse(options)

    %Player{
      name: name,
      gender: gender,
      pid: pid,
      board: if(basic?, do: nil, else: Board.new()),
      guesses: if(basic?, do: nil, else: Guesses.new())
    }
  end

  def new(_name, _gender, _pid, _options), do: {:error, :invalid_player_args}

  ## Private functions

  @spec parse(Keyword.t()) :: map
  defp parse(options), do: parse(options, @default_options)

  @spec parse(Keyword.t(), map) :: map
  defp parse([], options), do: options

  defp parse([{:basic, basic?} | rest], options) when is_boolean(basic?),
    do: parse(rest, %{options | basic: basic?})

  defp parse([_bad_option | rest], options), do: parse(rest, options)
end
