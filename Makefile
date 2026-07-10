ROOT_DIR = .
METHOD_BASIC = basic
METHOD_LOCAL = local
METHOD_GLOBAL = global

.PHONY: default check-query all generate index query-basic query-local query-global clean help

default: help

check-query:
ifndef QUERY
	@echo "❌  Error: You must supply a QUERY string."
	@echo "👉  Example: make query-local QUERY=\"your question here\""
	@exit 1
endif

# Run the complete pipeline sequentially
all: clean generate index
	@echo "✅  Setup complete. Ready to query. Run: make query-local QUERY=\"your question\""

# Generate dataset
generate:
	@echo "🚀  Generating dataset..."
	uv run generate_dataset.py

# Run GraphRAG indexation
index:
	@echo "🚀  Running GraphRAG indexation..."
	uv run graphrag index --root $(ROOT_DIR)

# Run query using Standard RAG (BASIC mode)
query-basic: check-query
	@echo "🔍  Running Standard RAG (BASIC) search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_BASIC) "$(QUERY)"

# Run query using GraphRAG (LOCAL search mode)
query-local: check-query
	@echo "🔍  Running GraphRAG LOCAL search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_LOCAL) "$(QUERY)"

# Run query using GraphRAG (GLOBAL search mode)
query-global: check-query
	@echo "🔍  Running GraphRAG GLOBAL search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_GLOBAL) "$(QUERY)"

# Clean up all GraphRAG artifacts
clean:
	@echo "🧹  Cleaning up GraphRAG output/, logs/, and cache/ folders..."
	rm -rf $(ROOT_DIR)/output $(ROOT_DIR)/logs $(ROOT_DIR)/cache

# Help menu to show available commands
help:
	@echo "GraphRAG PoC Testing CLI"
	@echo "Available commands:"
	@echo "  make              - Shows this help menu (default)"
	@echo "  make all          - Deletes current indexation, generates dataset and re-runs indexation"
	@echo "  make generate     - Generates dataset"
	@echo "  make index        - Runs indexation"
	@echo "  make clean        - Deletes current indexation (output/, logs/, and cache/ folders)"
	@echo "Query Commands"
	@echo "  make query-basic  QUERY=\"your question here\""
	@echo "  make query-local  QUERY=\"your question here\""
	@echo "  make query-global QUERY=\"your question here\""
