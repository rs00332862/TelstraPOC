//
//  NetworkManager.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    func getDataFromWebService(completion: @escaping (Result<CategoryDataModel, Error>) -> Void) {
        
        guard let webServiceURL = URL.init(string: Constant.webServiceURL) else { return }
        URLSession.shared.dataTask(with: webServiceURL) { (data, response, error) in
            if let errorObject = error {
                print(errorObject.localizedDescription)
                completion(.failure(errorObject))
            } else {
                guard let data = data else { return }
                
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let responseData = try JSONDecoder().decode(CategoryDataModel.self, from: jsonString.data(using: .utf8)!)
                    completion(.success(responseData))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
