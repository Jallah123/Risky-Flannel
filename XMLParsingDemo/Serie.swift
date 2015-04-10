//
//  Serie.swift
//  XMLParsingDemo
//
//  Created by Joris Huijbregts on 09/04/2015.
//
//

import Foundation
class Serie {
    
    init() {
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
    
    var name: String!
    var id: String?
    var language: String?
    var banner: String?
    var overview: String?
    var firstAired: String!
    var network: String?
    var IMDB_ID: String?
    var seriesId: String!
    var rating: String?
    var status: String?
    var Seasons = [Season]()
}