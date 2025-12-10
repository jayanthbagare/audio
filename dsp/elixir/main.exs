Code.require_file("lib/globalvars.ex")
Code.require_file("lib/audio.ex")

sample_rate = GlobalVars.sample_rate()
frequency = GlobalVars.frequency()
duration = GlobalVars.duration()
attack_t = GlobalVars.attack_t()
decay_t = GlobalVars.attack_d()
release_t = GlobalVars.attack_r()
sustain_level = GlobalVars.sustain_level()
lfo_frequency = GlobalVars.lfo_frequency()
lfo_depth = GlobalVars.lfo_depth()
cutoff_frequency = GlobalVars.cutoff_frequency()

alpha = Audio.calculate_alpha(cutoff_frequency,1.0)

# Sine Wave generator
filename = "sine.wav"
Audio.sine(frequency, duration)
|> Audio.adsr(sample_rate, attack_t, decay_t, release_t, sustain_level)
|> Audio.tremolo_apply(sample_rate, lfo_frequency, lfo_depth)
|> Audio.encode_binary()
|> Audio.save_wav(filename)

# Square wave tremolo generator
filename = "square.wav"

Audio.square(frequency, duration)
|> Audio.adsr(sample_rate, attack_t, decay_t, release_t, sustain_level)
|> Audio.tremolo_apply(sample_rate, lfo_frequency, lfo_depth)
|> Audio.apply_low_pass_filter(alpha)
|> Audio.encode_binary()
|> Audio.save_wav(filename)

# Saw wave tremolo generator
filename = "saw.wav"

Audio.saw(frequency, duration)
|> Audio.adsr(sample_rate, attack_t, decay_t, release_t, sustain_level)
|> Audio.tremolo_apply(sample_rate, lfo_frequency, lfo_depth)
|> Audio.apply_low_pass_filter(alpha)
|> Audio.encode_binary()
|> Audio.save_wav(filename)

# Triangle wave tremolo generator
filename = "triangle.wav"

Audio.triangle(frequency, duration)
|> Audio.adsr(sample_rate, attack_t, decay_t, release_t, sustain_level)
|> Audio.tremolo_apply(sample_rate, lfo_frequency, lfo_depth)
|> Audio.encode_binary()
|> Audio.save_wav(filename)
