#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "unknown"')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
EFFORT=$(echo "$input" | jq -r '.effort.level // "—"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

COST_FMT=$(printf '$%.4f' "$COST")

# Context bar (10 blocks)
FILLED=$((PCT / 10))
EMPTY=$((10 - FILLED))
BAR=$(printf '%0.s█' $(seq 1 $FILLED 2>/dev/null))$(printf '%0.s░' $(seq 1 $EMPTY 2>/dev/null))

echo "$MODEL | effort:$EFFORT | ctx:$BAR${PCT}% | $COST_FMT"

