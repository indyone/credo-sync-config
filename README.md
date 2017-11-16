# Credo Configuration Sync

Adds a **Mix** task for synchronizing the **[Credo](https://github.com/rrrene/credo)** configuration from a URL.

## Installation

To add (or update with a newer version) this task into your **Mix** simply open a terminal and run command:

```
mix archive.install https://github.com/indyone/credo_sync_config/raw/master/archives/credo_sync_config.ez
```

## Usage

* Run the command `mix credo.sync.config [url]` where `[url]` is the URL for downloading the Credo configuration.
* If the project has already a Credo configuration which was previously synced with this task, then you can update it
  with the command `mix credo.sync.config`

## Notes

* URL option currently supports `http://` and `https://` protocols only.
