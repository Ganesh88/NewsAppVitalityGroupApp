//
//  NewsListingViewController.swift
//  NewsAppVitalityGroupApp
//
//  Created by Ganesh Pathe on 13/12/22.
//

import UIKit

class NewsListingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        AppDelegate.getServiceFactory().getNewsListingService().getNewsListing(searchString: "",
                                           page: 1,
                                           callback: { (eventsResponseModel, error) in
                                                        print(eventsResponseModel?.articles?.count)
                                           })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
