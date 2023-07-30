# Vim - Pangea

Use [Pangea cloud](https://pangea.cloud) services within your vim editor.

Currently, only our redact service is available.

## Installation

For [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'MichaelCombs28/vim-pangea'
```

Then run `:PlugInstall`.

For native packages:

```bash

# If you don't have the directory already setup
mkdir -p ~/.vim/pack/<something>/start/

git clone https://github.com/MichaelCombs28/vim-pangea.git
mv vim-pangea ~/.vim/pack/<something>/start/
```


## Usage

The `:Redact` command takes your current buffer and runs it through Pangea's redact service,
replacing the existing buffer with the resulting redactions.

## Roadmap

- Detection only - Redact service will be used to detect PII or other sensitive information within a
  buffer and highlight it instead of redacting it.
- Other services
