FROM alpine:3.19

RUN echo "FORCE_BUILD_XUI_370_$(date)"

RUN apk add --no-cache \
    curl \
    bash \
    ca-certificates \
    socat \
    tzdata \
    sqlite \
    nginx \
    gettext \
    tar \
    unzip \
    && ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime

RUN mkdir -p /tmp/xui \
    && curl -L https://github.com/MHSanaei/3x-ui/releases/download/v3.7.0/x-ui-linux-amd64.tar.gz -o /tmp/xui/x-ui.tar.gz \
    && tar -xzf /tmp/xui/x-ui.tar.gz -C /usr/local/ \
    && rm -rf /tmp/xui \
    && chmod +x /usr/local/x-ui/x-ui

RUN mkdir -p /etc/x-ui /var/log/x-ui /data/x-ui

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
