//
//  ComicViewModel.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 14/11/20.
//

import Foundation

class ComicViewModel {
    private var comics: [Comic] = []
    
    var totalComics: Int = 0
    var offset: Int = 0
    
    func numberOfRows(_ section: Int) -> Int {
        return self.comics.count
    }
    
    func comicAt(_ index: Int) -> Comic {
        return self.comics[index]
    }
    
    func addComics(comics: [Comic]) {
        self.comics.append(contentsOf: comics)
    }
    
    func loadComics(heroId: Int, completion: @escaping([Comic]) -> ()) {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters/\(heroId)/comics"
        
        let comicsResource = Resource<ComicBase>(url: heroesUrl, offset: self.offset, heroName: nil) { data in
            let comicData = try? JSONDecoder().decode(ComicBase.self, from: data)
            return comicData
        }
        
        ConnectionManager().load(resource: comicsResource) { result in
            if let comicData = result {
                self.addComics(comics: comicData.data.results)
                self.totalComics = comicData.data.total
                completion(self.comics)
            } else {
                completion([Comic]())
            }
        }
    }
}
