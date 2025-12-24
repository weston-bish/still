#!/usr/bin/env bash

# this ensures that using 'bash build.sh' will still work
set -e

POSTS_DIR="posts"
INCLUDE_DIR="include"
PUBLIC_DIR="public"

HEADER="$INCLUDE_DIR/header.html"
FOOTER="$INCLUDE_DIR/footer.html"
IMG_DIR="$INCLUDE_DIR/img"

# Create public directory
mkdir -p "$PUBLIC_DIR"

# Copy images directory
echo "Copying images..."
rm -rf "$PUBLIC_DIR/img"
cp -r "$IMG_DIR" "$PUBLIC_DIR/"

# Copy styles or other static includes (optional)
if [ -f "$INCLUDE_DIR/style.css" ]; then
    cp "$INCLUDE_DIR/style.css" "$PUBLIC_DIR/"
fi

echo "Building posts..."
for FILE in "$POSTS_DIR"/*.md; do
    [ -e "$FILE" ] || continue

    BASENAME=$(basename "$FILE" .md)
    OUTFILE="$PUBLIC_DIR/$BASENAME.html"

    echo " -> $FILE -> $OUTFILE"

    # Render markdown then wrap with header + footer
    cmark "$FILE" > /tmp/post_body.html
    cat "$HEADER" /tmp/post_body.html "$FOOTER" > "$OUTFILE"
done

rm -f /tmp/post_body.html

echo "Done! HTML output is in '$PUBLIC_DIR/'"

