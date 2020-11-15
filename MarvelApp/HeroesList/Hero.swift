//
//  Hero.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import Foundation

class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    private enum CodingKeys: CodingKey {
        case value
        }
    }

struct Hero: Decodable {
    let id: Dynamic<Int>
    let name: Dynamic<String>
    let description: Dynamic<String>
    let thumbnail: Thumbnail
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Dynamic(try container.decode(Int.self, forKey: .id))
        name = Dynamic(try container.decode(String.self, forKey: .name))
        description = Dynamic(try container.decode(String.self, forKey: .description))
        thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
}

struct HeroData: Decodable {
    let results: [Hero]
    let total: Dynamic<Int>
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Hero].self, forKey: .results)
        total = Dynamic(try container.decode(Int.self, forKey: .total))
    }
    
    private enum CodingKeys: String, CodingKey {
        case results
        case total
    }
}

struct HeroBase: Decodable {
    let data: HeroData
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(HeroData.self, forKey: .data)
    }
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

