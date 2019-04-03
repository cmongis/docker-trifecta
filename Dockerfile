FROM java:8
MAINTAINER Jan Schulte <jan@janschulte.com>

ENV TRIFECTA_VERSION=0.21.3 TRIFECTA_URL=https://github.com/ldaniels528/trifecta/releases/download


#RUN adduser --disabled-password --gid 0 --gecos "Trifecta" trifecta
#RUN adduser --gid 0 trifecta
USER trifecta
RUN chown trifecta:root /home/trifecta && chmod 0775 /home/trifecta
ENV HOME /home/trifecta

WORKDIR /home/trifecta

RUN wget $TRIFECTA_URL/v$TRIFECTA_VERSION/trifecta_ui-$TRIFECTA_VERSION.zip && \
	unzip trifecta_ui-$TRIFECTA_VERSION.zip  && \
	rm trifecta_ui-$TRIFECTA_VERSION.zip && \
	ln -s trifecta_ui-$TRIFECTA_VERSION trifecta_ui && \
	mkdir /home/trifecta/.trifecta

COPY entrypoint.sh /home/trifecta/
COPY config.properties /home/trifecta/.trifecta/

VOLUME /home/trifecta/conf
EXPOSE 9000

ENTRYPOINT ["/home/trifecta/entrypoint.sh", "/home/trifecta/.trifecta/config.properties"]
