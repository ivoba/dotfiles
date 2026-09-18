# Commit Skill

This skill enforces Gitmoji-style commit messages and commits changes without pushing. It ensures that commit messages are brief, concise, and follow the Gitmoji convention. If no commit message is provided, the skill will infer one using `git status` and `git diff`.

## Installation
To use this skill, ensure it is placed in the appropriate skills directory for your Pi agent. The skill will automatically be loaded when the agent starts.

## Usage
When you request to commit changes, the skill will guide you to provide a Gitmoji-style commit message. If no message is provided, it will infer one based on the changes detected in `git status` and `git diff`.

## Features
- Enforces Gitmoji-style commit messages
- Ensures commit messages are one-liners
- Validates commit message format before committing
- Only commits changes; does not push
- Asks the user which files to commit if it is unclear
- Infers commit message if none is provided

## Dependencies
- Git
- Gitmoji knowledge (assumed to be known by the LLM)

## Notes
- The skill does not include a mapping table for Gitmoji. It assumes the LLM knows about Gitmoji.
- The commit message should be brief and concise.
- The skill only commits changes and does not push them.
- If it is unclear which files should be included, the skill will ask the user to specify.
- If no commit message is provided, the skill will infer one using `git status` and `git diff`.