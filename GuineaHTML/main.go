package main

import (
	"C"
	"encoding/json"
	"fmt"
	"github.com/dchest/htmlmin"
	"golang.org/x/net/html"
	"strings"
)

const GuineaHTMLVersion = "Alpha 0.0.1"

//export GetVersion
func GetVersion() *C.char {
	return C.CString(GuineaHTMLVersion)
}

//export CSSToJSON
func CSSToJSON(body *C.char) *C.char {
	bodyString := C.GoString(body)

	bodyString = strings.ReplaceAll(bodyString, "{", " {")
	bodyString = strings.ReplaceAll(bodyString, "}", " }")

	fmt.Println(bodyString)

	unmarshal := ParseCSS(bodyString)
	marshal, err := json.Marshal(unmarshal)
	if err != nil {
		panic(err.Error())
	}
	return C.CString(string(marshal))
}

// HTMLToJSON the given HTML nodes into JSON content where each
// HTML node is represented by the JsonNode structure.
//export HTMLToJSON
func HTMLToJSON(body *C.char) *C.char {
	bodyString := C.GoString(body)

	minifiedHtml, err := htmlmin.Minify([]byte(bodyString), &htmlmin.Options{
		MinifyScripts: false,
		MinifyStyles:  false,
		UnquoteAttrs:  false,
	})
	if err != nil {
		panic(err.Error())
	}

	reader := strings.NewReader(string(minifiedHtml))

	node, err := html.Parse(reader)
	if err != nil {
		panic(err.Error())
	}

	jsonNode := JsonNode{}
	jsonNode.populateFrom(node)

	marshal, err := json.Marshal(jsonNode)
	if err != nil {
		panic(err.Error())
	}

	return C.CString(string(marshal))
}

func main() {}
