//
//  ArticlesResponseModel.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

struct ArticlesResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
 
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String?
}
