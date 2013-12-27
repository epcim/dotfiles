"""
Custom - Linux/Max home dir init script.
"""
VERSION = 1.0
AUTHOR = "petr_michalec@cz.ibm.com"

import sys
import os
import os.path
import time
from fabric.api import *
from fabric.colors import *
from fabric.contrib.files import append, exists, comment, contains
from fabric.contrib.console import confirm

## TUTORIAL
##
##  http://wiki.fabfile.org/Recipes
##  http://docs.fabfile.org/en/1.4.3/#api-documentation
##
##     run("cmd", pty=False, combine_stderr=True)
##     local("cmd", capture=True)
##     require('hosts', provided_by=[local,slice])
##
## BUILT-IN COMANDS
##    abort, cd, env, get, hide, hosts, local, prompt,  put, require, roles, run, runs_once,
##    settings, show, sudo, warn
##
## USAGE
##    fab --list
##    fab --list-format=nested --list

## PUBLSH SSH KEY
## fab l:t1 push_key:~/tmp/dsmolej_id_dsa.pub,user='root'
##
## SWITCH STAGE ETAPA1,2
## fab l:t1 -x was-t2.out.vis,esb-t2.out.vis checkRunningJava
## fab l:t1 -x was-t2.out.vis,esb-t2.out.vis switchStage:2
## or
## fab l:t1 -x was-t2.out.vis,esb-t2.out.vis checkRunningJava:False switchStage switchStage:2 switchStage
##

env.settings = {
    'ibm': {
        'hostname': 'bluepanic',
        'hosts': [],
    },
    'apelinux': {
        'hostname': 'dontpanic',
        'hosts': [],
        'roledefs': {
		'x': ['xxx.xxx.xx'],
        },
    },
}


#def vt():
#    env.update(env.settings['vums.vt'])
#    for l in env.roledefs.values():
#        env.hosts.extend(l)
#
#

#def setinst_vd():
#    env.update(env.settings['vums.vd'])
#    for l in env.roledefs.values():
#        env.hosts.extend(l)

@task(alias='i')
def instance(type):
    """ Set enviroment values for instance type. Argument ibm/apelinux/apeapple etc..
    """
    env.update(env.settings[type])
    for l in env.roledefs.values():
        env.hosts.extend(l)

#@task(alias='i')
#def instance(location):
#    """ Set enviroment values for instance type. Argument ibm/apelinux/apeapple etc..
#    """
#    namespace = __import__(__name__)
#    getattr(namespace, 'setloc_' + location)()

######################

@task
def initOS():
    print "Hostname: %s" % env['hostname']
    pass

@task
def initHome(user='pmichalec', boxdir='/hg2g/dav/box'):

    #box sync

    #configure users/system crontab to sync?

    #init default dirs
    #local("""
    #	    cd /home/pmichalec
    #	    for i in `echo .stardict .rednotebook .svn .git .hg bin other .xsession .xinitrc .profile .bashrc .ssh .mc .zshrc .zsh .config |xargs`; do
    #			cd;
    #
    #			#backup existing
    #			test -e ./$i && {{
    #			  test -L ./$i || mv "./$i" "./$i.ori";
    #			}}
    #
    #			test ln -s /hg2g/home/pmichalec/$i ./$i;
    #	    done;
    #   """)

    #once only
    local("mv /hg2g/home_pmichalecibm/lotus /home/pmichalec/lotus")
    local("mv /hg2g/home_pmichalecibm/.notes /home/pmichalec/.notes")
    local("mv /hg2g/home_pmichalecibm/.notesrc /home/pmichalec/.notesrc")
    local("mv /hg2g/home_pmichalecibm/.fetchnotesrc /home/pmichalec/.fetchnotesrc")


@task
def box(action="None", boxdir="/hg2g/dav/box"):
    pass

######################

@task
def checkRunning(process, dry=True):
    """ Check for running process on host
    """
    _generatePassword(user='root')
    if _online(env.host) is True:
        with settings(hide('running'), warn_only=dry, skip_bad_hosts=dry):
            #TODO: Return count (pids) - but count them
            o = run('pgrep "%s"| wc -l' % process)
        if o >= 1 and dry != True:
            abort("Aborted: %s java processes is running on host %s" % (o, env.host))


@task
@roles('was', 'esb', 'dm')
def checkRunningJava(dry=True):
    """ Check for running java processes on host
    """
    _generatePassword(user='root')
    with settings(hide('running', 'stdout')):
        checkRunning(dry=dry, process='java')


#@task
#@roles('was', 'esb', 'dm')
#def switchStage(stage=None):
#    """ Switch current enviroment by updating symlinks
#    """
#    _skipExcluded()
#
#    #TODO - if OKRI.TEST
#    #if 'was-t2.out.vis' in env.hosts and 'esb-t2.out.vis' in env.hosts:
#    #    #was-t2 and esb-t2 share shame pysical host
#    #    env.hosts.remove('was-t2.out.vis')
#
#    _generatePassword(user='root')
#
#    if stage:
#        #Etapa1,2 Skol1,2
#        if stage in ['1', '2']:
#            stage = "Etapa%s" % stage
#
#        print(magenta("Switching to %s" % stage))
#        checkRunningJava(dry=False)
#
#        with settings(hide('running'), warn_only=True, skip_bad_hosts=True):
#            with cd('/opt/IBM/WebSphere'):
#                run('test -L AppServer80 && rm AppServer80 ; ln -s %s_AppServer80 AppServer80 ' % stage)
#
#            libDir = None
#            if env.host[0:3] == 'was': libDir = 'SharedLibCA'
#            if env.host[0:3] == 'esb': libDir = 'SharedLibESB'
#            if libDir:
#                with cd("/opt/IBM"):
#                    #run('test -L %(libDir)s' % {'stage': stage, 'libDir': libDir})
#                    run('test -L %(libDir)s && rm %(libDir)s ; test -d %(stage)s_%(libDir)s && ln -s %(stage)s_%(libDir)s %(libDir)s' % {'stage': stage, 'libDir': libDir})
#    else:
#        print(magenta("Current stage:"))
#        with settings(hide('running'), warn_only=True, skip_bad_hosts=True):
#            if _online(env.host) is True:
#                run('ls -l /opt/IBM/WebSphere/ |grep AppServer80 |grep ^l')
#                if env.host[0:3] in ['was', 'esb']:
#                    run('ls -la /opt/IBM/ | grep SharedLib |grep ^l')
#

@task(alias='r')
def runcmd(c):
    """ Run given cmd on all hoststs in environment.
    Example: fab l:vt r:'killall java',exclude_hosts='vt-was3' -P
    """
    if _online(env.host) is True:
        run(c)


@task
def push_key(key_file='~/.ssh/id_dsa.pub', user='root'):
    """ Append passed ssh pubkey to destination host (if not exist already)
    """
    #different ssh port
    #_oncePerPhysicalHost()
    _skipExcluded()

    if _online(env.host) is True:
        _generatePassword(user)
        key_text = _read_key_file(key_file).strip()
        run('mkdir -p ~/.ssh/')
        append('~/.ssh/authorized_keys2', key_text)

        #TODO: Rights/mod


#TODO: Task pust zsh profile




#class Was(object):
#
#    def __init__(self):
#        pass
#
#    @task
#    def tailLogs():
#        pass
#
#    @task
#    def restartNode():
#        pass
#
#    @task
#    def rozkopiruj():
#        pass


#class Dm(object):
#
#    def __init__(self):
#        pass
#
#    @task
#    def restartDm():
#        pass
#
#dm = Dm()



## PRIVATE METHODS

def _skipExcluded():
    # Skip excluded hosts
    if env.host in env.exclude_hosts:
        print(red("Excluded"))
        return



def _read_key_file(key_file):
    key_file = os.path.expanduser(key_file)
    if not key_file.endswith('pub'):
        raise RuntimeWarning('Trying to push non-public part of key pair')
    with open(key_file) as f:
        return f.read()


def _online(machine):
    """ Is machine reachable on the network? (ping)
    """
    # Skip excluded hosts
    if env.host in env.exclude_hosts:
        print(red("Excluded"))
        return False

    with settings(hide('everything'), warn_only=True, skip_bad_hosts=True):
        if local("ping -c 2 -W 1 %s" % machine).failed:
            print(yellow('%s is Offline \n' % machine))
            return False
        return True


def _put_dir(local_dir, remote_dir):
    """Copy a local directory to a remote one, using tar and put. Silently
    overwrites remote directory if it exists, creates it if it does not
    exist."""
    local_tgz = "/tmp/fabtemp.tgz"
    remote_tgz = os.path.basename(local_dir) + ".tgz"
    local('tar -C "{0}" -czf "{1}" .'.format(local_dir, local_tgz))
    put(local_tgz, remote_tgz)
    local('rm -f "{0}"'.format(local_tgz))
    run('rm -Rf "{0}"; mkdir "{0}"; tar -C "{0}" -xzf "{1}" && rm -f "{1}"'\
        .format(remote_dir, remote_tgz))


def _waitForLine(fname, pattern, grepArgs=''):
    """ Wait for string pattern in files
    """
    run("tail -F '%s' | grep -m 1 %s '%s'" % (fname, grepArgs, pattern))


from string import Template
from fabric.api import env


def _fmt(s, **kwargs):
    """
    Recursively interpolate values into the given format string, using
    ``string.Template``.

    The values are drawn from the keyword arguments and ``env``, in that order.
    The recursion means that if a value to be interpolated is itself a format
    string, then it will be processed as well.

    If a name cannot be found in the keyword arguments or ``env``, then that
    format-part will be left untouched.

    Examples::

        >>> fmt("$shell 'echo $PWD'")
        "/bin/bash -l -c 'echo $PWD'"

        >>> fmt("echo $$shell")
        'echo $shell'

        >>> fmt("a is ($a)", a="b is ($b/$c)", b=1, c=2)
        'a is (b is (1/2))'
    """
    data = {}
    data.update(env)
    data.update(kwargs)
    for k, v in data.items():
        if isinstance(v, basestring) and '$' in v:
            data[k] = fmt(v, **data)
    return Template(s).safe_substitute(data)


def _manual(cmd):
    """ Interactive shell execution
    """
    pre_cmd = "ssh -p %(port)s %(user)s@%(host)s export " \
              "TERM=linux && " % env
    local(pre_cmd + cmd, capture=False)


def _runbg(cmd, sockname="dtach"):
    """ Run tasks in background
        Make sure dtach is installed.
    """
    return run('dtach -n `mktemp -u /tmp/%s.XXXX` %s' % (sockname, cmd))


def _generatePassword(user=None):
    env.password = 'vis' + "".join(env.host.split('.')[0].split('-'))
    env.user = user if user else env.user
    print 'user:' + env.user
    print 'pass:' + env.password

#vi: ts=4,sts=2:

