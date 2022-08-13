package main

import (
	"C"
	"encoding/json"
	"golang.org/x/net/html"
	"log"
	"strings"
)

const GuineaHTMLVersion = "Alpha 0.0.1"

//export GetVersion
func GetVersion() *C.char {
	return C.CString(GuineaHTMLVersion)
}

// HTMLToJSON the given HTML nodes into JSON content where each
// HTML node is represented by the JsonNode structure.
//export HTMLToJSON
func HTMLToJSON(body *C.char) *C.char {
	bodyString := C.GoString(body)
	reader := strings.NewReader(bodyString)

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

// JsonNode is a JSON-ready representation of an HTML node.
type JsonNode struct {
	// Name is the name/tag of the element
	Name string `json:"name,omitempty"`
	// Attributes contains the attributs of the element other than id, class, and href
	Attributes map[string]string `json:"attributes,omitempty"`
	// Class contains the class attribute of the element
	Class string `json:"class,omitempty"`
	// Id contains the id attribute of the element
	Id string `json:"id,omitempty"`
	// Href contains the href attribute of the element
	Href string `json:"href,omitempty"`
	// Text contains the inner text of the element
	Text string `json:"text,omitempty"`
	// Elements contains the child elements of the element
	Elements []JsonNode `json:"elements"`
}

func (n *JsonNode) populateFrom(htmlNode *html.Node) *JsonNode {
	switch htmlNode.Type {
	case html.ElementNode:
		n.Name = htmlNode.Data
		break

	case html.DocumentNode:
		break

	default:
		log.Fatal("Given node needs to be an element or document")
	}

	if n.Elements == nil {
		n.Elements = make([]JsonNode, 0)
	}

	if len(htmlNode.Attr) > 0 {
		n.Attributes = make(map[string]string)
		var a html.Attribute
		for _, a = range htmlNode.Attr {
			switch a.Key {
			case "class":
				n.Class = a.Val

			case "id":
				n.Id = a.Val

			case "href":
				n.Href = a.Val

			default:
				n.Attributes[a.Key] = a.Val
			}
		}
	}

	e := htmlNode.FirstChild
	for e != nil {
		switch e.Type {
		case html.TextNode:
			trimmed := strings.TrimSpace(e.Data)
			if len(trimmed) > 0 {
				var jsonElemNode JsonNode
				jsonElemNode.Name = "text"
				jsonElemNode.Text = e.Data
				n.Elements = append(n.Elements, jsonElemNode)
			}

		case html.ElementNode:
			if n.Elements == nil {
				n.Elements = make([]JsonNode, 0)
			}
			var jsonElemNode JsonNode
			jsonElemNode.populateFrom(e)
			n.Elements = append(n.Elements, jsonElemNode)
		}

		e = e.NextSibling
	}

	return n
}

func main() {}
