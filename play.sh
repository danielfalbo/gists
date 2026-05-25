#!/usr/bin/env bash
set -euo pipefail

SIGNAL_URL="${SIGNAL_URL:-http://100.110.199.94:9888/v1/signal}"
POLL_SEC="${POLL_SEC:-1}"
START_TIMEOUT_SEC="${START_TIMEOUT_SEC:-10}"
DIM_DELAY_SEC="${DIM_DELAY_SEC:-6}"

dim_lights() {
  if [[ -n "${DIM_SCRIPT:-}" ]]; then
    "$DIM_SCRIPT"
  else
    curl -sf -X POST "$SIGNAL_URL" \
      -H 'Content-Type: application/json' \
      -d '{"signal":"music_started","payload":{}}' >/dev/null
  fi
}

bright_lights() {
  if [[ -n "${BRIGHT_SCRIPT:-}" ]]; then
    "$BRIGHT_SCRIPT"
  else
    curl -sf -X POST "$SIGNAL_URL" \
      -H 'Content-Type: application/json' \
      -d '{"signal":"music_ended","payload":{}}' >/dev/null
  fi
}

music_state() {
  osascript <<'EOF'
tell application "Music"
  return (player state as string)
end tell
EOF
}

music_volume() {
  osascript -e "tell application \"Music\" to set sound volume to $1"
}

prepare_and_play() {
  osascript <<'EOF'
set tmpName to "_play_once"

tell application "Music"
  try
    set songTrack to current track
  on error
    error "No current track. Load or select a song in Music first."
  end try

  set sound volume to 100
  set song repeat to off
  set shuffle enabled to false

  set pid to persistent ID of songTrack
  set fromTmp to false
  try
    if (name of container of songTrack) is tmpName then set fromTmp to true
  end try

  if fromTmp then
    if player state is playing then pause
    back track
    play user playlist tmpName
  else
    if exists user playlist tmpName then delete user playlist tmpName
    set tmp to make new user playlist with properties {name:tmpName}
    try
      set src to (first track of library playlist 1 whose persistent ID is pid)
      duplicate src to tmp
    on error
      duplicate songTrack to tmp
    end try
    play tmp
  end if
end tell
EOF
}

dim_lights
sleep "$DIM_DELAY_SEC"
prepare_and_play

deadline=$((SECONDS + START_TIMEOUT_SEC))
until [[ "$(music_state)" == "playing" ]]; do
  if (( SECONDS >= deadline )); then
    echo "Music never started" >&2
    bright_lights
    exit 1
  fi
  sleep "$POLL_SEC"
done

while [[ "$(music_state)" == "playing" ]]; do
  sleep "$POLL_SEC"
done

music_volume 0
bright_lights
