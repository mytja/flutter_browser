package main

import (
	"bufio"
	"bytes"
	"strings"
)

type CSSProperty struct {
	Name  string `json:"name"`
	Value string `json:"value"`
}

type CSSSelector struct {
	Name       string        `json:"name"`
	Properties []CSSProperty `json:"properties"`
}

func parseProperties(rd *bufio.Reader) []CSSProperty {
	properties := make([]CSSProperty, 0)
	property, _ := rd.ReadBytes('}')
	property = bytes.TrimSpace(property[:len(property)-1])
	for _, p := range bytes.Split(property, []byte{';'}) {
		p = bytes.TrimSpace(p)
		index := bytes.Index(p, []byte{':'})
		if index == -1 {
			continue
		}
		name := string(p[:index])
		if name == "" {
			continue
		}
		value := string(p[index+1:])
		properties = append(properties, CSSProperty{name, value})
	}
	return properties
}

func ParseCSS(css string) []CSSSelector {
	rd := bufio.NewReader(strings.NewReader(css))
	selectors := make([]CSSSelector, 0)
	for selector, e := rd.ReadBytes('{'); e == nil; selector, e = rd.ReadBytes('{') {
		selectorName := string(bytes.TrimSpace(selector[:len(selector)-1]))
		properties := parseProperties(rd)
		selectors = append(selectors, CSSSelector{selectorName, properties})
	}
	return selectors
}
