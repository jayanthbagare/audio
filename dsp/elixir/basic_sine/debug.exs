{:ok, binary} = File.read("output.wav")

# Pattern match to pull out the header values
<<
  # Should be "RIFF"
  chunk_id::binary-4,
  # File size - 8
  file_size::little-32,
  # Should be "WAVE"
  format::binary-4,
  # Should be "fmt "
  fmt_id::binary-4,
  # Should be 16
  fmt_size::little-32,
  # Should be 1
  audio_fmt::little-16,
  # Should be 1
  channels::little-16,
  # Should be 44100
  sample_rate::little-32,
  # Should be 88200
  byte_rate::little-32,
  # Should be 2
  block_align::little-16,
  # Should be 16
  bits::little-16,
  # Should be "data"
  data_id::binary-4,
  # The size of the audio data
  data_size::little-32,
  # The actual audio
  _rest::binary
>> = binary

IO.puts("""
--- WAV HEADER REPORT ---
Chunk ID:    #{chunk_id} (Expected "RIFF")
File Size:   #{file_size}
Format:      #{format} (Expected "WAVE")
Sample Rate: #{sample_rate}
Data Size:   #{data_size}
Actual File Size: #{byte_size(binary)}
-------------------------
""")

# Check if the math adds up
if file_size == data_size + 36 do
  IO.puts("✅ Header Math is Correct")
else
  IO.puts("❌ Header Math is WRONG. QuickTime will reject this.")
  IO.puts("Expected File Size to be: #{data_size + 36}")
end
