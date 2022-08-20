//
//  ViewController.swift
//  Feeds
//
//  Created by Tabish on 7/19/22.
//

import UIKit
import Kingfisher

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]? = []
    
    let sources = ["TechCrunch", "TechRadar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let techCrunch = sources.first else { return }
        fetchArticles(of: techCrunch)
    }
    
    func fetchArticles(of source: String) {
        
        let url = "https://newsapi.org/v1/articles?source=\(source)&sortBy=top&apiKey=\(newsApiKey)"
        NetworkManager.shared.fetch(url: url) { (json, error) in
            if error == nil && json != nil {
                self.articles = [Article]()
                do {
                    let data = try JSONSerialization.data(withJSONObject: json!, options: [])
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
                    if let articlesFromJson = json["articles"] as? [[String: Any]] {
                        for articleFromJson in articlesFromJson {
                            let article = Article(json: articleFromJson)
                            self.articles?.append(article)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.separatorStyle = .singleLine
                            self.tableView.reloadData()
                        }
                    }
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    @IBAction func meunBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        guard let techCrunch = self.sources.first else { return }
        alert.addAction(UIAlertAction(title: techCrunch, style: .default, handler: { (action) in
            self.fetchArticles(of: techCrunch)
            alert.dismiss(animated: true, completion: nil)
        }))

        guard let techRadar = self.sources.last else { return }
        alert.addAction(UIAlertAction(title: techRadar, style: .default, handler: { (action) in
            self.fetchArticles(of: techRadar)
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.newsTitle.text = self.articles?[indexPath.item].title
        cell.newsDesc.text = self.articles?[indexPath.item].description
        cell.articleAuthor.text = self.articles?[indexPath.item].author
        let url = URL(string: self.articles?[indexPath.item].urlToImage ?? "")
        cell.newsImage.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebviewViewController
        webVc.url = self.articles?[indexPath.item].url
        
        webVc.completionHandler = { abc in
            print(abc)
        }
    
        webVc.modalPresentationStyle = .fullScreen
        self.present(webVc, animated: true, completion: nil)
    }
}
