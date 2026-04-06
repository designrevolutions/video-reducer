# Video Optimiser (FFmpeg Wrapper)

A simple Bash script to reduce the file size of videos using FFmpeg, while maintaining good visual quality.

---

## Quick Start (Run the Script)

```bash
chmod +x optimise_video.sh
./optimise_video.sh input.mp4
```

Or with a custom output file:

```bash
./optimise_video.sh input.mp4 output.mp4
```

---

## Installation

### Install FFmpeg

#### Ubuntu / Debian

```bash
sudo apt update
sudo apt install ffmpeg
```

#### Verify installation

```bash
ffmpeg -version
```

---

## What this script does

* Re-encodes video using **H.264 (libx264)**
* Reduces file size using **CRF-based compression**
* Re-encodes audio to **AAC**
* Outputs a smaller, widely compatible file

---

## Key Settings (inside the script)

You can tweak these at the top of the script:

```bash
CRF=23
PRESET="medium"
AUDIO_BITRATE="128k"
```

---

## Understanding CRF (Quality Setting)

CRF controls video quality and file size.

| CRF | Quality               | File Size    |
| --- | --------------------- | ------------ |
| 18  | Very high             | Large        |
| 23  | Default (recommended) | Balanced     |
| 28  | Lower quality         | Smaller      |
| 30+ | Noticeably worse      | Much smaller |

Lower CRF = better quality but larger file.

---

## Understanding Presets

Preset controls encoding speed vs compression efficiency.

| Preset    | Speed     | File Size |
| --------- | --------- | --------- |
| ultrafast | Very fast | Large     |
| fast      | Fast      | Larger    |
| medium    | Balanced  | Balanced  |
| slow      | Slower    | Smaller   |
| veryslow  | Very slow | Smallest  |

Important:

* Slower preset = better compression (smaller file)
* Quality stays roughly the same, but encoding takes longer

---

## Recommended Settings

### General use (default)

```bash
CRF=23
PRESET="medium"
```

---

### Smaller files

```bash
CRF=26
PRESET="slow"
```

---

### Higher quality

```bash
CRF=18
PRESET="slow"
```

---

## Output Naming

If no output filename is provided:

```
input.mp4 → input_optimised.mp4
```

---

## Notes

* This uses lossy compression
  Re-encoding multiple times will reduce quality

* Best practice:

  * Keep original files if important
  * Compress once only

---

## Possible Improvements

* Add batch processing for folders
* Add quality presets (`--high`, `--low`)
* Add support for H.265 (better compression, slower)
* Add resolution scaling (e.g. 1080p → 720p)

---

## Summary

This script is designed for:

* Quickly reducing video file sizes
* Simple one-command usage
* Good balance between quality and compression

Ideal for backups, sharing, or storage optimisation.