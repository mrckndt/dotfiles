#!/bin/bash
input=$(cat)
IFS=$'\t' read -r MODEL EFFORT VIM COST CTX_SIZE PCT TOK_IN TOK_OUT CACHE_R CACHE_W CACHE_IN < <(
  echo "$input" | jq -r '[
    (.model.display_name // "unknown"),
    (.effort.level // "-"),
    (.vim.mode // "-"),
    (.cost.total_cost_usd // 0),
    (.context_window.context_window_size // 0),
    (.context_window.used_percentage // 0 | floor),
    (.context_window.total_input_tokens // 0),
    (.context_window.total_output_tokens // 0),
    (.context_window.current_usage.cache_read_input_tokens // 0),
    (.context_window.current_usage.cache_creation_input_tokens // 0),
    (.context_window.current_usage.input_tokens // 0)
  ] | @tsv'
)
BOLD='\033[1m'; FG='\033[22m\033[37m'; RESET='\033[0m'
fmt_tokens() {
  awk -v n="$1" 'BEGIN{
    if (n >= 1000000) printf "%.1fM", n/1000000;
    else if (n >= 1000) printf "%.1fk", n/1000;
    else printf "%d", n;
  }'
}
# Cache hit rate: cache reads / all input tokens of the last API call (same basis as used_percentage)
HIT=$(awk -v r="$CACHE_R" -v w="$CACHE_W" -v i="$CACHE_IN" 'BEGIN{
  t = r + w + i;
  if (t > 0) printf "%d%%", (r * 100 / t) + 0.5; else printf "-";
}')
VIM_FMT=""
[ "$VIM" != "-" ] && [ "$VIM" != "NORMAL" ] && VIM_FMT="${BOLD}-- ${VIM} --${RESET} | "
printf '%b\n' "${VIM_FMT}${FG}${MODEL}${RESET} | ${FG}${EFFORT}${RESET} | ctx: $(fmt_tokens "$TOK_IN") / $(fmt_tokens "$CTX_SIZE") (${PCT}%) | tok: $(fmt_tokens "$TOK_IN") in / $(fmt_tokens "$TOK_OUT") out | hit: ${FG}${HIT}${RESET} | ${FG}$(printf '$%.2f' "$COST")${RESET}"

