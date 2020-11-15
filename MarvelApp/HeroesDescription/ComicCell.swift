//
//  ComicCell.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 14/11/20.
//

import UIKit

class ComicCell: UICollectionViewCell {
    
    @IBOutlet weak var comicImage: UIImageView!
    
    @IBOutlet weak var comicName: UILabel!
    
    // Configuración celda Detalles Peronajes
    
    func configure(_ comic: Comic) {
        self.layer.borderColor = UIColor.systemRed.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 5.0
        self.layer.masksToBounds = false
        
        let url = URL(string: comic.thumbnail.fullName)
        self.comicImage.kf.setImage(with: url)
        self.comicImage.layer.cornerRadius = 5
        self.comicName.text = comic.title
        
    }
    
}
