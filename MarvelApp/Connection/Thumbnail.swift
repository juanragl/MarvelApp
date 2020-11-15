//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import Foundation

class Thumbnail: Decodable {
    private let path: String
    private let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    init(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
    
    required init(from decoder: Decoder) throws {
        let allValues = try decoder.container(keyedBy: CodingKeys.self)
        path = try allValues.decode(String.self, forKey: .path)
        ext = try allValues.decode(String.self, forKey: .ext)
    }
    
    var fullName: String {
        get { return path + "." + ext }
    }
}
