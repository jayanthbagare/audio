Code.require_file("exercise1.ex")

filename = "output.wav"
duration = 1.0
frequency = 440

vals = Audio.generate_samples(frequency, duration)
binary_data = Audio.encode_binary(vals)
Audio.save_file("output.wav", binary_data)
