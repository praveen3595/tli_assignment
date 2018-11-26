//
//  DetailNewViewController.swift
//  TLI
//
//  Created by Praveen Singh on 26/11/18.
//  Copyright © 2018 Praveen Singh. All rights reserved.
//

import UIKit

class DetailNewsViewController: UITableViewController {

    //MARK: Outlets
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var detailNewsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Properties
    var news: News? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 180
        self.tableView.rowHeight = UITableView.automaticDimension
        if let news = news {
            detailNewsLabel.text = news.newsContent
            titleLabel.text = news.newsTitle
            let hdImageURL = news.newsImageUrl
            let hdImageURLString = String(describing: hdImageURL).replacingOccurrences(of: "thumbStandard", with: "square320")
            let url = URL(string: hdImageURLString)
            NetworkManager.fetchNYTNews(with: url!, completion: { (data) in
                DispatchQueue.main.async {
                    self.newImage.image = UIImage(data: data)
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
