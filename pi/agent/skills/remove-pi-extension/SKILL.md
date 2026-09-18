---
name: remove-pi-extension
description: This skill helps users remove Pi extensions properly using the `pi remove` command with the correct package name format.
---

# Remove Pi Extension Skill

This skill helps users remove Pi extensions properly using the `pi remove` command with the correct package name format.

## Steps to Remove an Extension

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

5. (Optional) Manually delete leftover data:
   ```bash
   rm -rf ~/.pi/agent/data/<extension-name>
   ```

## Example

To remove the `pi-generate-commit-message` extension:

```bash
pi remove npm:pi-generate-commit-message
```

## Troubleshooting

- If `pi remove <package-name>` fails, ensure you are using the full package name as shown in `pi list`.
