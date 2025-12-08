Code.require_file("lib/globalvars.ex")

Code.require_file("lib/encoder.ex")
Code.require_file("lib/adsr.ex")
Code.require_file("lib/generator.ex")
Code.require_file("lib/writer.ex")

sample_rate = GlobalVars.sample_rate()
frequency = GlobalVars.frequency()
duration = GlobalVars.duration()
attack_t = GlobalVars.attack_t()
decay_t = GlobalVars.attack_d()
release_t = GlobalVars.attack_r()
sustain_level = GlobalVars.sustain_level()

# Sine Wave generator
filename = "sine.wav"
sine = Generate.sine(frequency, duration)
sine_samples = Envelope.adsr(sine, sample_rate, attack_t, decay_t, release_t, sustain_level)
sine_data = Encode.binary(sine_samples)
Write.save_wav(filename, sine_data)

# Square Wave generator
filename = "square.wav"
square = Generate.square(frequency, duration)
square_samples = Envelope.adsr(square, sample_rate, attack_t, decay_t, release_t, sustain_level)
square_data = Encode.binary(square_samples)
Write.save_wav(filename, square_data)

# Saw Wave generator
filename = "saw.wav"
saw = Generate.saw(frequency, duration)
saw_samples = Envelope.adsr(saw, sample_rate, attack_t, decay_t, release_t, sustain_level)
saw_data = Encode.binary(saw_samples)
Write.save_wav(filename, saw_data)

# Triangle Wave generator
filename = "triangle.wav"
triangle = Generate.triangle(frequency, duration)

triangle_samples =
  Envelope.adsr(triangle, sample_rate, attack_t, decay_t, release_t, sustain_level)

triangle_data = Encode.binary(triangle_samples)
Write.save_wav(filename, triangle_data)
