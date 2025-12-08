defmodule Envelope do
  def adsr(sample, sample_rate, attack_t, decay_t, release_t, sustain_level) do
    total_count = length(sample)

    # Convert seconds to sample counts
    sample_a = trunc(attack_t * sample_rate)
    sample_d = trunc(decay_t * sample_rate)
    sample_r = trunc(release_t * sample_rate)

    sample_s = total_count - (sample_a + sample_r + sample_d)

    sample
    |> Enum.with_index()
    |> Enum.map(fn {sample_val, i} ->
      multiplier =
        cond do
          # attack 
          i < sample_a ->
            i / sample_a

          i < sample_a + sample_d ->
            progress = (i - sample_a) / sample_d
            1.0 - progress * (1.0 - sustain_level)

          i < sample_a + sample_d + sample_s ->
            sustain_level

          true ->
            remaining_samples = total_count - i
            remaining_samples / sample_r * sustain_level
        end

      sample_val * multiplier
    end)
  end
end
