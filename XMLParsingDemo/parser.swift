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
var element = NSString()
var tempSerie = Serie()
var tempEpisode = Episode()
var series = [Serie]()
var episodesBegon = false
    
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
        tempSerie = Serie()
    } else if (elementName as NSString).lowercaseString == "episode" {
        tempEpisode = Episode()
        episodesBegon = true
    }
}
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        element = element.lowercaseString
        if !episodesBegon {
            switch element {
            case "seriesname":
                tempSerie.name! += string
            case "firstaired":
                tempSerie.firstAired! += string
            case "seriesid":
                tempSerie.seriesId! += string
            case "language":
                tempSerie.language! += string
            case "banner":
                tempSerie.banner! += string
            case "overview":
                tempSerie.overview! += string
            case "network":
                tempSerie.network! += string
            case "imdb_id":
                tempSerie.IMDB_ID! += string
            case "id":
                tempSerie.id! += string
            case "rating":
                tempSerie.rating! += string
            case "status":
                tempSerie.status! += string
            default:
                break
            }
        }else {
            switch element {
            case "id":
                tempEpisode.id? += string
            case "episodename":
                tempEpisode.name? += string
            case "firstaired":
                tempEpisode.firstAired? += string
            case "overview":
                tempEpisode.overview? += string
            case "rating":
                tempEpisode.rating? += string
            case "lastupdated":
                tempEpisode.lastUpdated? += string
            case "seasonid":
                tempEpisode.seasonId? += string.toInt()!
            case "seriesid":
                tempEpisode.seriesId? += string.toInt()!
            case "seasonnumber":
                break
//                if series[0].Seasons.count == 0 {
//                    let s = Season()
//                    s.id? += string.toInt()!
//                    series[0].Seasons.append(s)
//                }
//                var seasonExists = false
//                for s in series[0].Seasons {
//                    if s.id == string!.toInt() {
//                        if string!.toInt() != nil {
//                            s.episodes.append(tempEpisode)
//                            seasonExists = true
//                        }
//                    }
//                }
//                if !seasonExists {
//                    let s = Season()
//                    s.id? += string.toInt()!
//                    series[0].Seasons.append(s)
//                    s.episodes.append(tempEpisode)
//                }
            default:
                return
            }
        }
    }

func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
{
    if (elementName as NSString).lowercaseString == "series" {
        series.append(tempSerie)
    }
}

}
