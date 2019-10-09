package main

import (
	"cuelang.org/go/cue/format"
	"cuelang.org/go/encoding/protobuf"
	"fmt"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	deviceProtoPath := "../src/device/"
	cueFilesPath := "./pkg/chromium.org/device/"
	deviceProtoFiles, err := ioutil.ReadDir(deviceProtoPath)
	if err != nil {
		log.Fatal(err)
	}

	for _, protoFile := range deviceProtoFiles {
		if !strings.HasSuffix(protoFile.Name(), ".proto") {
			continue
		}

		file, err := protobuf.Extract(deviceProtoPath+protoFile.Name(), nil, &protobuf.Config{
			Paths: []string{deviceProtoPath + ".."},
		})

		if err != nil {
			log.Fatal(err, "Error processing "+protoFile.Name())
		}

		b, _ := format.Node(file)

		cue_file := cueFilesPath + strings.ReplaceAll(protoFile.Name(), ".proto",
			".cue")
		ioutil.WriteFile(cue_file, b, 0644)

		fmt.Println("Succesfully generated " + cue_file)
	}
}
