FROM node:16.0.0-alpine3.13

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add --no-cache micropython
RUN ln -s /usr/bin/micropython /usr/bin/python3

COPY node_pxt_arcade_yarnfiles/package.json node_pxt_arcade_yarnfiles/yarn.lock /tmp
RUN cd /tmp && yarn --production
RUN mkdir -p /opt/pxt \ 
    && cd /opt/pxt \
    && ln -s /tmp/node_modules \
    && ln -s /opt/pxt/node_modules/pxt/pxt /usr/bin/pxt

RUN mkdir -p /opt/pxt/arcade \
    && cd /opt/pxt/arcade \
    && pxt target arcade

WORKDIR /opt/pxt/arcade

VOLUME /opt/pxt/arcade/projects

EXPOSE 3232

ENTRYPOINT ["pxt"]
CMD ["serve"]
