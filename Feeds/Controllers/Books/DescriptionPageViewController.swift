//
//  DescriptionPageViewController.swift
//  Feeds
//
//  Created by Tabish on 7/26/22.
//

import UIKit

class DescriptionPageViewController: UIViewController {
    
    @IBOutlet weak var imageBook: UIImageView!
    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var descHeading: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    var book: Books?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let bookData = book?.volumeInfo else { return }
        imageBook.kf.setImage(with: URL(string: bookData.imageLinks?.smallThumbnail ?? ""))
        titleBook.text = bookData.title
        subTitle.text = bookData.subtitle
        author.text = "Authors: \(bookData.authors?.first ?? ""), \(bookData.authors?.last ?? "")"
        publisher.text = "Publisher: \(bookData.publisher ?? "")"
        publishDate.text = "Published: \(bookData.publishedDate ?? "")"
        categories.text = "\(bookData.categories?.first ?? "")"
        if let pgCount = bookData.pageCount {
            if pgCount != 0 {
                pageCount.text = "Pages: \(bookData.pageCount ?? 0)"
            }
            else {
                pageCount.text = ""
            }
        }
        else {
            pageCount.text = ""
        }
        descText.text = bookData.description
    }
    
    @IBAction func previewBtn(_ sender: Any) {
        let webVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web") as! WebviewViewController
        guard let title = self.book?.volumeInfo?.title else { return }
        webVc.barTitle = title
        webVc.url = self.book?.volumeInfo?.previewLink
        
        webVc.completionHandler = { abc in
            print(abc)
        }
    
        webVc.modalPresentationStyle = .fullScreen
        self.present(webVc, animated: true, completion: nil)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
