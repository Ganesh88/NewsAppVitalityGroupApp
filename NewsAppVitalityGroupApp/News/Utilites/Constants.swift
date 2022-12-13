//
//  Constants.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

struct APIConstants {
    struct AppRequired {
        static let APIKey = "6b003acc0bf4483ba25c0fb01bb0c415"
        static let basisURL = "https://newsapi.org/"
    }
    
    struct NewsListing {
        static let headlinesEndPoint = "v2/top-headlines"
        static let queryParameters = "?country=%@&apiKey=%@"
    }
}

