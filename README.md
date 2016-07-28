# docker-capsh
Try out capsh in a Dockerfile! By default, Ubuntu comes with capsh but I have downloaded and `make`-ed the latest version for completeness (and reference).

[![Build Status](https://travis-ci.org/jgensler8/docker-capsh.svg?branch=master)](https://travis-ci.org/jgensler8/docker-capsh)

# Useful Links

[documentation](http://man7.org/linux/man-pages/man1/capsh.1.html)
[repository information](https://git.kernel.org/cgit/linux/kernel/git/morgan/libcap.git/)

```
docker build -t capsh .
docker run -it capsh
$ capsh --print
```

# Tutorials



```
$ capsh -- -c echo "hello world"
```
