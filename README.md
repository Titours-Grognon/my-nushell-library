# 🎉 **MY-NUSHELL-LIBRARY** 🎉

- [🎉 **MY-NUSHELL-LIBRARY** 🎉](#-my-nushell-library-)
  - [Objectifs 🚩](#objectifs-)
  - [Script de base `minimal.nu`](#script-de-base-minimalnu)
  - [Librairies](#librairies)
    - [`output-script.nu`](#output-scriptnu)
    - [`external-command.nu`](#external-commandnu)
    - [`get-settings.nu`](#get-settingsnu)

## Objectifs 🚩

- base d'exécution d'un script *Nushell*
- ensemble de « librairies » associé

## Script de base `minimal.nu`

Script de base pouvant s'adapter à deux modes de fonctionnenment :

- mode « développement » / usage local

  Le script d'exécution, son fichier de configuration et ses librairies sont localisés dans la même arborescence

  ```txt
  .
  ├── script-name.nu
  ├── nu_modules
  │  ├── module-<aaa>.nu
  │  ├── [...]
  │  └── module-<zzz>.nu
  └── settings.toml
  ```

- mode « production » / usage global

  Le script d'exécution, son fichier de configuration et ses librairies sont répartis dans l'arborescence `/usr/local`.  

  ```txt
  /usr/local
  ├── bin
  │  └── script-name.nu
  ├── etc
  │  └── script-name
  │     └── settings.toml
  └── lib
     └── script-name
        ├── module-<aaa>.nu
        ├── [...]
        └── module-<zzz>.nu
  ```

## Librairies

### `output-script.nu`

Librairie permettant de gérer l'affichage dans les scripts.

1. `__display-message`

    ```txt
    Generate a message with or without timestamp to display or log 

    Usage:
      > __display-message {flags} <msg> 

    Flags:
      --level <string>: Message level : alert, debug, error, info, successful_script, successful_step
      --log: Add timestamp
      -h, --help: Display the help message for this command

    Parameters:
      msg <string>: Message to display

    Input/output types:
      ╭───┬───────┬────────╮
      │ # │ input │ output │
      ├───┼───────┼────────┤
      │ 0 │ any   │ any    │
      ╰───┴───────┴────────╯
    ```

1. `__display-horizontal-rule

    ```txt
    Generate a horizontal rule

    Usage:
      > __display-horizontal-rule {flags} (separator_character) 

    Flags:
      --bg <string>: Background color (default: 'bg_k')
      --fg <string>: Foreground color (default: 'lmb')
      -h, --help: Display the help message for this command

    Parameters:
      separator_character <string>: Horizontal bar (optional, default: '―')

    Input/output types:
      ╭───┬───────┬────────╮
      │ # │ input │ output │
      ├───┼───────┼────────┤
      │ 0 │ any   │ any    │
      ╰───┴───────┴────────╯
    ```

### `external-command.nu`

Librairie permettant de l'exécution et le retour des commandes externes au shell *Nushell*.

```txt
Run an external command based on a mode :

- analyze     (allows to process data return)
- continue    (allows to continue script execution in case of error)
- debug       (display all information)
- quiet       (no information, except in case of error)
- standard    (display command success or failure)

Usage:
  > __external-command-control {flags} <external_command> 

Flags:
  --mode <string>: Mode option: analyze, continue, debug, quiet or standard (default: 'standard')
  --shell <string>: Command line interpreter (default: 'bash')
  -h, --help: Display the help message for this command

Parameters:
  external_command <string>: Command to execute

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```

### `get-settings.nu`

Librairie permettant de charger une partie ou l'ensemble d'un fichier de configuration au format TOML.

```txt
Get parameters from a toml file

Usage:
  > __get-settings {flags} (table) 

Flags:
  --settings_file <path>: Configuration file in TOML format (default: '')
  -h, --help: Display the help message for this command

Parameters:
  table <string>: Extract collection of key/value pairs (optional)

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ any    │
  ╰───┴───────┴────────╯
```
