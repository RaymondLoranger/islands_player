defmodule Islands.PlayerTest do
  use ExUnit.Case, async: true

  alias Islands.{Board, Guesses, Player}

  doctest Player

  setup_all do
    this = self()

    sue = %Player{
      name: "Sue",
      gender: :f,
      pid: this,
      board: Board.new(),
      guesses: Guesses.new()
    }

    encoded =
      ~s<{"name":"Sue","gender":"f","board":{"islands":{},"misses":[]},"guesses":{"hits":[],"misses":[]}}>

    decoded = %{
      "board" => %{"islands" => %{}, "misses" => []},
      "guesses" => %{"hits" => [], "misses" => []},
      "name" => "Sue",
      "gender" => "f"
    }

    %{
      players: %{sue: sue},
      json: %{encoded: encoded, decoded: decoded},
      pid: this
    }
  end

  describe "A player struct" do
    test "can be encoded by JSON", %{players: players, json: json} do
      assert JSON.encode!(players.sue) == json.encoded
      assert JSON.decode!(json.encoded) == json.decoded
    end
  end

  describe "Player.new/1" do
    test "returns %Player{} given valid args", %{players: players, pid: that} do
      assert Player.new("Sue", :f, that) == players.sue
    end

    test "returns {:error, reason} given invalid args" do
      assert Player.new(Jim, :m, nil) == {:error, :invalid_player_args}
    end
  end
end
