#!/usr/bin/env bash
set -e

CONTENT_DIR="content"
POSTS_DIR="$CONTENT_DIR/posts"
INCLUDE_DIR="include"
PUBLIC_DIR="public"

HEADER="$INCLUDE_DIR/header.html"
FOOTER="$INCLUDE_DIR/footer.html"
IMG_DIR="$INCLUDE_DIR/img"

mkdir -p "$PUBLIC_DIR"

# Copy static assets
rm -rf "$PUBLIC_DIR/img"
cp -r "$IMG_DIR" "$PUBLIC_DIR/"
cp "$INCLUDE_DIR/style.css" "$PUBLIC_DIR/"

# Temporary file for homepage post list
HOMEPAGE_LIST=$(mktemp)

echo "Building posts..."
for FILE in "$POSTS_DIR"/*.md; do
    [ -e "$FILE" ] || continue

    # Extract metadata from top comment block
    TITLE=$(sed -n 's/^title:[[:space:]]*//p' "$FILE")
    DATE=$(sed -n 's/^date:[[:space:]]*//p' "$FILE")

    BASENAME=$(basename "$FILE" .md)
    OUTFILE="$PUBLIC_DIR/$BASENAME.html"

    echo " -> $FILE -> $OUTFILE"

    # Convert markdown to HTML
    cmark "$FILE" > /tmp/post_body.html
    cat "$HEADER" /tmp/post_body.html "$FOOTER" > "$OUTFILE"

    # Append to homepage list
    echo "<li><span class='post-date'>$DATE</span> - <a href='$BASENAME.html'>$TITLE</a></li>" >> "$HOMEPAGE_LIST"
done

# Sort posts by date descending
HOMEPAGE_CONTENT=$(sort -r "$HOMEPAGE_LIST")

# Generate index.html
cat "$HEADER" > "$PUBLIC_DIR/index.html"
echo "<h1>Blog</h1><ul>$HOMEPAGE_CONTENT</ul>" >> "$PUBLIC_DIR/index.html"
cat "$FOOTER" >> "$PUBLIC_DIR/index.html"

rm "$HOMEPAGE_LIST"
rm -f /tmp/post_body.html

echo "Building other pages..."
for FILE in "$CONTENT_DIR"/*.md; do
    [ -e "$FILE" ] || continue
    BASENAME=$(basename "$FILE" .md)
    # Skip posts
    [ "$BASENAME" == "posts" ] && continue
    # Skip index.md if you want to use generated index.html
    [ "$BASENAME" == "index" ] && continue

    OUTFILE="$PUBLIC_DIR/$BASENAME.html"
    cmark "$FILE" > /tmp/page_body.html
    cat "$HEADER" /tmp/page_body.html "$FOOTER" > "$OUTFILE"
done
rm -f /tmp/page_body.html

echo "Done! All pages are in $PUBLIC_DIR/"
