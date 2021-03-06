
# docker.io/centos7
FROM openshift/base-centos7
#FROM docker.io/centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Oswald D'sa <oswald.dsa@bluescape.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="OpenLDAP for Bluescape" \
      io.k8s.display-name="builder x.y.z" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,x.y.z,etc."

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
RUN yum install -y openldap openldap-clients openldap-servers

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/local/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
USER root
COPY ./.s2i/bin/ /usr/local/s2i
#COPY ./.s2i/bin/* /usr/local/s2i
RUN  chmod 777 /usr/local/s2i/usr-local-s2i-test-echo-script
#RUN yum -y install nss_wrapper gettext

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
# USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

USER root
# TODO: Set the default CMD for the image
#CMD ["/usr/sbin/slapd start -4 -f /etc/sysconfig/slapd"]
#CMD ["/usr/sbin/slapd start -4 -f /etc/sysconfig/slapd -u ldap -g ldap"]
CMD ["/usr/local/s2i/usr-local-s2i-test-echo-script"]
