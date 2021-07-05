//
//  NewsViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newsTitle: UILabel!
    
    private var newsList = NewslistModel()
    private let cellIdentifier = "NewsTableViewCell"
    private let headerIdentifier = "NewsHeaderView"
    
    //MARK:- Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpTableView()
        getNewsList()
    }
    
    //MARK:- ViewwillAppear
    override func viewWillAppear(_ animated: Bool) {
         self.title = "Covid Reports".localizableString()
        setUpView()
        tableView.reloadData()
    }
    
    // MARK:- Register tableview cell
    private func setUpTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
    }
    
    // MARK:- SetUp view properties/titles
    private func setUpView() {
        newsTitle.text = "newsTitle".localizableString()
    }

}

// MARK:- Tableview datasource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.getCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsTableViewCell
        if let countries = newsList.getCountries?[indexPath.row] {
            cell.configureCell(countryDetail: countries)
        }
        cell.setUpView()
        return cell
    }
}

// MARK:- Tableview delegates
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! NewsHeaderView
        if let globalDetail = newsList.getGlobal {
            headerView.configureCell(globalDetail: globalDetail)
        }
        headerView.setUpView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

extension NewsViewController {
    
    // MARK:- News list api function
    private func getNewsList() {
        let urlString = "https://api.covid19api.com/summary"
        
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let jsonData = data else { return }
            
            do {
                let newsList = try JSONDecoder().decode(NewslistModel.self, from: jsonData)
                self.newsList = newsList
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            } catch _{ }
            
        })
        task.resume()
    }
}
