FROM alpine:latest AS datadog-tracer
ARG DD_TRACE_VERSION
LABEL org.opencontainers.image.description dd-trace-dotnet v${DD_TRACE_VERSION}

RUN apk add tar wget gzip
RUN mkdir /opt/datadog
COPY Project.csproj .
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${DD_TRACE_VERSION}/datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz && \
    tar -C /opt/datadog -xzf datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz

FROM scratch
COPY --from=datadog-tracer /opt/datadog /opt/datadog
