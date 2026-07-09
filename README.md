# Graph RAG PoC

## Pre-requisites

```shell
uv sync
```

### Only once

```shell
uv run graphrag init
```

A size of 150 with an overlap of 30 is perfect for our small dataset. It forces the system to chop each scene into its own distinct, isolated chunk. This creates the structural "gaps" that Standard RAG will struggle to jump across, allowing GraphRAG to prove its worth.

```yaml
chunking:
  type: tokens
  size: 150
  overlap: 30
  encoding_model: o200k_base
```

```shell
make help
```
