package controllers

import (
	"context"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/storage/azblob"
	"github.com/gin-gonic/gin"

	"fmt"
	"log"
)

func handleError(err error) {
	if err != nil {
		log.Fatal(err.Error())
	}
}

func ListBlob(c *gin.Context) {

	const (
		url           = "https://MYSTORAGEACCOUNT.blob.core.windows.net/"
		containerName = "sample-container"
	)

	// url := "https://<storage-account-name>.blob.core.windows.net/"

	// authenticate with Azure Active Directory
	cred, err := azidentity.NewDefaultAzureCredential(nil)

	// create a client for the specified storage account
	client, err := azblob.NewClient(url, cred, nil)
	handleError(err)

	// List Blob

	fmt.Println("Listing the blobs in the container:")

	// blob listings are returned across multiple pages
	pager := client.NewListBlobsFlatPager(containerName, &azblob.ListBlobsFlatOptions{
		Include: azblob.ListBlobsInclude{Snapshots: true, Versions: true},
	})

	// continue fetching pages until no more remain
	for pager.More() {
		resp, err := pager.NextPage(context.TODO())
		handleError(err)

		for _, blob := range resp.Segment.BlobItems {
			fmt.Println(*blob.Name)
		}
	}

	c.JSON(200, gin.H{
		"message": pager,
	})

}
