---
name: make-zettelkasten-note
description: Create a markdown note for the zettelkasten. Use when the user wants to create a new note in their zettelkasten.
---

# Make Zettelkasten Note

Create a concise markdown note for the zettelkasten. Notes are saved in the `@kDrive/zettelkasten/00_inbox` folder by default.

## Note Structure
Notes follow this structure:
- YAML frontmatter with title and optional tags
- Brief and concise content

## Usage
When the user requests to create a zettelkasten note, follow these steps:
1. Ask for the note title and content.
2. Create a markdown file with the specified title in `~/kDrive/zettelkasten/00_inbox`.
3. Use YAML frontmatter for the title and any tags.
4. Ensure the note content is brief and concise.

## Example
For a note titled "My Note" with content "This is a brief note.", create the following file:

```markdown
---
title: My Note
tags: []
---

This is a brief note.
```

Save it as `My Note.md` in `~/kDrive/zettelkasten/00_inbox`.
