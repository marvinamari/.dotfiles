# Copy over bash script used to install CLI tools. Build cache will only be 
# invalidated if this bash script was changed. 
COPY get_devtools_ubuntu.sh ./

# Install CLI tools & dependecies 
RUN /bin/bash ./get_devtools_ubuntu.sh &&\
    glide install

# Copy over source code
COPY . .
