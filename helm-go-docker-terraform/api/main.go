package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	json.NewEncoder(w).Encode(map[string]string{"message": "OK"})
}

func main() {
	http.HandleFunc("/", handler)

	log.Println("Running on port 3000")
	http.ListenAndServe(":3000", nil)
}
