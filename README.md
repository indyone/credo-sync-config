# Credo Configuration Sync

Adds a mix task for synchronizing the Credo configuration from a URL.

## Usage

* Add a dependency for the `credo_sync_config` app in your mix project.
* Run the command `mix credo.sync.config <url>` where `<url>` is the URL for
  downloading the Credo configuration.
* If the project has already a Credo configuration which was previously synced
  with this task, then you can update it with the command `mix credo.sync.config`

## Notes

* URL option currently supports `http://` and `https://` protocols only.
