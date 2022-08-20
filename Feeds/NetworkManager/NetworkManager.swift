//
//  NetworkManager.swift
//  Feeds
//
//  Created by Tabish on 7/23/22.
//

import Foundation

class NetworkManager: NSObject {
    
    private override init() {
        super.init()
    }
    
    static let shared = NetworkManager()
    
    func fetch(url: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print("Error is:", error!)
                completionHandler(nil, error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                completionHandler(json, nil)
            }
            catch let error {
                print("Error is:", error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
