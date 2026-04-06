#!/usr/bin/env bash

# Enable strict mode:
# - exit on error
# - fail on undefined variables
# - catch pipeline errors
set -euo pipefail

############################################
# CONFIGURATION
############################################

CRF=23
PRESET="medium"
AUDIO_BITRATE="128k"

############################################
# HELP FUNCTION
############################################

show_help()
{
    echo "Video Optimiser (FFmpeg Wrapper)"
    echo
    echo "Usage:"
    echo "  optimise_video.sh <input_video> [output_video]"
    echo
    echo "Description:"
    echo "  Compress a video using FFmpeg while keeping good quality."
    echo
    echo "Examples:"
    echo "  optimise_video.sh input.mp4"
    echo "  optimise_video.sh input.mp4 output.mp4"
    echo
    echo "Notes:"
    echo "  - Output defaults to: <name>_optimised.<ext>"
    echo "  - Saved in same directory as input file"
}

############################################
# ARGUMENT CHECK
############################################

# Show help if requested
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]
then
    show_help
    exit 0
fi

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]
then
    echo "Error: invalid arguments"
    echo "Use --help for usage."
    exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]
then
    echo "Error: input file does not exist: $INPUT_FILE"
    exit 1
fi

############################################
# OUTPUT FILE HANDLING
############################################

if [ "$#" -eq 2 ]
then
    OUTPUT_FILE="$2"
else
    input_directory=$(dirname -- "$INPUT_FILE")
    filename=$(basename -- "$INPUT_FILE")
    extension="${filename##*.}"
    name="${filename%.*}"

    OUTPUT_FILE="${input_directory}/${name}_optimised.${extension}"
fi

############################################
# RUN FFMPEG
############################################

echo "Input:  $INPUT_FILE"
echo "Output: $OUTPUT_FILE"
echo "CRF:    $CRF"
echo "Preset: $PRESET"
echo

ffmpeg -i "$INPUT_FILE" \
    -c:v libx264 \
    -crf "$CRF" \
    -preset "$PRESET" \
    -c:a aac \
    -b:a "$AUDIO_BITRATE" \
    "$OUTPUT_FILE"

echo
echo "Done. Optimised video saved as:"
echo "  $OUTPUT_FILE"