# RVM IoT .NET Runtime Container

A multi-architecture Docker container based on .NET 9 runtime with CUPS client, htmldoc, and additional utilities for IoT applications.

## Features

- .NET 9 Runtime on Debian Bookworm Slim
- CUPS client for printer management
- htmldoc for HTML to PDF conversion
- ImageMagick for image processing
- Poppler utilities for PDF manipulation
- Multi-architecture support (AMD64 and ARM64)

## GitHub Actions Workflow

This repository includes a comprehensive GitHub Actions workflow that:

1. **Builds** the container for both AMD64 and ARM64 architectures
2. **Tests** .NET application functionality by building and running a sample app
3. **Tests** htmldoc by converting HTML to PDF
4. **Tests** CUPS client commands (lpstat, lp, lpq)
5. **Tests** additional utilities (ImageMagick, Poppler)
6. **Uploads** to Docker Hub as `r3polska/rvm-iot-dotnet-runtime:latest`

### Setup Requirements

To use this workflow, you need to configure the following secrets in your GitHub repository:

1. Go to your repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Add the following repository secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub access token

### Workflow Triggers

The workflow runs on:
- Push to `master` or `main` branch
- Pull requests to `master` or `main` branch
- Manual trigger via workflow dispatch

### Multi-Architecture Support

The workflow builds and tests both:
- `linux/amd64` - for Intel/AMD processors
- `linux/arm64` - for ARM processors (Raspberry Pi, Apple Silicon, etc.)

The final image is published as a multi-architecture manifest, allowing Docker to automatically pull the correct architecture for your platform.

## Usage

### Pull the image
```bash
docker pull r3polska/rvm-iot-dotnet-runtime:latest
```

### Run a .NET application
```bash
docker run --rm -v /path/to/your/app:/app r3polska/rvm-iot-dotnet-runtime:latest dotnet YourApp.dll
```

### Convert HTML to PDF
```bash
docker run --rm -v /path/to/html:/html r3polska/rvm-iot-dotnet-runtime:latest htmldoc --webpage -f /html/output.pdf /html/input.html
```

### Use CUPS client
```bash
docker run --rm r3polska/rvm-iot-dotnet-runtime:latest lpstat -p
```

## Local Development

### Build locally
```bash
docker build -t rvm-iot-dotnet-runtime .
```

### Test locally
```bash
# Test .NET runtime
docker run --rm rvm-iot-dotnet-runtime dotnet --version

# Test htmldoc
docker run --rm rvm-iot-dotnet-runtime htmldoc --version

# Test CUPS client
docker run --rm rvm-iot-dotnet-runtime lpstat --help
```

## Architecture

The container is built on:
- Base: `mcr.microsoft.com/dotnet/runtime:9.0-bookworm-slim`
- Timezone: Europe/Warsaw
- Working directory: `/app`

## Installed Packages

- `cups-client` - CUPS client tools
- `cups-bsd` - BSD-style CUPS commands
- `htmldoc` - HTML to PDF converter
- `imagemagick` - Image manipulation tools
- `poppler-utils` - PDF utilities
- `libgdiplus` - Graphics library for .NET
- `tzdata` - Timezone data

## License

See [LICENSE](LICENSE) file for details.