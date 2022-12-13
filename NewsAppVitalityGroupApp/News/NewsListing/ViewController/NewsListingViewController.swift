//
//  NewsListingViewController.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import UIKit

class NewsListingViewController: UIViewController {
    
    var newsListingViewModel: NewsListingViewModel?
    var articlesResponseModel: ArticlesResponseModel?
    
    let newsListingTableViewCellIdentifier = "NewsListingTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        newsListingViewModel = NewsListingViewModel(newsListingService: AppDelegate.getServiceFactory().getNewsListingService())
        
        getNewsListing()
        
    }
    
    private func getNewsListing() {
        newsListingViewModel?.getNewsListing(country: "us") { (articlesResponseModel, error) in
            print(articlesResponseModel?.articles?.count)}
    }
}

extension NewsListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesResponseModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: newsListingTableViewCellIdentifier, for: indexPath as IndexPath) as? NewsListingTableViewCell else { return UITableViewCell() }
        return newsListingTableViewCell
    }
    
    
}
