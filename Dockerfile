FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y git make gcc
RUN rm `which capsh`

# Docs
# http://man7.org/linux/man-pages/man1/capsh.1.html
# Repo
# https://git.kernel.org/cgit/linux/kernel/git/morgan/libcap.git/
RUN git clone git://git.kernel.org/pub/scm/linux/kernel/git/morgan/libcap.git /opt/libcap
WORKDIR /opt/libcap
RUN make install
