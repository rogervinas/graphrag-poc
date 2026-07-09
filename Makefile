# Define variables for easy configuration
ROOT_DIR = .
METHOD_BASIC = basic
METHOD_LOCAL = local
METHOD_GLOBAL = global

.PHONY: default all index query-basic query-local query-global clean help check-query

# The first target in a Makefile is the default. We explicitly point it to 'help'.
default: help

# Internal macro to ensure the user actually passed a QUERY="some text" string
check-query:
ifndef QUERY
	@echo "❌  Error: You must supply a QUERY string."
	@echo "👉  Example: make query-local QUERY=\"your question here\""
	@exit 1
endif

# Run the complete pipeline sequentially (Wipes logs/cache, builds fresh graph index)
all: clean index
	@echo "✅  Setup complete. Ready to query. Run: make query-local QUERY=\"your question\""

# Run the GraphRAG indexation pipeline
index:
	@echo "🚀  Starting GraphRAG indexation using uv..."
	uv run graphrag index --root $(ROOT_DIR)

# Run the query using Standard RAG (BASIC mode)
query-basic: check-query
	@echo "🔍  Running Standard RAG (BASIC) search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_BASIC) "$(QUERY)"

# Run the query using GraphRAG (LOCAL search mode)
query-local: check-query
	@echo "🔍  Running GraphRAG LOCAL search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_LOCAL) "$(QUERY)"

# Run the query using GraphRAG (GLOBAL search mode)
query-global: check-query
	@echo "🔍  Running GraphRAG GLOBAL search query..."
	uv run graphrag query --root $(ROOT_DIR) --method $(METHOD_GLOBAL) "$(QUERY)"

# Clean up all GraphRAG artifacts (cache, logs, output)
clean:
	@echo "🧹  Cleaning up GraphRAG cache, logs, and output folders..."
	rm -rf $(ROOT_DIR)/output $(ROOT_DIR)/logs $(ROOT_DIR)/cache

# Help menu to show available commands
help:
	@echo "GraphRAG PoC Testing CLI"
	@echo "Available commands:"
	@echo "  make              - Shows this help menu (default)"
	@echo "  make all          - Cleans old workspace environments and indexes everything"
	@echo "  make index        - Runs the indexation pipeline only"
	@echo "  make clean        - Deletes output/, logs/, and .graphrag/ cache folders"
	@echo "Query Commands (Requires QUERY=\"...\")"
	@echo "  make query-basic  QUERY=\"your question here\""
	@echo "  make query-local  QUERY=\"your question here\""
	@echo "  make query-global QUERY=\"your question here\""