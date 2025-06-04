#!/bin/bash

# Set output file name
OUTPUT="doommod.pk3"

# Build the PK3
echo "Building $OUTPUT..."
zip -r "$OUTPUT" zscript/ actors/ sounds/ sprites/ maps/ zscript.txt decorate.txt > /dev/null

# Check for errors
if [ $? -ne 0 ]; then
    echo "❌ Failed to build $OUTPUT"
    exit 1
fi

echo "✅ Build complete: $OUTPUT"

# Launch GZDoom with the WAD and PK3
echo "Launching GZDoom..."
gzdoom -iwad doom.wad -file "$OUTPUT"

