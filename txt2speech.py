# /// script
# requires-python = ">=3.9"
# dependencies = [
#     "kokoro",
#     "soundfile",
#     "torch",
#     "numpy",
#     "pip",
# ]
# ///
#
# uv run txt2speech.py /tmp/x.txt

import argparse
import sys
from pathlib import Path
import soundfile as sf
import torch
import numpy as np

# Try to import KPipeline; handle potential missing system dependencies gracefully
try:
    from kokoro import KPipeline
except OSError as e:
    print(f"Error importing kokoro: {e}")
    print("Note: 'kokoro' often requires 'espeak-ng' to be installed on your system.")
    print("  macOS: brew install espeak")
    print("  Linux: sudo apt-get install espeak-ng")
    sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Generate audio from text using Kokoro TTS.")
    parser.add_argument("input_file", type=Path, help="Path to the input text file.")
    parser.add_argument("--lang", default="a", help="Language code (default: 'a' for American English).")
    parser.add_argument("--voice", default="af_heart", help="Voice ID (default: 'af_heart').")

    args = parser.parse_args()

    if not args.input_file.exists():
        print(f"Error: File '{args.input_file}' not found.")
        sys.exit(1)

    print(f"Reading text from {args.input_file}...")
    try:
        text = args.input_file.read_text(encoding="utf-8")
    except Exception as e:
        print(f"Error reading file: {e}")
        sys.exit(1)

    if not text.strip():
        print("Error: Input file is empty.")
        sys.exit(1)

    print(f"Initializing Kokoro pipeline (lang={args.lang})...")
    try:
        pipeline = KPipeline(lang_code=args.lang)
    except Exception as e:
        print(f"Failed to initialize pipeline: {e}")
        sys.exit(1)

    print(f"Generating audio with voice '{args.voice}'...")
    generator = pipeline(text, voice=args.voice, speed=1)

    all_audio_segments = []

    # Process the generator
    for _, _, audio in generator:
        all_audio_segments.append(audio)

    if not all_audio_segments:
        print("No audio generated.")
        return

    # Concatenate all segments
    # Kokoro returns numpy arrays or tensors depending on version/context, usually simple numpy arrays in the generator
    # but the example used torch.cat, implying tensors might be involved or expected.
    # We'll ensure everything is a tensor for concatenation, then convert back to numpy for soundfile.

    try:
        # Convert all to tensors to ensure consistency before cat
        tensors = [torch.tensor(seg) if not isinstance(seg, torch.Tensor) else seg for seg in all_audio_segments]
        final_audio = torch.cat(tensors).numpy()
    except Exception as e:
        print(f"Error processing audio segments: {e}")
        sys.exit(1)

    output_file = args.input_file.with_suffix(".wav")

    print(f"Saving to {output_file}...")
    sf.write(output_file, final_audio, 24000)
    print("Done!")

if __name__ == "__main__":
    main()
