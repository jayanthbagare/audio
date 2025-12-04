Code.require_file("exercise1.ex")

filename = "output.wav"
duration = 1.0
frequency = 440

vals = Sine.generate_samples(frequency, duration)
binary_data = Sine.encode_binary(vals)
Sine.save_file("output.wav", binary_data)
