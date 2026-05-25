#!/usr/bin/env bash
set -euo pipefail

SIGNAL_URL="${SIGNAL_URL:-http://100.110.199.94:9888/v1/signal}"
POLL_SEC="${POLL_SEC:-1}"
START_TIMEOUT_SEC="${START_TIMEOUT_SEC:-10}"

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

  if exists user playlist tmpName then
    delete user playlist tmpName
  end if

  set tmp to make new user playlist with properties {name:tmpName}
  duplicate songTrack to tmp
  set song repeat to off
  set shuffle enabled to false
  play tmp
  set player position to 0
end tell
EOF
}

dim_lights
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
