package main

import (
	"bytes"
	"fmt"
	"golang.org/x/net/html"
	"log"
	"strings"
)

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

	if htmlNode.Data == "picture" {
		currentElement := htmlNode.FirstChild

		var foundSource = false

		for {
			if currentElement.NextSibling == nil {
				break
			}

			currentElement = currentElement.NextSibling

			if currentElement.Data == "source" {
				foundSource = true
			}

			if foundSource && currentElement.Data == "img" {
				htmlNode.RemoveChild(currentElement)
			}
		}

		e = htmlNode.FirstChild
	}

	if htmlNode.Type == html.ElementNode && (htmlNode.Data == "svg" || htmlNode.Data == "button") {
		var b bytes.Buffer
		var err error
		if e != nil {
			if htmlNode.Data == "button" {
				err = html.Render(&b, e)
			} else {
				err = html.Render(&b, htmlNode)
			}
			if err != nil {
				panic(fmt.Sprint("Failed to render html", err.Error()))
			}
			n.Text = b.String()
		}
	}

	for e != nil {
		switch e.Type {
		case html.TextNode:
			trimmed := strings.TrimSpace(e.Data)
			if len(trimmed) > 0 {
				var jsonElemNode JsonNode
				jsonElemNode.Name = "text"
				jsonElemNode.Text = e.Data
				jsonElemNode.Elements = make([]JsonNode, 0)
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
