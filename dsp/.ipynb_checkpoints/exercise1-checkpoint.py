import numpy as np
import struct


def main():
    filename = "exercise1.wav"
    duration = 1.0
    samplerate = 44100
    freqency = 440
    amplitude = np.iinfo(np.int16).max
    n_samples = int(duration * samplerate)
    data = []
    for i in range(n_samples):
        sample = amplitude * np.sin(2 * np.pi * freqency * (i / samplerate))
        data.append(int(sample))
    write_wav(filename, data, 2, samplerate, 16, duration)


def write_wav(
    filename, audiodata, nchannels=2, samplerate=44100, bitspersample=16, duration=1.0
):
    samplewidth = bitspersample / 8
    chunkid = b"RIFF"
    subchunk1size = int(int(samplerate * duration) * nchannels * samplewidth)
    chunksize = int(36 + subchunk1size)
    format = b"WAVE"
    subchunk1id = b"fmt "
    audioformat = 1
    byterate = int(samplerate * nchannels * samplewidth)
    blockalign = int(nchannels * samplewidth)
    subchunk2id = b"data"
    subchunk2size = int(int(samplerate * duration) * nchannels * samplewidth)

    header = b""
    header += struct.pack("<4s", chunkid)
    header += struct.pack("<I", chunksize)
    header += struct.pack("<4s", format)
    header += struct.pack("<4s", subchunk1id)
    header += struct.pack("<I", subchunk1size)
    header += struct.pack("<H", audioformat)
    header += struct.pack("<H", nchannels)
    header += struct.pack("<I", samplerate)
    header += struct.pack("<I", byterate)
    header += struct.pack("<H", blockalign)
    header += struct.pack("<H", bitspersample)
    header += struct.pack("<4s", subchunk2id)
    header += struct.pack("<I", subchunk2size)

    with open(filename, "wb") as fh:
        # Write WAV File Header
        audioframes = b""
        for sample in audiodata:
            audioframes += struct.pack("<h", sample)
        fh.write(header)
        fh.write(audioframes)
        fh.close


if __name__ == "__main__":
    main()
