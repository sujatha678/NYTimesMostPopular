//
//  ViewController.swift
//  NYTimesMostPopular
//
//  Created by SriSarayu on 18/11/18.
//  Copyright © 2018 Sujatha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let network = NetworkManager.sharedInstance
    @IBOutlet weak var articlesTableView: UITableView?
    
    var articles = [ArticleData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nstatus: NetworkStatus = .reachable
        network.reachability.whenUnreachable = { reachability in
            nstatus = .notReachable
        }
        self.configureTableView()
        self.updatestatus(nstatus)
        // Do any additional setup after loading the view, typically from a nib.
    }

     func updatestatus(_ status: NetworkStatus) {
        if status == .notReachable {
            Utils.showAlert(title: "Alert!", message: "Please check your internet connection", viewController: self)
            
            Utils.stopActivityIndicator()
        } else {
            if articles.count == 0 {
                // Calling API
                self.getArticlesData()

            } else {
                //Just reload if already Articles are loaded
                self.articlesTableView?.reloadData()
            }
        }
        
    }
    //Configure TableView 
    func configureTableView() {
        //Register Cell
        articlesTableView?.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        //Assigning Delegate and DataSource for tableview
        articlesTableView?.dataSource = self
        articlesTableView?.delegate = self
    }
    
    
    func getArticlesData(){
        Utils.showActivityIndicator(viewController: self)

        APIManager.getNYTimesData(){[weak self] (result, error) in
            guard error == nil, let results = result as? [ArticleData] else {
                self?.articlesTableView?.reloadData()
                return
            }
            Utils.stopActivityIndicator()

            //let results = result as? [ArticleData]
            self?.articles = results
            self?.articlesTableView?.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        guard articles.count > 0 else{
            return 44
        }
        let height : CGFloat = Utils.getHeight(article: articles[indexPath.row])
        return height
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let article = articles[indexPath.row]
        self.performSegue(withIdentifier: "ArticleDetailVC", sender: article)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? ArticleDetailViewController, let article = sender as? ArticleData {
            detailViewController.article = article
        }
    }
    
}

