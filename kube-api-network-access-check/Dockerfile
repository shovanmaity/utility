# Use Red Hat UBI minimal as base
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.3

# Install useful networking/debugging tools
# - curl       -> test HTTPS calls
# - iproute    -> view routing table
# - bind-utils -> nslookup/dig for DNS tests
# - procps-ng  -> ps/top for process debugging
RUN microdnf install -y \
        curl \
        iproute \
        bind-utils \
        procps-ng \
    && microdnf clean all

# Add a simple test script
COPY check-network.sh /usr/local/bin/check-network.sh
RUN chmod +x /usr/local/bin/check-network.sh

# Default command will run the check script
CMD ["/usr/local/bin/check-network.sh"]
