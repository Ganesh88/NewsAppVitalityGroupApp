//
//  NewsListViewModelTests.swift
//  NewsAppVitalityGroupAppTests
//
//  Created by Ganesh Pathe on 16/12/22.
//

import XCTest

class NewsListingWebServiceCallsMock: NewsListingWebService {
    var isFetchNewsListCalled = false
    var completeClosure: ((Bool, ArticlesResponseModel, Error?) -> ())!
    
    func getNewsListing(country: String,
                        callback: @escaping ((ArticlesResponseModel?, Error?) -> Void)) {
        isFetchNewsListCalled = true
    }
    
    func fetchSuccess() {
        completeClosure( true, ArticlesResponseModel(), nil )
    }
        
    func fetchFail(error: Error?) {
        completeClosure( false, ArticlesResponseModel(), error )
    }
}

final class NewsListViewModelTests: XCTestCase {
    var newsListingWebServiceCallsMock = NewsListingWebServiceCallsMock()
    var newsListViewModel: NewsListingViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsListViewModel = NewsListingViewModel(newsListingService: newsListingWebServiceCallsMock)
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    override func tearDown() {
        newsListViewModel = nil
        super.tearDown()
    }
    
    func testGetNewsList() {
        newsListViewModel?.getNewsListing(country: "us") {
            (articleResponse, error) in
        }
        
        XCTAssert(newsListingWebServiceCallsMock.isFetchNewsListCalled)
    }
    
}
