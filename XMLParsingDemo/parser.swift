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
var elements = NSMutableDictionary()
var element = NSString()
var tempSerie = Serie()
var tempEpisode = Episode()
var series = [Serie]()
    
//XMLParser Methods
func beginParsing(data: NSData) -> ([Serie])
{
    series = [Serie]()
    parser = NSXMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return series
}



func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
{
    element = elementName.lowercaseString
    if (elementName as NSString).lowercaseString == "series"
    {
        elements = NSMutableDictionary.alloc()
        elements = [:]
        tempSerie = Serie()
    } else if (elementName as NSString).lowercaseString == "episode" {
        tempEpisode = Episode()
    }
}
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        element = element.lowercaseString
        if element == "seriesname" {
            tempSerie.name! += string
        } else if element == "firstaired" {
            tempSerie.firstAired! += string
        } else if element == "seriesid" {
            tempSerie.seriesId! += string
        }
    }

func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
{
    if (elementName as NSString).lowercaseString == "series" {
        series.append(tempSerie)
    }
}

}
