import sys
import subprocess
import time
import io
import os
import signal

commands = sys.argv[1:]
output_file = [io.open('%s_%d.log' % (cmd.split()[0], i), 'w') for i, cmd in enumerate(commands)]
process_list = [subprocess.Popen(('%s &' % cmd).split(), stdout=output_file[i], shell=True) for i, cmd in enumerate(commands)]

def check_pid(pid):
    try:
        os.kill(pid,0)
    except OSError:
        return False
    else:
        return True

while True:
    for i, p in enumerate(process_list):
        output_file[i].flush()
        if not check_pid(p.pid) or p.poll():
            with open('manager.log', 'a') as f_out:
                f_out.write('something wrong\n')
            process_list[i] = subprocess.Popen(commands[i], stdout=output_file[i], shell=True)
    time.sleep(10)

