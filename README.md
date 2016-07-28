# docker-capsh
Try out capsh in a Dockerfile! By default, Ubuntu comes with capsh but I have downloaded and `make`-ed the latest version for completeness (and reference).

[![Build Status](https://travis-ci.org/jgensler8/docker-capsh.svg?branch=master)](https://travis-ci.org/jgensler8/docker-capsh)

## Useful Links

[documentation link](http://man7.org/linux/man-pages/man1/capsh.1.html)

[repository information link](https://git.kernel.org/cgit/linux/kernel/git/morgan/libcap.git/)

## Getting Started: Useful Syntax

```
docker build -t capsh .
docker run -it capsh
$ capsh --print
$ capsh -- -c "echo 'hello world'"
```

## Getting Started: Use with Docker

Read up on Linux Security: [link](https://docs.docker.com/engine/security/security/#/linux-kernel-capabilities)

Default capabilities: [link](https://github.com/docker/docker/blame/master/oci/defaults_linux.go#L64-L79)

```
# First, check out the default capabilities
docker run jgensler8/capsh capsh --print | grep Current | awk '{ print $3 }' | tr ',' '\n'
# Then, Drop the CAP_CHOWN capability
docker run --cap-drop=chown jgensler8/capsh capsh --print | grep Current | awk '{ print $3 }' | tr ',' '\n'
```

# Tutorials

## CAP_KILL

CAP_KILL doesn't drop the entire ability to use `kill` to send signals. As stated in the `capsh` man page:

> Bypass permission checks for sending signals (see kill(2)). This includes use of the ioctl(2) KDSIGACCEPT operation.

and in `kill(2)`:

> For a process to have permission to send a signal it must either be privileged (under Linux: have the CAP_KILL capability), or the real or effective user ID of the sending process must equal the real or saved set-user-ID of the target process. In the case of SIGCONT it suffices when the sending and receiving processes belong to the same session.


### Background

```
root@be013ad40433:/opt/libcap# kill -l
 1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
```

### Example [TODO]

```
$ gcc examples/kill/test.c -o sigusrone
$ ./examples/kill/sigusrone &
$ capsh --drop=CAP_KILL -- -c "kill -n 10 $!"
```

## CAP_NET_BIND_SERVICE

### Background
```
root@94f6a2fad7f7:/opt/libcap# nc -l 8080 &
[2] 45
root@94f6a2fad7f7:/opt/libcap# netstat -lnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      45/nc
Active UNIX domain sockets (only servers)
Proto RefCnt Flags       Type       State         I-Node   PID/Program name    Path
root@94f6a2fad7f7:/opt/libcap# echo "hello world" > nc 0.0.0.0 8080
```

### Example

```
# TODO
```
