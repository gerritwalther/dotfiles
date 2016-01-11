# -*- coding: utf-8 -*-
"""
Module to show the currently selected layout. Requires xkblayout-state in your PATH. https://github.com/nonpop/xkblayout-state
NOTE: py3status will NOT execute:
    - methods starting with '_'
    - methods decorated by @property and @staticmethod
NOTE: reserved method names:
    - 'kill' method for py3status exit notification
    - 'on_click' method for click events from i3bar (read below please)
"""

# import your useful libs here
from time import time
from subprocess import Popen, PIPE
import sys
import re
import json

LAYOUT_CMD = 'xkblayout-state print "%n"'
LAYOUT_CHANGE_CMD = 'xkblayout-state set +1'

def get_layout_status():
    ''' Return the currently selected layout '''
    try:
        return Popen(LAYOUT_CMD, stdout=PIPE, shell=True).stdout.read()
    except Exception:
        return 'none'

class Py3status:
    """
    The Py3status class name is mendatory.
    Below you list all the available configuration parameters and their
    default value for your module which can be overwritten by users
    directly from their i3status config.
    """
    show = True
    format = 'Layout: {layout}'

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
        Popen(LAYOUT_CHANGE_CMD, stdout=PIPE, shell=True)
        return

    def layout(self, i3s_output_list, i3s_config):
        response = {'full_text': ''}

        if self.show:
          layout = get_layout_status()

          if layout == 'English':
            response['color'] = i3s_config['color_good']
          else:
            response['color'] = i3s_config['color_bad']

          response['full_text'] = self.format.format(
            layout=layout
          )

          response['cached_until'] = time() + 1


        return response

if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep
    x = Py3status()
    while True:
        print(x.layout([], {'color_bad': '#FF0000', 'color_good': '#00FF00'}))
        sleep(1)
