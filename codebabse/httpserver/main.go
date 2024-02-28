package main

import (
	"github.com/MalchielUrias/azureblob-helmproj/controllers"
	"github.com/MalchielUrias/azureblob-helmproj/initializers"
	"github.com/gin-gonic/gin"
)

type BlobList struct {
	Blobs []string `json:"blobs"`
}

func init() {
	initializers.LoadEnv()
}

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.GET("/listblob", controllers.ListBlob)

	r.Run() // listen and serve on 0.0.0.0:8080
}
