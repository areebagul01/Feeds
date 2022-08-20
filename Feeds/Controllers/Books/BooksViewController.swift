//
//  BooksViewController.swift
//  Feeds
//
//  Created by Tabish on 7/23/22.
//

import UIKit
import Kingfisher

class BooksViewController: UIViewController, UISearchBarDelegate {

    var books = [Books]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        fetchBooks(search: "Read")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let search = searchBar.text else { return }
        if search == "" {
            fetchBooks(search: "Read")
        }
        else {
            fetchBooks(search: search)
        }
    }
    
    func fetchBooks(search: String) {
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(search)&key=\(googleApiKey)"
        NetworkManager.shared.fetch(url: url) { (json, error) in
            if error == nil && json != nil {
                let dic = json as? [String: Any]
                guard let itemDic = dic?["items"] as? [[String: Any]] else { return }
                print(itemDic)
                do {
                    let itemsData = try JSONSerialization.data(withJSONObject: itemDic, options: [])
                    self.books = try JSONDecoder().decode([Books].self, from: itemsData)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
                catch let error {
                    print("Error is ", error)
                }
            }
        }
    }
}

extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "book", for: indexPath) as! BookCell
        guard let book = books[indexPath.row].volumeInfo else { return UICollectionViewCell() }
        cell.bookImage.kf.setImage(with: URL(string: book.imageLinks?.smallThumbnail ?? ""))
        cell.bookName.text = book.title
        cell.bookAuthor.text = book.authors?.first
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = UIScreen.main.bounds.width/2 - 3
        return CGSize(width: itemSize, height: itemSize + 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let descVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "describe") as! DescriptionPageViewController
        descVc.book = self.books[indexPath.item]
        
        descVc.modalPresentationStyle = .fullScreen
        self.present(descVc, animated: true, completion: nil)
    }
}
