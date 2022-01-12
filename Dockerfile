FROM alpine:3.15
MAINTAINER tgraf@noironetworks.com

LABEL org.opencontainers.image.source=https://github.com/shipperizer/netperf-docker

ADD super_netperf /sbin/

RUN \
	apk add --update curl build-base bash && \
	curl -LO https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz && \
	tar -xzf netperf-2.7.0.tar.gz  && \
	cd netperf-2.7.0 && ./configure --prefix=/usr && make && make install && \
	rm -rf netperf-2.7.0 netperf-2.7.0.tar.gz && \
	rm -f /usr/share/info/netperf.info && \
	strip -s /usr/bin/netperf /usr/bin/netserver && \
	apk del build-base && rm -rf /var/cache/apk/*

CMD ["/usr/bin/netserver", "-D"]
