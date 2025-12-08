defmodule Encode do
	def binary(samples) do
    Enum.map(samples, fn sample ->
      scaled = trunc(sample * 32767)
      <<scaled::little-signed-16>>
    end)
    |> Enum.into(<<>>)
  end
end