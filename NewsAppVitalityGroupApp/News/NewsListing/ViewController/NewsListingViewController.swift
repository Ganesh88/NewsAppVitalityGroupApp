//
//  NewsListingViewController.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import UIKit

class NewsListingViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var newsListingViewModel: NewsListingViewModel?
    var articlesResponseModel: ArticlesResponseModel?
    
    let newsListingTableViewCellIdentifier = "NewsListingTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        newsListingViewModel = NewsListingViewModel(newsListingService: AppDelegate.getServiceFactory().getNewsListingService())
        getNewsListing()
    }
    
    private func setUpUI() {
        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getNewsListing() {
        newsListingViewModel?.getNewsListing(country: "us") {
            (articlesResponseModel, error) in
            print(articlesResponseModel?.articles?.count)
            self.articlesResponseModel = articlesResponseModel
            self.newsTableView.reloadData()
        }
    }
}

extension NewsListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesResponseModel?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsListingTableViewCell = tableView.dequeueReusableCell(withIdentifier: newsListingTableViewCellIdentifier, for: indexPath as IndexPath) as? NewsListingTableViewCell else { return UITableViewCell() }
        newsListingTableViewCell.configure(articleModel: articlesResponseModel?.articles?[indexPath.row])
        return newsListingTableViewCell
    }
    
    
}
