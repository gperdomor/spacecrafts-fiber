<p align="center">
  A Spacecraft API example written in Go using Fiber.
</p>

<p align="center">
  <a href="https://github.com/gperdomor/spacecrafts-fiber/actions/workflows/ci.yml">
    <img alt="CI" src="https://github.com/gperdomor/spacecrafts-fiber/actions/workflows/ci.yml/badge.svg"/>
  </a>
  <a href="https://github.com/gperdomor/spacecrafts-fiber/blob/main/LICENSE">
    <img alt="GitHub License" src="https://img.shields.io/github/license/gperdomor/spacecrafts-fiber"/>
  </a>
  <a href="https://goreportcard.com/report/github.com/gperdomor/spacecrafts-fiber">
    <img alt="Go Report Card" src="https://goreportcard.com/badge/github.com/gperdomor/spacecrafts-fiber"/>
  </a>
  <a href="https://codecov.io/gh/gperdomor/spacecrafts-fiber">
    <img alt="codecov" src="https://codecov.io/gh/gperdomor/spacecrafts-fiber/branch/main/graph/badge.svg"/>
  </a>
</p>

## Features

- Built with [Fiber](https://gofiber.io/) - Fast HTTP framework
- Comprehensive CI/CD pipeline with GitHub Actions
- Multi-platform builds (Linux, Windows, macOS)
- Docker support with multi-architecture builds
- Security scanning and vulnerability checks
- Code coverage reporting
- Automated releases

## Quick Start

### Prerequisites

- Go 1.21 or higher
- Docker (optional)

### Local Development

1. Clone the repository:

```bash
git clone https://github.com/gperdomor/spacecrafts-fiber.git
cd spacecrafts-fiber
```

2. Install dependencies:

```bash
go mod download
```

3. Run the application:

```bash
go run main.go
```

The server will start on `http://localhost:3000`

### Using Make

The project includes a Makefile with common tasks:

```bash
# Build the application
make build

# Run tests
make test

# Run tests with coverage
make test-coverage

# Run all checks (lint, vet, test)
make check

# Build and run
make run

# Build for different platforms
make build-linux
make build-windows
make build-darwin

# Docker commands
make docker-build
make docker-run

# See all available commands
make help
```

### Docker

Build and run with Docker:

```bash
# Build Docker image
docker build -t spacecrafts-fiber .

# Run container
docker run -p 3000:3000 spacecrafts-fiber
```

## API Endpoints

- `GET /` - Returns a simple JSON response with "Hello, World!"

## CI/CD Pipeline

The project uses GitHub Actions for CI/CD with the following workflows:

### CI Workflow (`.github/workflows/ci.yml`)

Triggered on push and pull requests to `main` and `develop` branches:

1. **Test Job**:

   - Tests against Go 1.21, 1.22, 1.23 and 1.24
   - Runs `go vet`, `staticcheck`, and `golint`
   - Executes tests with race detection and coverage
   - Uploads coverage to Codecov

2. **Build Job**:

   - Builds for multiple platforms (Linux, Windows, macOS)
   - Supports both AMD64 and ARM64 architectures
   - Uploads build artifacts

3. **Security Job**:

   - Runs Gosec security scanner
   - Checks for known vulnerabilities with `govulncheck`

4. **Docker Job** (main branch only):
   - Builds and pushes Docker images to Docker Hub
   - Supports multi-platform builds (linux/amd64, linux/arm64)
   - Uses GitHub Actions cache for efficiency

### Release Workflow (`.github/workflows/release.yml`)

Triggered on version tags (`v*`):

- Builds binaries for all supported platforms
- Creates checksums for verification
- Creates GitHub releases with binaries attached

### Setting up CI Secrets

To use the Docker workflow, add these secrets to your GitHub repository:

1. Go to your repository settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: Your Docker Hub password or access token

### Creating a Release

To create a new release:

1. Create and push a tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

2. The release workflow will automatically:
   - Build binaries for all platforms
   - Create a GitHub release
   - Attach binaries and checksums

## Development Tools

Install recommended development tools:

```bash
make install-tools
```

This installs:

- `golint` - Go linter
- `staticcheck` - Static analysis tool
- `gosec` - Security scanner
- `air` - Live reload for development

## Testing

Run tests locally:

```bash
# Run all tests
make test

# Run tests with coverage
make test-coverage

# Run benchmarks
make benchmark

# Run all quality checks
make check
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting: `make check`
5. Submit a pull request

The CI pipeline will automatically run tests, security scans, and build checks on your pull request.

## License

This project is licensed under the MIT License.
