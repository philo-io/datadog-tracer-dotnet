FROM alpine:latest AS datadog-tracer
ARG VERSION
RUN apk add tar wget gzip
RUN mkdir /opt/datadog
COPY Project.csproj .
RUN wget https://github.com/DataDog/dd-trace-dotnet/releases/download/v${VERSION}/datadog-dotnet-apm-${VERSION}.tar.gz && \
    tar -C /opt/datadog -xzf datadog-dotnet-apm-${VERSION}.tar.gz

FROM scratch
COPY --from=datadog-tracer /opt/datadog /opt/datadog
