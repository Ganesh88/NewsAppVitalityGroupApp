//
//  NewsListingWebServiceCalls.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

class NewsListingWebServiceCalls: NewsListingWebService {
    func getNewsListing(country: String,
                        callback: @escaping ((ArticlesResponseModel?, Error?) -> Void)) {
        
        let networkManager = NetworkManager()
        
        let queryParams = (String(format:APIConstants.NewsListing.queryParameters,
                          "us",
                                  APIConstants.AppRequired.APIKey
                          ))
        var urlString = APIConstants.AppRequired.basisURL + APIConstants.NewsListing.headlinesEndPoint + queryParams
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        let url = URL(string: urlString)
        guard let url else { return }
        networkManager.request(fromURL: url) { (result: Result<ArticlesResponseModel, Error>) in
            switch result {
            case .success(let articlesResponseModel):
                debugPrint("We got a successful result with \(String(describing: articlesResponseModel.articles?.count)) articles.")
                callback(articlesResponseModel, nil)
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
            }
         }
    }
    
}
