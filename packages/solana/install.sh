# solana.sh

dependencies() {
  echo "claude"
}

post_install() {
  source <(mise activate bash)
  claude mcp add --transport http solana-mcp-server https://mcp.solana.com/mcp
}
