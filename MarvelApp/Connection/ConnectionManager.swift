//
//  ConnectionManager.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import Foundation
import CryptoSwift

struct Resource<T> {
    let url: String
    let offset: Int
    let heroName: String?
    let parse: (Data) -> T?
}

fileprivate struct MarvelAPIConfig {
    static let privateKey = "e7269cf18fc45d63893b9805ef27899a15ec2cce"
    static let apikey = "3508ef7ac1a81a4bcb618ca4a8394157"
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privateKey)\(apikey)".md5()
}

// Conexión a API MARVEL

final class ConnectionManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        var characteresURL = URLComponents(string: resource.url)!
        characteresURL.queryItems = [URLQueryItem(name: "apikey", value: MarvelAPIConfig.apikey),
                                     URLQueryItem(name: "ts", value: MarvelAPIConfig.ts),
                                     URLQueryItem(name: "hash", value: MarvelAPIConfig.hash)]
        
        if resource.heroName != nil {
            characteresURL.queryItems?.append(URLQueryItem(name: "nameStartsWith", value: resource.heroName))
            characteresURL.queryItems?.append(URLQueryItem(name: "limit", value: "\(100)"))
        } else {
            characteresURL.queryItems?.append(URLQueryItem(name: "offset", value: "\(resource.offset)"))
        }
        
        let finalURL = characteresURL.url
        var request = URLRequest(url: finalURL!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
        
        }
    
    private func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
}
