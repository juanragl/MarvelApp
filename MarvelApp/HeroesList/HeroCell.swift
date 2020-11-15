//
//  HeroCell.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 13/11/20.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    
    // CONFIGURACIÓN CELDA LISTA PERSONAJES
    
    func configure(_ hero: Hero) {
        self.layer.borderColor = UIColor.systemRed.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 5.0
        self.layer.masksToBounds = false
        
        let url = URL(string: hero.thumbnail.fullName)
        self.heroImage.kf.setImage(with: url)
        self.heroImage.layer.cornerRadius = 20
        
        hero.name.bind { self.heroName.text = $0}
        self.heroName.layer.cornerRadius = 20
        
       
        
        
    }
    
    
}
