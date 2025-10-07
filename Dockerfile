# Use the latest .NET 9 runtime on Debian
FROM mcr.microsoft.com/dotnet/aspnet:9.0-bookworm-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    cups-client \
    tzdata \
    libgdiplus \
    poppler-utils \
    imagemagick \
    libc6 \
    libc6-dev \
    cups-bsd \
    htmldoc \
    && rm -rf /var/lib/apt/lists/*

# Set timezone to Europe/Warsaw
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the working directory
WORKDIR /app
