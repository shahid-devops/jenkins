FROM centos:7
RUN yum -y install openssh-server
RUN useradd admin && \
    echo "1234" | passwd admin --stdin && \
    mkdir /home/admin/.ssh && \
    chmod 700 /home/admin/.ssh
COPY admin.key.pub /home/admin/.ssh/authorized_keys
RUN chown admin:admin -R /home/admin && \
    chmod 400 /home/admin/.ssh/authorized_keys

#Generate New host keys
RUN ssh-keygen -A
CMD /usr/sbin/sshd -D