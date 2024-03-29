#!/usr/bin/python3

# This is a wrapper script to crontab which sets up the environment for crontab
# before the actual cron job executes. 99% of crontab problems are environment related.
# source: https://serverfault.com/a/1061424

# in crontab you write:
# mm hh * * * /path-to.../cron.launcher.py script_name.sh

# Runtime directories:
SYSPATH = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
PYTHONPATH = ""

################################################################################
import os
import time
import sys
import subprocess

# Get username passed by crontab
user = os.environ['LOGNAME']
uid = subprocess.check_output(('id -u ' + user).split()).decode().strip()
gid = subprocess.check_output(('id -g ' + user).split()).decode().strip()

# Set Environmental Variables:
os.environ["PATH"] = SYSPATH
os.environ["PYTHONPATH"] = PYTHONPATH
os.environ["DISPLAY"] = ":0"
os.environ["XAUTHORITY"] = os.path.join('/home', user, '.Xauthority')
os.environ["DBUS_SESSION_BUS_ADDRESS"] = 'unix:path=' + os.path.join('/run/user', uid, 'bus')
os.environ["XDG_RUNTIME_DIR"] = os.path.join("/run/user", uid)

# Get args:
script = sys.argv[1]
args = sys.argv[2:]
name = os.path.basename(script)
basedir = os.path.dirname(sys.argv[0])

# Log dir
logdir = os.path.join(basedir, 'cron.logs')
log = os.path.join(logdir, name + '.' + str(int(time.time())) + '.log')
os.makedirs(logdir, exist_ok=True)
if not os.access(logdir, os.W_OK):
    print("Can't write to log directory", logdir, file=sys.stderr)
    sys.exit(1)

# If running as root, lock up any scripts so others can't edit them before root runs them.
if os.geteuid() == 0:
    cron_log = os.path.join(logdir, 'cron.launcher.root.log')
    for path in [script, sys.argv[0]] + list(filter(None, PYTHONPATH.split(':'))):
        print("Setting permisisons for", path)
        subprocess.run(('chown root -R ' + path).split(), stderr=subprocess.PIPE, check=False)
        subprocess.run(('chmod og-w -R ' + path).split(), stderr=subprocess.PIPE, check=False)
else:
    cron_log = os.path.join(logdir, 'cron.launcher.log')
cron_log = open(cron_log, 'a')
logger = lambda *args: cron_log.write(' '.join(map(str, args)) + '\n')

# Run the script
output = open(log, mode='w')
if os.path.exists(script):
    os.chdir(os.path.dirname(script))
cmd = ['nice', 'ionice', '-c3'] + [script] + args
logger(time.strftime('\n%m-%d %H:%M', time.localtime()).lstrip('0'), user, "running:")
logger(cmd)
logger("in directory", os.getcwd(), "with log in", log)
start = time.time()
ret = subprocess.run(cmd, stdout=output, stderr=output, check=False)

# Cleanup
fmt = lambda num: ("{0:.3g}").format(num) if abs(num) < 1000 else str(int(num))
logger("Returned", ret.returncode, "after", fmt(time.time() - start), 'seconds')
output.close()
cron_log.close()
