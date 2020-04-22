
ARG DESIGNER_IMAGE=cp.icr.io/cp/icp4i/ace/ibm-ace-designer-flows-prod:11.0.0.8-r1-amd64
ARG CONNECTOR_IMAGE=cp.icr.io/cp/icp4i/ace/ibm-ace-lcp-prod:11.0.0.8-r1-amd64
ARG ACE_IMAGE=cp.icr.io/ibm-ace-server-prod:11.0.0.8-r1-amd64
FROM $CONNECTOR_IMAGE AS ibm-ace-connectors
FROM $ACE_IMAGE AS ace
FROM $DESIGNER_IMAGE AS ibm-ace-designer-flows

FROM registry.access.redhat.com/ubi8/nodejs-10 as prod-image

USER root

# Create a user to run as
RUN groupadd --gid 1200 designerflows && \
    groupadd --gid 1001 aceuser && \
    groupadd --gid 888 mqm && \
    groupadd --gid 1002 mqbrkrs && \
    useradd -u 1200 -g 1200 -G 1001,888 -c 'Designer Flows' -s /bin/bash designerflows

RUN useradd -u 1000 -d /home/aceuser -G mqbrkrs,wheel -g aceuser aceuser

run mkdir -p /home/aceuser/designer
COPY --from=ibm-ace-designer-flows /opt/ibm/app /home/aceuser/designer
COPY --from=ibm-ace-designer-flows /readiness/ready.sh /home/aceuser/designer/ready.sh
COPY --from=ibm-ace-designer-flows /usr/bin/node /usr/bin/node
COPY --from=ibm-ace-designer-flows /lib64/libcrypto.so.1.1 /lib64/libcrypto.so.1.1
COPY --from=ibm-ace-designer-flows /lib64/libssl.so.1.1 /lib64/libssl.so.1.1

run mkdir -p /home/aceuser/connectors
COPY --from=ibm-ace-connectors /opt/ibm/app /home/aceuser/connectors

RUN chown -R aceuser:aceuser /home/aceuser/designer && \
    chown -R aceuser:aceuser /home/aceuser/connectors


# Copy across ACE

# Add required license as text file in Liceses directory (GPL, MIT, APACHE, Partner End User Agreement, etc)
COPY --from=ace /licenses/ /licenses/
COPY --from=ace /opt/ACEOpenTracing/ /opt/ACEOpenTracing/
COPY --from=ace /etc/ACEOpenTracing/ /etc/ACEOpenTracing/

RUN dnf install -y --nodocs openssl util-linux unzip python2 && dnf clean all
COPY --from=ace /opt/ibm/ace-11 /opt/ibm/ace-11
COPY --from=ace /var/mqsi /var/mqsi
RUN chown -R aceuser:aceuser /var/mqsi

COPY --from=ace /usr/local/bin/runaceserver /usr/local/bin/runaceserver
COPY --from=ace /usr/local/bin/chkace* /usr/local/bin/
COPY --from=ace /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=ace /usr/local/bin/*.sh /usr/local/bin/
# Create a user to run as, create the ace workdir, and chmod script files
RUN su - aceuser -c '. /opt/ibm/ace-11/server/bin/mqsiprofile && mqsicreateworkdir /home/aceuser/ace-server' \
    && chmod 755 /usr/local/bin/*

# Set permissions for OpenTracing directories
COPY --from=ace /var/log/ACEOpenTracing /var/log/ACEOpenTracing
RUN chown aceuser:aceuser /etc/ACEOpenTracing /opt/ACEOpenTracing /var/log/ACEOpenTracing

# Set BASH_ENV to source mqsiprofile when using docker exec bash -c
ENV BASH_ENV=/usr/local/bin/ace_env.sh

EXPOSE 7600 7800 7843 9483

USER aceuser

COPY run.sh /home/aceuser/run.sh
COPY run-designer.sh /home/aceuser/run-designer.sh
COPY run-connectors.sh /home/aceuser/run-connectors.sh
COPY run-ace.sh /home/aceuser/run-ace.sh
COPY ready.sh /readiness/ready.sh
COPY bars /home/aceuser/bars
RUN ace_compile_bars.sh

WORKDIR /home/aceuser
RUN mkdir /home/aceuser/initial-config && chown aceuser:aceuser /home/aceuser/initial-config

ENTRYPOINT ["/home/aceuser/run.sh"]
