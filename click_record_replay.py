# /// script
# dependencies = [
#   "pynput",
# ]
# ///

# >_ uv run click_record_replay.py

import time
import sys
from pynput import mouse, keyboard

# Global storage for the recorded sequence
# Format: (x, y, delay_before_click)
recording = []
last_action_time = None
is_recording = True

def on_click(x, y, button, pressed):
    global last_action_time, is_recording

    if not is_recording:
        return False # Stop listener

    if pressed and button == mouse.Button.left:
        current_time = time.time()
        # Calculate delay since last click (or start of recording)
        delay = current_time - last_action_time
        recording.append((x, y, delay))
        print(f"  Recorded click at ({x}, {y}) after {delay:.2f}s")
        last_action_time = current_time

def run_recorder():
    global last_action_time, is_recording
    print("--- RECORDING MODE ---")
    print("1. Perform your clicks.")
    print("2. When finished, press 'ESC' to stop recording and start replay.")

    last_action_time = time.time()

    # Start the mouse listener
    mouse_listener = mouse.Listener(on_click=on_click)
    mouse_listener.start()

    # Use a keyboard listener to stop recording
    with keyboard.Listener(on_press=lambda key: key == keyboard.Key.esc) as k_listener:
        k_listener.join()

    is_recording = False
    mouse_listener.stop()

    # Record the final delay between the last click and pressing ESC
    final_delay = time.time() - last_action_time
    print(f"--- RECORDING STOPPED ---")
    print(f"Final wait time recorded: {final_delay:.2f}s")
    return final_delay

def run_replay(final_delay):
    controller = mouse.Controller()
    print("\n--- REPLAY MODE (Looping) ---")
    print("Press Ctrl+C in this terminal to stop.")

    try:
        while True:
            for x, y, delay in recording:
                time.sleep(delay)
                controller.position = (x, y)
                controller.click(mouse.Button.left, 1)

            # Wait the final "cooldown" recorded before loop restarts
            time.sleep(final_delay)
    except KeyboardInterrupt:
        print("\nReplay stopped by user.")

if __name__ == "__main__":
    final_wait = run_recorder()
    if recording:
        run_replay(final_wait)
    else:
        print("No clicks were recorded.")
