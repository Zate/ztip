package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net"

	"github.com/go-redis/redis/v8"
	"github.com/oschwald/geoip2-golang"
)

var ctx = context.Background()

// GetStatus pulls the status object from redis.
func GetStatus() string {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})
	status, err := client.Get(ctx, "Status").Result()
	if err != nil {
		return "{Error: \"Not Found\"}"
	}
	//status = "{\"ips\":\"" + status + "\"}"
	return status
}

// GetFeeds pulls the feeds object from redis.
func GetFeeds() string {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})
	feeds, err := client.Get(ctx, "Feeds").Result()
	if err != nil {
		return "{Error: \"" + fmt.Sprint(err.Error()) + "\"}"
	}
	//status = "{\"ips\":\"" + status + "\"}"
	return feeds
}

// GetIP pulls an ip from redis
func GetIP(ip string) IPAddr {
	var IP IPAddr
	var b B
	IP.IP = ip
	db, err := geoip2.Open("geodb/GeoLite2-City.mmdb")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	// If you are using strings that may be invalid, check that ip is not nil
	ipg := net.ParseIP(ip)
	record, err := db.City(ipg)
	if err != nil {
		log.Fatal(err)
	}
	//c, _ := json.MarshalIndent(record, "", "  ")
	//log.Println(string(c))
	IP.City = record.City.Names["en"]
	IP.Accuracy = record.Location.AccuracyRadius
	IP.AnonProxy = record.Traits.IsAnonymousProxy
	IP.ContCode = record.Continent.Code
	IP.ContName = record.Continent.Names["en"]
	IP.Country = record.Country.Names["en"]
	IP.IsoCode = record.Country.IsoCode
	IP.Lat = record.Location.Latitude
	IP.Long = record.Location.Longitude
	IP.MetroCode = record.Location.MetroCode
	IP.PostalCode = record.Postal.Code
	IP.TimeZone = record.Location.TimeZone
	// log.Printf("City name: %v\n", record.City.Names["en"])
	// log.Printf("Ssubdivision name: %v\n", record.Subdivisions[0].Names["en"])
	// log.Printf("Russian country name: %v\n", record.Country.Names["en"])
	// log.Printf("ISO country code: %v\n", record.Country.IsoCode)
	// log.Printf("Time zone: %v\n", record.Location.TimeZone)
	// log.Printf("Coordinates: %v, %v\n", record.Location.Latitude, record.Location.Longitude)

	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "",
		DB:       0,
	})
	status, err := client.Get(ctx, ip).Result()
	if err == redis.Nil {
		IP.Created = ""
		IP.Updated = ""
		IP.Intel = make([]Intel, 0)
		//log.Println(b)
	} else if err != nil {
		log.Println(err)
		IP.Created = ""
		IP.Updated = ""
		IP.Intel = make([]Intel, 0)
	} else {
		//log.Println(status)
		err = json.Unmarshal([]byte(status), &b)
		if err != nil {
			log.Printf("ip: %v - Status: %v - Error: %v", ip, status, err)
		}
		//IP.IP = b.IP
		IP.Created = b.Created
		IP.Updated = b.Updated
		IP.Intel = b.Intel
		//log.Println(b)
	}
	return IP
}
