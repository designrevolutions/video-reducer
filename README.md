# Video Optimiser (FFmpeg Wrapper)

A simple Bash CLI tool to reduce the file size of videos using FFmpeg, while maintaining good visual quality.

---

## Quick Start

Run the script on a video:

```bash
optimise_video.sh input.mp4
```

The optimised file will be saved **in the same folder as the input file**:

```
input.mp4 → input_optimised.mp4
```

You can also specify an output file:

```bash
optimise_video.sh input.mp4 output.mp4
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

Copy the script into your personal bin:

```bash
cp optimise_video.sh ~/.local/bin/optimise_video.sh
chmod +x ~/.local/bin/optimise_video.sh
```

---

### Optional: Copy and make executable in one command

You can combine both steps:

```bash
cp optimise_video.sh ~/.local/bin/optimise_video.sh && \
chmod +x ~/.local/bin/optimise_video.sh
```

This uses:

* `cp` → copies the script
* `chmod +x` → makes it executable
* `&&` → only runs the second command if the first succeeds

---

### 3. Add to PATH (important)

Your system needs to know where to find your script.

Check your current PATH:

```bash
echo $PATH
```

If you do not see something like:

```
/home/your-user/.local/bin
```

then you need to add it.

---

#### Safe way to add it (recommended)

```bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc || \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

This ensures the line is only added once.

---

### 4. Apply the change (important)

After modifying `.bashrc`, you must reload it:

```bash
source ~/.bashrc
```

Alternatively, open a new terminal.

---

### 5. Verify installation

```bash
which optimise_video.sh
```

Expected output:

```
/home/your-user/.local/bin/optimise_video.sh
```

You can also test:

```bash
optimise_video.sh --help
```

---

## Understanding PATH (important)

`PATH` is an environment variable that tells Linux where to look when you run a command.

For example:

```bash
optimise_video.sh input.mp4
```

Linux searches through each directory listed in `PATH` to find the executable.

---

### Why we use `~/.local/bin`

This is the standard location for user-installed scripts.

Benefits:

* No need for `sudo`
* Keeps personal tools separate from system tools
* Allows you to run commands from anywhere

---

## Avoiding duplicate PATH entries

If you run this command multiple times:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

you may end up with duplicate entries in your PATH.

Example:

```
/home/user/.local/bin:/home/user/.local/bin:/home/user/.local/bin:...
```

This is not ideal and can cause confusion later.

---

### Check for duplicates

```bash
grep local/bin ~/.bashrc
```

---

### Better approach (runtime-safe)

Instead of blindly adding the line, you can use:

```bash
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]
then
    export PATH="$HOME/.local/bin:$PATH"
fi
```

This checks if the path already exists before adding it.

---

### Why the `":$PATH:"` trick works

Wrapping PATH with colons ensures exact matching.

Without it, partial matches could cause incorrect behaviour.

---

## Alternative Install (system-wide)

If you prefer a system-wide install:

```bash
sudo cp optimise_video.sh /usr/local/bin/optimise_video.sh
sudo chmod +x /usr/local/bin/optimise_video.sh
```

No PATH changes required.

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

It is also a useful exercise in understanding:

* how Linux finds commands
* how environment variables like PATH work
* how to safely modify shell configuration
* how to build small but practical CLI tools