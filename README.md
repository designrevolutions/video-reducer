# Video Optimiser (FFmpeg Wrapper)

A simple Bash CLI tool to reduce the file size of videos using FFmpeg, while maintaining good visual quality.

---

## Quick Start

Run the script on a video:

```bash
video-optimise input.mp4
```

The optimised file will be saved **in the same folder as the input file**:

```
input.mp4 → input_optimised.mp4
```

You can also specify an output file:

```bash
video-optimise input.mp4 output.mp4
```

---

## Installation

### 1. Install FFmpeg

This script requires FFmpeg.

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

### 2. Install the script (recommended method)

Create a personal bin directory (if it does not exist):

```bash
mkdir -p ~/.local/bin
```

Copy the script:

```bash
cp optimise_video.sh ~/.local/bin/video-optimise
chmod +x ~/.local/bin/video-optimise
```

---

### 3. Add to PATH (important)

Your system needs to know where to find the script.

Check your PATH:

```bash
echo $PATH
```

If you do not see:

```
/home/your-user/.local/bin
```

then add it:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

## Understanding PATH (important)

`PATH` is a list of directories your system searches when you run a command.

Example:

```bash
video-optimise input.mp4
```

Linux looks through each directory in `PATH` to find `video-optimise`.

---

### Why we add `~/.local/bin`

This allows you to:

* run your script from anywhere
* avoid using full file paths
* keep personal tools separate from system tools

---

## Avoiding duplicate PATH entries

If you run this command multiple times:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

you may accidentally add duplicate lines to `.bashrc`.

This can result in PATH looking like:

```
/home/user/.local/bin:/home/user/.local/bin:/home/user/.local/bin:...
```

---

### Check for duplicates

```bash
grep local/bin ~/.bashrc
```

---

### Safe way to add PATH (recommended)

```bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

---

### Even better (runtime-safe approach)

Add this instead:

```bash
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]
then
    export PATH="$HOME/.local/bin:$PATH"
fi
```

This ensures the path is only added once.

---

## Alternative Install (system-wide)

You can install globally using:

```bash
sudo cp optimise_video.sh /usr/local/bin/video-optimise
sudo chmod +x /usr/local/bin/video-optimise
```

No PATH changes needed.

---

## What this script does

* Re-encodes video using **H.264 (libx264)**
* Reduces file size using **CRF-based compression**
* Re-encodes audio to **AAC**
* Saves output next to the original file by default

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

## Notes

* This uses lossy compression
* Re-encoding multiple times reduces quality

Best practice:

* Keep original files if important
* Compress once only

---

## Summary

This tool is designed for one job:

Quickly reduce video file size with a single command, while keeping a good balance between quality and compression.