# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOMOD=$(GOCMD) mod
BINARY_NAME=spacecrafts-fiber

# Build the application
build:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...

# Build for different platforms
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME)-linux-amd64 -v ./...

build-windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME)-windows-amd64.exe -v ./...

build-darwin:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME)-darwin-amd64 -v ./...

# Run tests
test:
	$(GOTEST) -v ./...

# Run tests with coverage
test-coverage:
	$(GOTEST) -race -coverprofile=coverage.out -covermode=atomic ./...
	$(GOCMD) tool cover -html=coverage.out -o coverage.html

# Run benchmarks
benchmark:
	$(GOTEST) -bench=. -benchmem ./...

# Clean build artifacts
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)*
	rm -f coverage.out coverage.html

# Download dependencies
deps:
	$(GOMOD) download
	$(GOMOD) verify

# Update dependencies
deps-update:
	$(GOMOD) tidy
	$(GOGET) -u ./...

# Run linting
lint:
	golint ./...
	$(GOCMD) vet ./...

# Run static analysis
static-check:
	staticcheck ./...

# Run security check
security:
	gosec ./...

# Run all checks (lint, vet, test)
check: lint test

# Run the application
run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)

# Docker commands
docker-build:
	docker build -t $(BINARY_NAME):latest .

docker-run:
	docker run -p 3000:3000 $(BINARY_NAME):latest

# Development server with auto-reload (requires air)
dev:
	air

# Install development tools
install-tools:
	$(GOGET) golang.org/x/lint/golint
	$(GOGET) honnef.co/go/tools/cmd/staticcheck
	$(GOGET) github.com/securecodewarrior/github-action-gosec/v2
	$(GOGET) github.com/air-verse/air

# Help
help:
	@echo "Available targets:"
	@echo "  build           - Build the application"
	@echo "  build-linux     - Build for Linux"
	@echo "  build-windows   - Build for Windows"
	@echo "  build-darwin    - Build for macOS"
	@echo "  test            - Run tests"
	@echo "  test-coverage   - Run tests with coverage"
	@echo "  benchmark       - Run benchmarks"
	@echo "  clean           - Clean build artifacts"
	@echo "  deps            - Download dependencies"
	@echo "  deps-update     - Update dependencies"
	@echo "  lint            - Run linting"
	@echo "  static-check    - Run static analysis"
	@echo "  security        - Run security checks"
	@echo "  check           - Run all checks"
	@echo "  run             - Build and run the application"
	@echo "  docker-build    - Build Docker image"
	@echo "  docker-run      - Run Docker container"
	@echo "  dev             - Run development server with auto-reload"
	@echo "  install-tools   - Install development tools"
	@echo "  help            - Show this help"

.PHONY: build build-linux build-windows build-darwin test test-coverage benchmark clean deps deps-update lint static-check security check run docker-build docker-run dev install-tools help
