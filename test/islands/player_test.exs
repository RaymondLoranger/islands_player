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

    poison =
      ~s<{\"name\":\"Sue\",\"guesses\":{\"misses\":[],\"hits\":[]},\"board\":{\"misses\":[],\"islands\":{}}}>

    jason =
      ~s<{\"name\":\"Sue\",\"board\":{\"islands\":{},\"misses\":[]},\"guesses\":{\"hits\":[],\"misses\":[]}}>

    decoded = %{
      "board" => %{"islands" => %{}, "misses" => []},
      "guesses" => %{"hits" => [], "misses" => []},
      "name" => "Sue"
    }

    {:ok,
     players: %{sue: sue, ben: ben},
     json: %{poison: poison, jason: jason, decoded: decoded},
     pid: this}
  end

  describe "A player struct" do
    test "can be encoded by Poison", %{players: players, json: json} do
      assert Poison.encode!(players.sue) == json.poison
      assert Poison.decode!(json.poison) == json.decoded
    end

    test "can be encoded by Jason", %{players: players, json: json} do
      assert Jason.encode!(players.sue) == json.jason
      assert Jason.decode!(json.jason) == json.decoded
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
