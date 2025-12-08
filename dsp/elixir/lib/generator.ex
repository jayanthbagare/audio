Code.require_file("lib/globalvars.ex")

defmodule Generate do
@sample_rate GlobalVars.sample_rate()

  def sine(frequency, duration) do
    total_samples = trunc(@sample_rate * duration)

    0..total_samples
    |> Enum.map(fn index ->
      t = index / @sample_rate
      :math.sin(2 * :math.pi() * frequency * t)
    end)
  end

  def square(frequency, duration) do
    total_samples = trunc(@sample_rate * duration)
    nyquist_limit = @sample_rate / 2

    0..total_samples
    |> Enum.map(fn index ->
      t = index / @sample_rate

      Stream.iterate(1, &(&1 + 2))
      |> Stream.take_while(fn n -> n * frequency < nyquist_limit end)
      |> Enum.reduce(0, fn n, acc ->
        harmonic_frequency = n * frequency
        harmonic_amp = 1 / n
        acc + harmonic_amp * :math.sin(2 * :math.pi() * harmonic_frequency * t)
      end)
      |> Kernel.*(4 / :math.pi())
    end)
  end

  def saw(frequency, duration) do
    total_samples = trunc(@sample_rate * duration)
    nyquist_limit = @sample_rate / 2

    0..total_samples
    |> Enum.map(fn index ->
      t = index / @sample_rate

      Stream.iterate(2, &(&1 + 2))
      |> Stream.take_while(fn n ->
        n * frequency < nyquist_limit
      end)
      |> Enum.reduce(0, fn n, acc ->
        harmonic_frequency = n * frequency
        harmonic_amp = 1 / n
        acc + harmonic_amp * :math.sin(2 * :math.pi() * harmonic_frequency * t)
      end)
      |> Kernel.*(2 / :math.pi())
    end)
  end

  def triangle(frequency, duration) do
    total_samples = trunc(@sample_rate * duration)
    nyquist_limit = @sample_rate / 2

    0..total_samples
    |> Enum.map(fn index ->
      t = index / @sample_rate

      Stream.iterate(2, &(&1 + 2))
      |> Stream.take_while(fn n ->
        n * frequency < nyquist_limit
      end)
      |> Enum.reduce(0, fn n, acc ->
        harmonic_frequency = n * frequency
        harmonic_amp = 1 / n
        acc + harmonic_amp * :math.sin(2 * :math.pi() * harmonic_frequency * t)
      end)
      |> Kernel.*(2 / :math.pi())
    end)
  end
end