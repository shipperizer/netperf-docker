FROM --platform=$BUILDPLATFORM alpine:3.6.5
MAINTAINER tgraf@noironetworks.com

LABEL org.opencontainers.image.source=https://github.com/shipperizer/netperf-docker

ADD super_netperf /sbin/

RUN \
	apk add --update curl build-base bash && \
	curl -LO https://github.com/HewlettPackard/netperf/archive/refs/tags/netperf-2.7.0.tar.gz && \
	tar -xzf netperf-2.7.0.tar.gz  && \
	cd netperf-netperf-2.7.0 && \
        curl -LO http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess && \
        curl -LO http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub && \
        ./configure --prefix=/usr && make && make install && \
	rm -rf netperf-2.7.0 netperf-2.7.0.tar.gz && \
	rm -f /usr/share/info/netperf.info && \
	strip -s /usr/bin/netperf /usr/bin/netserver && \
	apk del build-base && rm -rf /var/cache/apk/*

CMD ["/usr/bin/netserver", "-D"]
