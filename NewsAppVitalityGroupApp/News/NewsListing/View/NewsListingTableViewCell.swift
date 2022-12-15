//
//  NewsListingTableViewCell.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import UIKit
import SDWebImage

class NewsListingTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(articleModel: Article?)  {
        newsTitle.text = articleModel?.title
        newsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let articleImageURL = URL(string: articleModel?.urlToImage ?? "") {
            newsImageView.sd_setImage(with:  articleImageURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
