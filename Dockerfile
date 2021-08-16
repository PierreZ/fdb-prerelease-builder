FROM ubuntu:21.04

RUN apt-get update && \
	apt-get install -y curl \
		dnsutils \
		lsof \
		tcptraceroute \
		telnet  \
		netcat \
		strace \
		tcpdump \
		less \
		vim \
		net-tools \
		jq && \
	rm -rf /var/lib/apt/lists/*

# Adding tini as PID 1 https://github.com/krallin/tini
ARG TINI_VERSION=v0.19.0
RUN curl -sLO https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64 && \
  chmod +x tini-amd64 && \
  mv tini-amd64 /usr/bin/tini

WORKDIR /var/fdb/tmp
COPY *.deb /var/fdb/tmp
RUN dpkg -i *.deb

WORKDIR /

# Set Up Runtime Scripts and Directories
ADD *.bash /var/fdb/scripts/
RUN chmod a+x /var/fdb/scripts/*.bash

# Install additional FoundationDB Client Libraries
RUN	/var/fdb/scripts/download_multiversion_libraries.bash $FDB_WEBSITE $FDB_ADDITIONAL_VERSIONS

VOLUME /var/fdb/data

# Runtime Configuration Options

ENV FDB_PORT 4500
ENV FDB_CLUSTER_FILE /var/fdb/fdb.cluster
ENV FDB_NETWORKING_MODE container
ENV FDB_COORDINATOR ""
ENV FDB_COORDINATOR_PORT 4500
ENV FDB_CLUSTER_FILE_CONTENTS ""
ENV FDB_PROCESS_CLASS unset

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD /var/fdb/scripts/fdb.bash
