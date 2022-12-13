//
//  NewsListingWebService.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

protocol NewsListingWebService {
    func getNewsListing(country: String,
                       callback: @escaping ((ArticlesResponseModel?, Error?) -> Void))
}
