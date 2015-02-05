# -*- coding: utf-8 -*-
"""
Module to show the status of Num-Lock and Caps-Lock keys.
Credits go to: https://github.com/syl20bnr/i3status-keyboard-leds
NOTE: py3status will NOT execute:
    - methods starting with '_'
    - methods decorated by @property and @staticmethod
NOTE: reserved method names:
    - 'kill' method for py3status exit notification
    - 'on_click' method for click events from i3bar (read below please)
"""

# import your useful libs here
from time import time
from evdev import InputDevice, ecodes
from subprocess import Popen, PIPE
import sys
import re
import json

LED_STATUSES_CMD = 'xset q | grep "LED mask"'
LED_MASKS = [
    ('caps',    0b0000000001,   'CAPS', '#DC322F'),
    ('num',     0b0000000010,    'NUM', '#859900'),
    ('scroll',  0b0000000100, 'SCROLL', '#2AA198'),
    ('altgr',   0b1111101000,  'ALTGR', '#858900')
  ]
  
def get_led_statuses():
    ''' Return a list of dictionaries representing the current keyboard LED statuses '''
    try:
        p = Popen(LED_STATUSES_CMD, stdout=PIPE, shell=True)
        mask = re.search(r'[0-9]{8}', p.stdout.read())
        if mask:
            value = int(mask.group(0))
            return value
            #return [to_dict(name, text, ccolor) for name, mask, text, color in reversed(LED_MASKS)
            #        if value & mask]
    except Exception:
        return 'abc'

def to_dict(name, text, color):
    ''' Returns a dictionary with given information. '''
    return {'full_text': text, 'name': name, 'color': color}

class Py3status:
    """
    The Py3status class name is mendatory.
    Below you list all the available configuration parameters and their
    default value for your module which can be overwritten by users
    directly from their i3status config.
    This examples features only one parameter which is 'cache_timeout'
    and is set to 10 seconds (0 would mean no cache).
    """
    show_num_status = True
    show_caps_status = True

    def __init__(self):
        """
        This is the class constructor which will be executed once.
        """
        pass

    def kill(self, i3s_output_list, i3s_config):
        """
        This method will be called upon py3status exit.
        """
        pass

    def on_click(self, i3s_output_list, i3s_config, event):
        """
        This method should only be used for ADVANCED and very specific usages.
        Read the 'Handle click events directly from your i3status config'
        article from the py3status wiki:
            https://github.com/ultrabug/py3status/wiki/
        This method will be called when a click event occurs on this module's
        output on the i3bar.
        Example 'event' json object:
        {'y': 13, 'x': 1737, 'button': 1, 'name': 'empty', 'instance': 'first'}
        """
        pass
        
    def numLock(self, i3s_output_list, i3s_config):
        response = {'full_text': ''}
        
        stati = get_led_statuses()
        
        if stati & LED_MASKS[1][1]:
          response['color'] = i3s_config['color_good']
        else:
          response['color'] = i3s_config['color_bad']
        
        response['full_text'] = LED_MASKS[1][2]
        
        response['cached_until'] = time() + 1
        
        return response

    def capsLock(self, i3s_output_list, i3s_config):
        response = {'full_text': ''}
        
        stati = get_led_statuses()
        
        if stati & LED_MASKS[0][1]:
          response['color'] = i3s_config['color_good']
        else:
          response['color'] = i3s_config['color_bad']
        
        response['full_text'] = LED_MASKS[0][2]
        
        response['cached_until'] = time() + 1
        
        return response

if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep
    x = Py3status()
    while True:
        print(x.numLock([], {'color_bad': '#FF0000', 'color_good': '#00FF00'}))
        print(x.capsLock([], {'color_bad': '#FF0000', 'color_good': '#00FF00'}))
        sleep(1)
