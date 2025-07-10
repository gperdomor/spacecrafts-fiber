package main

import (
	"io"
	"net/http/httptest"
	"testing"

	"github.com/gofiber/fiber/v2"
	"github.com/stretchr/testify/assert"
)

func TestMain(t *testing.T) {
	// Create a new Fiber app
	app := fiber.New()

	// Add the route from main.go
	app.Get("/", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"Title": "Hello, World!",
		})
	})

	// Create a test HTTP request
	req := httptest.NewRequest("GET", "/", nil)
	req.Header.Set("Content-Type", "application/json")

	// Perform the request
	resp, err := app.Test(req)
	assert.NoError(t, err)
	assert.Equal(t, 200, resp.StatusCode)

	// Read the response body
	body, err := io.ReadAll(resp.Body)
	assert.NoError(t, err)

	// Check the response
	expectedBody := `{"Title":"Hello, World!"}`
	assert.JSONEq(t, expectedBody, string(body))
}

func TestHealthCheck(t *testing.T) {
	app := fiber.New()

	// Add a simple health check endpoint
	app.Get("/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"status": "ok",
		})
	})

	req := httptest.NewRequest("GET", "/health", nil)
	resp, err := app.Test(req)

	assert.NoError(t, err)
	assert.Equal(t, 200, resp.StatusCode)
}

// Benchmark test
func BenchmarkMainRoute(b *testing.B) {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"Title": "Hello, World!",
		})
	})

	for i := 0; i < b.N; i++ {
		req := httptest.NewRequest("GET", "/", nil)
		_, _ = app.Test(req)
	}
}
