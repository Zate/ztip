package main

import (
	"log"
	"net/http"
	"time"
)

// Logger logs things, including how long a request took.
func Logger(inner http.Handler, name string) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		inner.ServeHTTP(w, r)

		log.Printf(
			"%s %s %s %s %s",
			r.RemoteAddr,
			r.Method,
			r.RequestURI,
			name,
			time.Since(start),
		)
	})
}
