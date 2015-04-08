//
//  parser.swift
//  XMLParsingDemo
//
//  Created by Jelle van Es on 08/04/15.
//  Copyright (c) 2015 TheAppGuruz-New-6. All rights reserved.
//

import Foundation

class Parser: NSObject, NSXMLParserDelegate {

var parser = NSXMLParser()
var series = NSMutableArray()
var elements = NSMutableDictionary()
var element = NSString()
var title1 = NSMutableString()
var date = NSMutableString()
var id = NSMutableString()

//XMLParser Methods
func beginParsing(data: NSData) -> (NSMutableArray)
{
    series = []
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return series
}



func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
{
    element = elementName
    if (elementName as NSString).isEqualToString("Series")
    {
        elements = NSMutableDictionary.alloc()
        elements = [:]
        title1 = NSMutableString.alloc()
        title1 = ""
        date = NSMutableString.alloc()
        date = ""
        id = NSMutableString.alloc()
        id = ""
    }
}

func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
{
    if (elementName as NSString).isEqualToString("Series") {
        if !title1.isEqual(nil) {
            elements.setObject(title1, forKey: "SeriesName")
        }
        if !date.isEqual(nil) {
            elements.setObject(date, forKey: "FirstAired")
        }
        if !id.isEqual(nil) {
            elements.setObject(id, forKey: "SeriesID")
        }
        series.addObject(elements)
    }
}

func parser(parser: NSXMLParser!, foundCharacters string: String!)
{
    element = element.lowercaseString
    if element == "seriesname" {
        title1.appendString(string)
    } else if element == "firstaired" {
        date.appendString(string)
    } else if element == "seriesid" {
        id.appendString(string)
    }
}
}
