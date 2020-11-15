//
//  HeroeViewModel.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import Foundation

class HeroViewModel {
    
    private var heroes: [Hero] = []
    private var filteredHeroes: [Hero] = []
    
    var totalHero: Int = 0
    var offset: Int = 0
    var searchActive: Bool = false
    
    func numberOfRows(_ section: Int) -> Int {
        if searchActive {
            return self.filteredHeroes.count
        }
        return self.heroes.count
    }
    
    func heroAt(_ index:Int) -> Hero {
        if searchActive {
            return self.filteredHeroes[index]
        }
        return self.heroes[index]
    }
    
    func loadCharacters(offset: Int, completion: @escaping([Hero]) -> ()) {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters"
        let heroesResource = Resource<HeroBase>(url: heroesUrl, offset: offset, heroName: nil) { data in
            let heroData = try? JSONDecoder().decode(HeroBase.self, from: data)
            return heroData
        }
        
        ConnectionManager().load(resource: heroesResource) { result in
            if let heroData = result {
                self.updateHero(characters: heroData.data.results)
                heroData.data.total.bind { self.totalHero = $0 }
                completion(self.heroes)
            } else {
                completion([Hero]())
            }
        }
    }
    
    func searchByHeroName(name: String, completion: @escaping([Hero]) -> ()) {
    
    if !name.isEmpty {
        let heroesUrl = "https://gateway.marvel.com/v1/public/characters"
        let heroesResource = Resource<HeroBase>(url: heroesUrl, offset: offset, heroName: name) { data in
            let heroData = try? JSONDecoder().decode(HeroBase.self, from: data)
            return heroData
        }
        
        ConnectionManager().load(resource: heroesResource) { result in
            if let heroData = result {
                self.searchActive = true
                self.filteredHeroes = heroData.data.results
                heroData.data.total.bind { self.totalHero = $0 }
                completion(self.filteredHeroes)
            } else {
                completion([Hero]())
            }
        }
        
    
    } else {
        self.searchActive = false
        completion(self.heroes)
    }
    }
    
    func updateHero(characters: [Hero]) {
        for character in characters {
            if !self.heroes.contains(where: { $0.id.value == character.id.value }) {
                self.heroes.append(character)
            }
        }
    }
    
    
}
