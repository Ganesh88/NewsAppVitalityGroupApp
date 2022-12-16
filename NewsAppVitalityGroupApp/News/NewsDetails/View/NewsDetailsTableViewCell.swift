//
//  NewsDetailsTableViewCell.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 16/12/22.
//

import UIKit
import SDWebImage

class NewsDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsPublishedAtLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(newsArticleModel: Article?) {
        newsDescriptionLabel.text = newsArticleModel?.description
        newsPublishedAtLabel.text =  CommonUtils.getFormattedDate(serverTime: newsArticleModel?.publishedAt ?? "", fromFormat: "yyyy-MM-dd'T'HH:mm:ssZ", toFormat: "HH:mm E, d MMM y")
        newsAuthorLabel.text = newsArticleModel?.author
        newsContentLabel.text = newsArticleModel?.content
        newsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let articleImageURL = URL(string: newsArticleModel?.urlToImage ?? "") {
            newsImageView.sd_setImage(with:  articleImageURL, placeholderImage: UIImage(named: "placeholder"))
        }
    }

}
