# /// script
# dependencies = [
#   "pyautogui",
# ]
# ///

# >_ brew install --cask homerow
# >_ open -a Brave\ Browser && uv run homerow_replay.py

import time
import pyautogui

print('Move mouse to corner of the screen to stop.')

second = 1

def act(k):
    # trigger homerow, multiple times to bypass paywall
    pyautogui.hotkey('command', 'shift', 'space')
    pyautogui.hotkey('command', 'shift', 'space')
    pyautogui.hotkey('command', 'shift', 'space')

    # press key
    pyautogui.write(k, interval=0.1)
    pyautogui.press('enter')

    # sleep 1s
    time.sleep(1 * second)

while True:
    # for key in ['AH', 'SD', 'SG', 'SS']:
    #   act(key)

    act('DD')
    time.sleep(1 * second)
    act('AG')
    act('DM')
    act('SK')
    time.sleep(3 * second)
    act('M')
    time.sleep(3 * second)
