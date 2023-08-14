//
//  GenreViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class GenreViewController: UIViewController {
    
    static let identifier = "GenreViewController"

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    
    private let genreNames = ["Action", "Comedy", "Fashion", "History", "Horror", "Kids", "Romance", "Fantasy/SCI-FI", "Drama", "Family", "Sports", "Thriller", "Crime", "Pop", "Music", "War", "Educational", "Tragedy", "Game", "Reality Show"]
    
    private var finalSelections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loadGenreCollection()
    }
    
    func loadGenreCollection() {
        genreCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        genreCollectionView.allowsMultipleSelection = true
    }
    
    private func setupView() {
        skipButton.layer.cornerRadius = 8
        skipButton.layer.borderWidth = 2
        skipButton.layer.borderColor = UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 1).cgColor

        continueButton.layer.cornerRadius = 8
        continueButton.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1) //gray
        continueButton.isUserInteractionEnabled = false
        
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        if continueButton.isUserInteractionEnabled {
            print("continuePressed")
            
            let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "UITabBarController") as! UITabBarController
            navigationController?.pushViewController(tabBarController, animated: true)
        }
        else {
            print("disabled")
        }
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        print("skipPressed")
        
        let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "UITabBarController") as! UITabBarController
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    

}



extension GenreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
        
        if cell.isSelected == true {
            cell.selected()
            
            finalSelections.append(genreNames[indexPath.row])
            print("append  \(finalSelections)")
            
            continueButton.backgroundColor = UIColor(red: 0.9, green: 0.04, blue: 0.08, alpha: 1)  //red
            
            continueButton.isUserInteractionEnabled = true

        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
        
        // last deselection, before emptying selection array
        if cell.isSelected == false && finalSelections.count == 1 {
            cell.deSelected()
            
            finalSelections.removeAll { $0 == genreNames[indexPath.row] } //(genreNames[indexPath.row])
            print("removed if  \(finalSelections)")
            
            continueButton.backgroundColor = UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 1) //gray
            continueButton.isUserInteractionEnabled = false
        }
        
        // normal deselection, selection array not empty
        else {
            cell.deSelected()
            
            finalSelections.removeAll { $0 == genreNames[indexPath.row] } //(genreNames[indexPath.row])
            print("removed else  \(finalSelections)")
        }

    }

}



extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        
        if cell.isSelected == true {
            cell.selected()
            cell.setup(label: genreNames[indexPath.row])
            return cell
        }
        
        else {
            cell.deSelected()
            cell.setup(label: genreNames[indexPath.row])
            return cell
        }
    }
    
    
}
