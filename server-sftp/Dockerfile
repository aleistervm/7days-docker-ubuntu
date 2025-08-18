FROM ubuntu:22.04

# Prevent apt from asking for user input during build
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install the OpenSSH server
# Clean up apt cache afterward to keep the image smaller
RUN apt-get update \
    && apt-get install -y openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Create the server's host keys. This command is the same.
RUN ssh-keygen -A

# Copy the entrypoint script into the image and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the standard SSH port
EXPOSE 22

# Set the entrypoint script to run when the container starts
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# The default command is the SSH daemon in the foreground
CMD ["/usr/sbin/sshd", "-D", "-e"]
