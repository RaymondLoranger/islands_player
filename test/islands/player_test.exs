defmodule Islands.PlayerTest do
  use ExUnit.Case, async: true

  alias Islands.{Board, Guesses, Player}

  doctest Player

  setup_all do
    this = self()

    sue = %Player{
      name: "Sue",
      pid: this,
      board: Board.new(),
      guesses: Guesses.new()
    }

    ben = %Player{
      name: "Ben",
      pid: nil,
      board: Board.new(),
      guesses: Guesses.new()
    }

    {:ok, players: %{sue: sue, ben: ben}, pid: this}
  end

  describe "A player struct" do
    test "can be encoded by Poison", %{players: players} do
      assert Poison.encode!(players.sue) == ~s<{\"name\":\"Sue\"}>
    end

    test "can be encoded by Jason", %{players: players} do
      assert Jason.encode!(players.sue) == ~s<{\"name\":\"Sue\"}>
    end
  end

  describe "Player.new/1" do
    test "returns %Player{} given valid args", %{players: players, pid: that} do
      assert Player.new("Sue", that) == players.sue
      assert Player.new("Ben", nil) == players.ben
    end

    test "returns {:error, ...} given invalid args" do
      assert Player.new('Jim', nil) == {:error, :invalid_player_args}
    end
  end
end
