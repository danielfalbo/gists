keep it simple, less is more, code is artwork.

# Known Mac cursor lag

If cursor/mouse/trackpad lags, read `/Users/daniel/.codex/memories/cursor-lag.md` before diagnosing. Lunar previously leaked 1,085 disabled CGEventTaps; restarting Lunar fixed it. Measure tap ownership rather than assuming Karabiner or trusting CPU/RSS alone.
