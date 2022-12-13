//
//  NewsListingViewModel.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

class NewsListingViewModel {
    
    var newsListingService: NewsListingWebService?
    
    init(newsListingService: NewsListingWebService) {
        self.newsListingService = newsListingService
    }
    
    func getNewsListing(country: String,
                        callback: @escaping ((ArticlesResponseModel?, Error?) -> Void)) {
        
        newsListingService?.getNewsListing(country: "us") {
            (articlesResponseModel, error) in
            callback(articlesResponseModel, error)
        }
    }
}


