//
//  NewsDetailsViewController.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 16/12/22.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var newsArticleModel: Article?
    let NewsDetailsTableViewCellIdentifier = "NewsDetailsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsDetailsTableViewCellIdentifier, for: indexPath as IndexPath) as? NewsDetailsTableViewCell else { return UITableViewCell() }
        newsDetailsTableViewCell.configure(newsArticleModel: newsArticleModel)
        return newsDetailsTableViewCell
    }
}
