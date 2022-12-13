//
//  ServiceFactory.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import Foundation

class ServiceFactory: IServiceFactory {
    
    func getNewsListingService() -> NewsListingWebService {
        NewsListingWebServiceCalls()
    }
}
