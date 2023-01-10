FROM ubuntu:jammy

RUN apt-get update && apt-get -y install sudo

RUN \
    groupadd -g 999 foo && useradd -u 999 -g foo -G sudo -m -s /bin/bash foo && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "foo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the foo user!" && \
    echo "foo user:";  su - foo -c id

USER foo

WORKDIR '/home/foo/devxp-linux/'

CMD /bin/bash

COPY . .

RUN sudo chown -R foo:foo ~/devxp-linux

# do not run 'adr' role as it uses internal repo to download a jar
RUN sed -i 's/\s\+\- role: adr//g' site.yml

# Install dev tools and run validations
RUN \
    . ~/.profile && \
    export PATH=$PATH:/home/foo/.local/bin && \
    ./bootstrap.sh
