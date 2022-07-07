From kalilinux/kali-rolling

RUN apt-get update && apt-get install -y nmap metasploit-framework wireshark xorg xauth openbox firefox \
  && groupadd -g 1000 rozay -d /home/rozay -s /bin/bash -m rozay -u 1000 -g 1000

USER rozay
ENV HOME /home/rozay
CMD /usr/bin/firefox