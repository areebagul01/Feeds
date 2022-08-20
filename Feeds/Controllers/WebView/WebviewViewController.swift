//
//  WebviewViewController.swift
//  Feeds
//
//  Created by Tabish on 7/20/22.
//

import UIKit
import WebKit

class WebviewViewController: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    var barTitle = "News Feed"
    var url: String?
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navTitle.title = barTitle
        webView.load(URLRequest(url: URL(string: url!)!))
    }
    @IBAction func backBtn(_ sender: Any) {
        completionHandler!("Hello")
        dismiss(animated: true, completion: nil)
    }
}
