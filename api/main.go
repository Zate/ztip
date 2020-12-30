package main

import (
	"log"
	"net/http"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Lmicroseconds | log.Lshortfile)

	log.Printf("Server started 8080")

	router := NewRouter()

	log.Fatal(http.ListenAndServe(":8080", router))
}
