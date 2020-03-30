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

    ben = %Player{
      name: "Ben",
      gender: :m,
      pid: nil,
      board: nil,
      guesses: nil
    }

    poison =
      ~s<{"name":"Sue","guesses":{"misses":[],"hits":[]},"gender":"f","board":{"misses":[],"islands":{}}}>

    jason =
      ~s<{"name":"Sue","gender":"f","board":{"islands":{},"misses":[]},"guesses":{"hits":[],"misses":[]}}>

    decoded = %{
      "board" => %{"islands" => %{}, "misses" => []},
      "guesses" => %{"hits" => [], "misses" => []},
      "name" => "Sue",
      "gender" => "f"
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
      assert Player.new("Sue", :f, that) == players.sue
      assert Player.new("Sue", :f, that, basic: false) == players.sue
      assert Player.new("Ben", :m, nil, basic: true) == players.ben
      assert Player.new("Ben", :m, nil, basic: true, what: nil) == players.ben
    end

    test "returns {:error, ...} given invalid args" do
      assert Player.new('Jim', :m, nil) == {:error, :invalid_player_args}
    end
  end
end
