FROM alpine:latest AS datadog-tracer
ARG DD_TRACE_VERSION
ENV DD_PACKAGE="datadog-dotnet-apm-${DD_TRACE_VERSION}.tar.gz"
LABEL "org.opencontainers.image.description"=${DD_PACKAGE}

RUN apk add tar wget gzip
RUN mkdir /opt/datadog
COPY Project.csproj .
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${DD_TRACE_VERSION}/${DD_PACKAGE} && \
    tar -C /opt/datadog -xzf ${DD_PACKAGE}

FROM scratch
COPY --from=datadog-tracer /opt/datadog /opt/datadog
