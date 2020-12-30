package main

import (
	"encoding/json"
	"net/http"

	"github.com/gorilla/mux"
)

// IPAddr is the default struct for an IP
type IPAddr struct {
	IP         string  `json:"ip"`
	Accuracy   uint16  `json:"Accuracy"`
	AnonProxy  bool    `json:"AnonProxy"`
	City       string  `json:"City"`
	ContCode   string  `json:"ContCode"`
	ContName   string  `json:"ContName"`
	Country    string  `json:"Country"`
	IsoCode    string  `json:"IsoCode"`
	Lat        float64 `json:"Lat"`
	Long       float64 `json:"Long"`
	MetroCode  uint    `json:"MetroCode"`
	PostalCode string  `json:"PostalCode"`
	TimeZone   string  `json:"TimeZone"`
	Created    string  `json:"created"`
	Intel      []Intel `json:"intel"`
	Updated    string  `json:"updated"`
}

// Intel is a struct containing a reference to an intel feed.
type Intel struct {
	Cat     string `json:"cat"`
	Created string `json:"created"`
	Name    string `json:"name"`
	Tag     string `json:"tag"`
	Updated string `json:"updated"`
	URL     string `json:"url"`
}

// B is a struct to unmarshal the JSON from redis into
type B struct {
	IP      string  `json:"ip"`
	Updated string  `json:"updated"`
	Created string  `json:"created"`
	Intel   []Intel `json:"intel"`
}

// APIStatus prints out the basic status object
func APIStatus(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(GetStatus()))
}

// ListFeeds prints out the basic feeds object
func ListFeeds(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(GetFeeds()))
}

// GetIPIntel grabs and prints the intel for an up.
func GetIPIntel(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
	b, err := json.Marshal(GetIP(vars["ip"]))
	if err != nil {
		w.Write([]byte("error"))
		return
	}
	w.Write(b)
}
