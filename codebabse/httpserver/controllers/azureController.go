package controllers

import (
	"context"

	// "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/storage/azblob"
	"github.com/gin-gonic/gin"

	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
)

type BlobList struct {
	Blobs []string `json:"blobs"`
}

func handleError(err error) {
	if err != nil {
		log.Fatal(err.Error())
	}
}

func ListBlob(c *gin.Context) {

	blobs, err := listBlobs()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	jsonData, err := json.Marshal(BlobList{Blobs: blobs})
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jsonData)

}

func listBlobs() ([]string, error) {

	const (
		url           = "https://helmrepomalchiel.blob.core.windows.net/"
		containerName = "helm-repo-container"
	)

	connectionString, ok := os.LookupEnv("AZURE_STORAGE_CONNECTION_STRING")
	if !ok {
		panic("AZURE_STORAGE_ACCOUNT_NAME could not be found")
	}

	serviceClient, err := azblob.NewClientFromConnectionString(connectionString, nil)
	handleError(err)
	fmt.Println(serviceClient.URL())

	blobs := []string{}

	pager := serviceClient.NewListBlobsFlatPager(containerName, nil)

	for pager.More() {
		resp, err := pager.NextPage(context.TODO())
		handleError(err) // if err is not nil, break the loop.
		for _, _blob := range resp.Segment.BlobItems {
			fmt.Printf("%v", _blob.Name)
			blobs = append(blobs, *_blob.Name)
		}
	}

	return blobs, nil
}
