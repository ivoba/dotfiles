---
name: yazi-plugin-manager
description: Use the ya package manager for Yazi plugin installs. Prefer ya pkg add over manual installs.
---

# Yazi Plugin Manager

Always use the `ya` package manager for Yazi plugin installs. The `ya pkg` subcommand is the recommended way to manage plugins and flavors.

## Installation

To install a Yazi plugin using `ya`, use the following command:

```bash
ya pkg add owner/my-plugin
```

## Examples

- Install a plugin from GitHub:
  ```bash
  ya pkg add owner/my-plugin
  ```

- Remove a plugin:
  ```bash
  ya pkg remove owner/my-plugin
  ```

## Workflow

1. **Check if the plugin is available via `ya`**: Always attempt to use `ya pkg add` first.
2. **Fallback to manual install**: If the plugin is not available via `ya`, proceed with manual installation.

## References

- [Yazi Documentation](https://yazi-rs.github.io/docs/plugins/)
- [ya pkg subcommand](https://yazi-rs.github.io/docs/plugins/#package-manager)
