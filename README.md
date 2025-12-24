# blengine

**blengine** is a super-minimal static site generator designed for small personal blogs.  
It converts Markdown files into simple HTML pages using `cmark` and combines them with a header and footer to produce fast, portable, brutally minimal websites.

The goal of blengine is to make it **as easy as possible to publish a blog** — no frameworks, no JS pipelines, just Unix tools.

---

## Features

- Minimal — just Markdown, HTML, and a build script
- Fast — builds in milliseconds
- Simple file structure
- Front-matter-style metadata for posts (`title`, `date`)
- Auto-generated homepage with post list
- Static output to `/public` (ready to upload anywhere)
- Bring-your-own CSS

---

## Project Structure
.
├── build.sh
├── content
│   └── posts
│       └── test.md
├── include
│   ├── footer.html
│   ├── header.html
│   ├── img
│   │   └── cat.png
│   └── style.css
├── public
│   ├── img
│   │   └── cat.png
│   ├── index.html
│   ├── style.css
│   └── test.html
└── README.md

## Post Metadata Format

Each post includes a small metadata block at the top:

```markdown
<!--
title: My First Post
date: 2025-01-01
-->

Post content starts here...
```
- title — used as the post title + homepage link text
- date — used for sorting + display
- Dates should be in YYYY-MM-DD format.

## Usage

Build the site:
`./build.sh`

The generated HTML files will appear in:
`public/`

## Philosophy

blengine is intentionally boring, predictable, transparent.

You should be able to open any file and immediately understand what it does. If a feature adds complexity, it doesn’t belong here.

## Requirements
- bash

- cmark

- cat, sed / awk

- a POSIX-like environment (Linux, macOS, BSD, etc.)

## Roadmap / Ideas

- optional RSS feed

- nicer index layout helpers

- draft posts mode

- per-post slugs

- pages for posts

- subdirectories

- index page generation

## License
MIT

## Why the name?

Because it’s a blog engine, silly.
