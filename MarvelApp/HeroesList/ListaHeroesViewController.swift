//
//  ListaHeroesViewController.swift
//  MarvelApp
//
//  Created by juan ramon gonzalez on 12/11/2020.
//

import UIKit
import JGProgressHUD

class ListaHeroesViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var heroViewModel = HeroViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        spinner.show(in: view)
        print(heroViewModel.totalHero)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        loadData()
    }

    private func loadData() {
        heroViewModel.loadCharacters(offset: self.heroViewModel.offset) {
            result in
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if self.heroViewModel.numberOfRows(0) <
                self.heroViewModel.totalHero {
                self.heroViewModel.offset += 20
                self.loadData()
            }
        }
    }
    
    // Unión vista de Detalles

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detallesSegue" {
            prepareSegueForHeroDetailsViewController(segue: segue)
        }
    }
    
    private func prepareSegueForHeroDetailsViewController(segue: UIStoryboardSegue) {
        guard let heroDetailViewController = segue.destination as? DetallesHeroesViewController, let indexPath = self.collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        let hero = self.heroViewModel.heroAt(indexPath.row)
        heroDetailViewController.hero = hero
        
    }
}

// PROTOCOLOS COLLECTIONVIEW

extension ListaHeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.heroViewModel.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCell
        let hero = heroViewModel.heroAt(indexPath.row)
        
        cell.configure(hero)
        spinner.dismiss()
        return cell
    }
}


extension ListaHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 5.0, bottom: 1.0, right: 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 250)
    }
 
}

// PROTOCOLOS SEARCHBAR

extension ListaHeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.heroViewModel.searchByHeroName(name: searchText) { _ in
            print(self.heroViewModel.searchActive)
            if !self.heroViewModel.searchActive {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.searchBar.resignFirstResponder()
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}












