import subprocess
import time
import json
import os
from datetime import datetime, timedelta

# --- FORCE LONDON TIMEZONE ---
os.environ['TZ'] = 'Europe/London'
time.tzset()

# Configuration
BROKER = "localhost"
GROUP = "bedroom"

# SCHEDULE format: ("HH:MM", "state", brightness, color_temp)
SCHEDULE = [
    ("07:00", "ON", 254, 150),  # Bright/Cool (Morning)
    ("20:00", "ON", 150, 400),  # Warm/Dim (Evening)
    ("22:30", "ON", 50, 500),   # Very Warm/Low (Night)
    ("23:00", "OFF", None, None) # Off
]

def run_mqtt_command(state, brightness, color_temp):
    payload_dict = {"state": state}
    if brightness is not None:
        payload_dict["brightness"] = brightness
    if color_temp is not None:
        payload_dict["color_temp"] = color_temp

    payload_json = json.dumps(payload_dict)

    cmd = [
        "mosquitto_pub",
        "-h", BROKER,
        "-t", f"zigbee2mqtt/{GROUP}/set",
        "-m", payload_json
    ]

    try:
        subprocess.run(cmd, check=True)
        # Using .now() here will now respect the 'Europe/London' setting
        print(f"[{datetime.now().strftime('%H:%M:%S %Z')}] Sent: {payload_json}")
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")

def get_seconds_until(time_str):
    # This now uses the forced London timezone
    now = datetime.now()
    target_time = datetime.strptime(time_str, "%H:%M").time()
    target_datetime = datetime.combine(now.date(), target_time)

    if target_datetime < now:
        target_datetime += timedelta(days=1)

    return (target_datetime - now).total_seconds()

print(f"Scheduler started. Current London Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S %Z')}")

while True:
    upcoming = sorted(SCHEDULE, key=lambda x: get_seconds_until(x[0]))
    next_event = upcoming[0]

    wait_time = get_seconds_until(next_event[0])
    print(f"Next event at {next_event[0]} (Waiting {int(wait_time)}s)")

    time.sleep(wait_time)
    run_mqtt_command(next_event[1], next_event[2], next_event[3])
    time.sleep(61)
