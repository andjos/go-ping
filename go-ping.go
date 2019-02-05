package main

import (
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	gin.SetMode(gin.ReleaseMode) //Set releasemode
	router := gin.Default()

	router.GET("/ping", status)
	router.Run()

}

// Simple Alive function
func status(c *gin.Context) {
	t := (time.Now().Format(time.RFC3339))

	c.JSON(200, gin.H{
		"status": "ok...",
		"time":   t,
	})
}
