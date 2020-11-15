//
//  DetallesHeroesViewController.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import UIKit
import JGProgressHUD

class DetallesHeroesViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var comicViewModel = ComicViewModel()
    private var heroId: Int = 0
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.show(in: view)
        heroImage.layer.cornerRadius = 20
        heroImage.layer.masksToBounds = true
        heroImage.layer.shadowColor = UIColor.black.cgColor
        heroImage.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        heroImage.layer.shadowRadius = 3.0
        heroImage.layer.shadowOpacity = 5.0
        heroImage.layer.masksToBounds = false

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        setupDatas()
        
    }
    
    private func setupDatas() {
        if let hero = self.hero {
            hero.name.bind { self.heroName.text = $0}
            hero.description.bind { self.heroDescription.text = $0 }
            hero.id.bind { self.heroId = $0 }
            
            let url = URL(string: (hero.thumbnail.fullName))
            self.heroImage.kf.setImage(with: url)
            
            loadData()
        }
    }

    private func loadData() {
        self.comicViewModel.loadComics(heroId: self.heroId) { result in
            self.collectionView.reloadData()
        }
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.comicViewModel.numberOfRows(0) < self.comicViewModel.totalComics {
                self.comicViewModel.offset += 20
                self.loadData()
            }
        }
    }

}

// Protocolos CollectionView

extension DetallesHeroesViewController: UICollectionViewDelegate {
    
}

extension DetallesHeroesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comicViewModel.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "comicCell", for: indexPath) as! ComicCell
        
        let comic = comicViewModel.comicAt(indexPath.row)
        cell.configure(comic)
        
        spinner.dismiss()
        return cell
    }
}

extension DetallesHeroesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 8.0, bottom: 3.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 200)
    }
}
