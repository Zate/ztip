package main

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

// Route struct
type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

// Routes is an array of Route
type Routes []Route

// NewRouter spins up a new router
func NewRouter() *mux.Router {
	router := mux.NewRouter().StrictSlash(true)
	for _, route := range routes {
		var handler http.Handler
		handler = route.HandlerFunc
		handler = Logger(handler, route.Name)

		router.
			Methods(route.Method).
			Path(route.Pattern).
			Name(route.Name).
			Handler(handler)
	}

	return router
}

// Index handles the basic index of the API, might be a place to stick documentation
func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World!")
}

var routes = Routes{
	Route{
		"Index",
		"GET",
		"/v1/",
		Index,
	},

	Route{
		"ApiStatus",
		"GET",
		"/v1/status",
		APIStatus,
	},

	Route{
		"GetIPIntel",
		"GET",
		"/v1/ip/{ip}",
		GetIPIntel,
	},

	Route{
		"GetFeeds",
		"GET",
		"/v1/feeds",
		ListFeeds,
	},
}
