FROM {{_input_:FROM_image}}
# LABEL maintainer " <>"

# ENV DEBIAN_FRONTEND=noninteractive

# RUN /bin/bash -c 'source $HOME/.bashrc ; echo $HOME'
# RUN ["/bin/bash", "-c", "echo hello"]

RUN apt update
RUN apt install -y gcc


RUN {{_cursor_}}
