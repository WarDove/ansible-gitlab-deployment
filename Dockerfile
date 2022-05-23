FROM ubuntu:20.04

RUN apt update && apt install -y software-properties-common gettext-base && \
      add-apt-repository --yes --update ppa:ansible/ansible && \
      apt install -y ansible && apt install -y python3-pip 

RUN pip install "pywinrm>=0.2.2" 

RUN pip install "hvac"

RUN apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /ansible

RUN ansible-galaxy collection install community.windows

WORKDIR /ansible

COPY . .

ENV ANSIBLE_HOST_KEY_CHECKING=False

CMD ["ansible", "--version"]
