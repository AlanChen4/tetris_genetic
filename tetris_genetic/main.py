import os
import subprocess
import threading

from py_helpers.helper import Heuristics

class tetris_AI:

    def __init__(self):
        self.jobs = []


    def start_script(self):
        '''Starts fceux with the lua script'''
        script_path = os.path.join('tetris_AI.lua')
        save_path = 'save_states/level_0.fcs'
        
        start_cmd = 'fceux -lua ' + script_path + ' -loadstate ' + save_path + ' game_roms/Tetris.nes'
        subprocess.run(start_cmd, shell = True)


    def start_helper(self):
        '''Starts python helper script'''
        h = Heuristics()


    def start_all(self):
        self.jobs.append(threading.Thread(target=self.start_script))
        self.jobs.append(threading.Thread(target=self.start_helper))

        for job in self.jobs:
            job.start()

if __name__ == '__main__':
    AI = tetris_AI()
    AI.start_all()
