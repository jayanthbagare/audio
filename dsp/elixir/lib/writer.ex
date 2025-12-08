defmodule Write do
  @sample_rate 44100
	def save_wav(filename, data) do
    # Calculate File Size
    data_size = byte_size(data)
    total_size = data_size + 36

    header = <<
      # ChunkID
      "RIFF",
      # ChunkSize
      total_size::little-32,
      # Format 
      "WAVE",
      # Subchunk1ID
      "fmt ",
      # SubChunk1size(16 for PCM)
      16::little-32,
      # Audio Format 
      1::little-16,
      # Number of Channels 
      1::little-16,
      # sample rate
      @sample_rate::little-32,
      # ByteRate(SampleRate * Channels * Bitspersample=> channel is mono here)
      @sample_rate * 2::little-32,
      2::little-16,
      16::little-16,
      "data",
      data_size::little-32
    >>

    full_file = header <> data
    File.write!(filename, full_file)
    IO.puts("Saved to file #{filename}")
  end

end