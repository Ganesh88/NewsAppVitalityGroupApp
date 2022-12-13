//
//  NewsListingWebService.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

protocol NewsListingWebService {
    func getNewsListing(searchString: String,
                       page: Int,
                       callback: @escaping ((ArticlesResponseModel?, Error?) -> Void)) -> Void
}
