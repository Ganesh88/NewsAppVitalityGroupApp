//
//  NewsListingViewController.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import UIKit
import FirebaseAnalytics

class NewsListingViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var countrySelectPickerView: UIPickerView!
    
    var newsListingViewModel: NewsListingViewModel?
    var articlesResponseModel: ArticlesResponseModel?
    
    let newsListingTableViewCellIdentifier = "NewsListingTableViewCell"
    
    let countriesArray = [CountryModel(name: "Unites states", shortName: "US"),
                           CountryModel(name: "Canada", shortName: "CA")]
    
    
    let userDefaults = UserDefaults.standard
    var selectedCountry: CountryModel?
    
    private var pullToRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpTap()
        newsListingViewModel = NewsListingViewModel(newsListingService: AppDelegate.getServiceFactory().getNewsListingService())
        getNewsListing()
    }
    
    private func setUpUI() {
        title = NewsListingConstants.newsTitle
        newsTableView.estimatedRowHeight = 100
        newsTableView.rowHeight = UITableView.automaticDimension
        var countryTitle = "US"
        if !fetchCountry().isEmpty {
            countryTitle = fetchCountry()
        }
        let logButton : UIBarButtonItem = UIBarButtonItem(title: countryTitle,
                                                          style: UIBarButtonItem.Style.plain,
                                                          target: self,
                                                          action: #selector(rightButtonAction(sender:)))
        
        navigationItem.rightBarButtonItem = logButton
        setUpToolBar()
        setUpPullToRefreshControl()

    }
    
    private func setUpTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
                    tap.cancelsTouchesInView = false
                    view.addGestureRecognizer(tap)
    }
    
    @objc func handleTapGesture(sender: AnyObject) {
        if !countrySelectPickerView.isHidden {
            countrySelectPickerView.isHidden = true
        }
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        countrySelectPickerView.isHidden = false
    }
    
    
    func setUpToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: countrySelectPickerView.frame.size.width, height: 44))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.backgroundColor = .clear
        toolBar.barTintColor =  .systemGray

        let doneButton = UIBarButtonItem(title: "Select country for news",
                                         style: UIBarButtonItem.Style.done,
                                         target: self,
                                         action: #selector(donePicker))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        countrySelectPickerView.addSubview(toolBar)
            
    }
    
    @objc func donePicker() {
        countrySelectPickerView.isHidden = true
    }
    
    private func setUpPullToRefreshControl() {
        pullToRefreshControl.attributedTitle = NSAttributedString(string: NewsListingConstants.refreshNews)
        pullToRefreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        newsTableView.refreshControl = pullToRefreshControl
    }
    
    @objc private func refreshNews(_ sender: Any) {
        pullToRefreshControl.endRefreshing()
        getNewsListing()
    }
    
    private func getNewsListing() {
        newsListingViewModel?.getNewsListing(country: selectedCountry?.shortName ?? "us") {
            (articlesResponseModel, error) in
            if error != nil {
                self.logErrorInNewsLoadedEvent()
                CommonUtils.showGenericAlert(message: NewsListingConstants.newsFetchingErrorMessage, viewController: self)
            } else {
                self.logNewsLoadedEvent()
                self.articlesResponseModel = articlesResponseModel
                self.newsTableView.reloadData()
            }
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let newsDetailsVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsViewController" ) as? NewsDetailsViewController {
            newsDetailsVC.newsArticleModel =  articlesResponseModel?.articles?[indexPath.row]
            navigationController?.pushViewController(newsDetailsVC, animated: true)
        }
    }
}

extension NewsListingViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countriesArray.count
    }
//
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countriesArray[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        navigationItem.rightBarButtonItem?.title = countriesArray[row].shortName
        saveCountry(countryModel: countriesArray[row])
        countrySelectPickerView.isHidden = true
        getNewsListing()
    }
}

extension NewsListingViewController {
    
    func saveCountry(countryModel: CountryModel) {
        do {
            try userDefaults.setObject(countryModel, forKey: NewsListingConstants.selectedCountry)
            selectedCountry  = countryModel
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchCountry() -> String {
        do {
            let savedCountry = try userDefaults.getObject(forKey: NewsListingConstants.selectedCountry, castTo: CountryModel.self)
            selectedCountry  = savedCountry
            return savedCountry.shortName
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
}

extension NewsListingViewController {
    func logNewsLoadedEvent() {
        Analytics.logEvent("NewsLoaded", parameters:
                            [ "screenName": "NewsListingScreen",
                            "event": "ArticleLoaded"])
    }
    
    func logErrorInNewsLoadedEvent() {
        Analytics.logEvent("ErrorInNewsLoaded", parameters:
                            [ "screenName": "NewsListingScreen",
                            "event": "ErrorInNewsLoad"])
    }
    
    func logNewsDetailsEvent() {
        Analytics.logEvent("NewsDetails", parameters:
                            [ "screenName": "NewsListingScreen",
                            "event": "NewsDetailsTapped"])
    }
}
