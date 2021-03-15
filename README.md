# Zig Embedded Group - Website and Articles

This project both contains the contents and the generation of the ZEG website.

## Folder Structure

```
.
├── build.zig
├── deps                  Contains submodule dependencies
│   └── …
├── LICENCE
├── README.md
├── render                Not included in the repo, will contain the rendered website
│   └── …
├── src                   Source of the website generator and other tools
│   └── main.zig
└── website               Contains the raw input data for the website
    ├── articles          Contains all articles in the format `YYYY-MM-dd - ${TITLE}.md`
    │   └── …
    ├── img               Contains the images used on the website.
    │   └── …
    ├── index.md          Index page of the website
    └── tutorials         Contains the raw tutorial files
        └── … 
```

## Markdown

The website uses basic markdown that allows GFM style tables and also supports *some* placeholders:

- `<!-- TOC -->` will insert a table of contents if alone in a single line. The ToC will be rendered in the same depth as the next heading, so everything higher in the hierarchy will be ignored.
- `<!-- ARTICLES -->` renders a list of all available articles
- `<!-- ARTICLES10 -->` renders a list of the 10 latest articles
