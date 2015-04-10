//
//  Serie.swift
//  XMLParsingDemo
//
//  Created by Joris Huijbregts on 09/04/2015.
//
//

import Foundation
class Serie: NSObject {
    
    override init() {
        super.init()
        self.name = ""
        self.seriesId = ""
        self.firstAired = ""
        self.language = ""
        self.overview = ""
        self.rating = ""
        self.status = ""
        self.IMDB_ID = ""
        self.network = ""
        self.id = ""
        self.banner = ""
        
    }
    
    
    var name: NSString!
    var id: NSString?
    var language: NSString?
    var banner: NSString?
    var overview: NSString?
    var firstAired: NSString!
    var network: NSString?
    var IMDB_ID: NSString?
    var seriesId: NSString!
    var rating: NSString?
    var status: NSString?
//    var Seasons = [Season]()
}