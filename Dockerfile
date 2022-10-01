FROM alpine:latest AS datadog-tracer
RUN apk add tar wget gzip
RUN mkdir /opt/datadog

ARG DD_TRACE_VERSION
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${DD_TRACE_VERSION}/datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz
RUN tar -C /opt/datadog -xzf datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz

FROM scratch
ARG DD_TRACE_VERSION
LABEL org.opencontainers.image.description "datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz"
COPY --from=datadog-tracer /opt/datadog /opt/datadog
