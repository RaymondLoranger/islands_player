defmodule Islands.Player.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_player,
      version: "0.1.17",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Islands Player",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_player"
  end

  defp description do
    """
    Creates a player struct for the Game of Islands.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:islands_board, "~> 0.1"},
      {:islands_config, "~> 0.1", runtime: false},
      {:islands_guesses, "~> 0.1"},
      {:jason, "~> 1.0"},
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:poison, "~> 4.0"}
    ]
  end
end
