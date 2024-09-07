# Use a base image with Node.js and Playwright dependencies
FROM mcr.microsoft.com/playwright/python

# Install necessary packages
RUN apt-get update && apt-get install -y \
    x11-apps \
    wget \
    sudo \
    && apt-get clean


RUN apt-get update && apt-get install -y \
    curl \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

ENV DISPLAY=host.docker.internal:0.0

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install playwright jupyter notebook

# Set the working directory
WORKDIR /usr/src/app

# Copy your Playwright scripts into the container
COPY . .

# Optionally install the browsers if not installed by default
RUN playwright install

# Optionally install the browsers if not installed by default
RUN npx playwright install

# Expose port for Jupyter
EXPOSE 6999

# Command to start Jupyter Lab
ENTRYPOINT  ["/bin/bash", "entrypoint.sh"]