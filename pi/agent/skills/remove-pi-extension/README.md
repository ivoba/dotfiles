# Remove Pi Extension Skill

This skill helps users remove Pi extensions properly using the `pi remove` command with the correct package name format.

## Installation

To install this skill, use the following command:

```bash
pi install /home/ivoba/.pi/agent/skills/remove-pi-extension
```

## Usage

1. List installed extensions:
   ```bash
   pi list
   ```

2. Identify the correct package name from the output (e.g., `npm:pi-generate-commit-message`).

3. Remove the extension:
   ```bash
   pi remove npm:<package-name>
   ```

4. Verify removal:
   ```bash
   pi list
   ```

## Example

To remove the `pi-generate-commit-message` extension:

```bash
pi remove npm:pi-generate-commit-message
```

## Key Learnings

- The `pi remove` command expects the package name in the format it appears in the `pi list` output, which includes the `npm:` prefix for npm packages.
- Always verify removal by running `pi list` to ensure the extension no longer appears.
- Some extensions may leave behind data in `~/.pi/agent/data/<extension-name>`. This can be manually deleted if needed.
