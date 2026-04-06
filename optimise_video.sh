#!/usr/bin/env bash

# Exit on error, undefined vars, and pipeline failures
set -euo pipefail

############################################
# CONFIG (you can tweak these)
############################################

CRF=23              # Lower = better quality, bigger file
PRESET="medium"     # ultrafast → veryslow
AUDIO_BITRATE="128k"

############################################
# ARGUMENT CHECK
############################################

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]
then
    echo "Usage: $0 <input_video> [output_video]"
    exit 1
fi

INPUT_FILE="$1"

# Check input exists
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
    # Auto-generate output name
    filename=$(basename -- "$INPUT_FILE")
    extension="${filename##*.}"
    name="${filename%.*}"

    OUTPUT_FILE="${name}_optimised.${extension}"
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