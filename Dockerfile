FROM openjdk:16

# Define the environment variables
ENV WORKING_DIRECTORY="/app"
ENV USER=container
ENV JAVA_HEAP_SIZE="4G"
ENV JAVA_ARGUMENTS="-Xmx${JAVA_HEAP_SIZE} -Xms${JAVA_HEAP_SIZE}"

WORKDIR $WORKING_DIRECTORY

# Copy our files
COPY build/libs/NanoLimbo-*-all.jar $WORKING_DIRECTORY/server.jar

# Create a custom user so we don't run as root
RUN groupadd ${USER} && \
    useradd -ms /bin/bash ${USER} -g ${USER} -d ${WORKING_DIRECTORY} && \
    chown -R ${USER}:${USER} ${WORKING_DIRECTORY}
USER ${USER}

# Start the software
ENTRYPOINT java -jar $JAVA_ARGUMENTS /app/server.jar