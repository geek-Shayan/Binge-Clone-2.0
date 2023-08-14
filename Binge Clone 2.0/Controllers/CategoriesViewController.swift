//
//  CategoriesViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    static let identifier = "CategoriesViewController"

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var stopButton: UIButton!
    
    
    private let categoryNames = ["Action", "Comedy", "Fashion", "History", "Horror", "Kids", "Romance", "Fantasy/SCI-FI", "Drama", "Family", "Sports", "Thriller", "Crime", "Pop", "Music", "War", "Educational", "Tragedy", "Game", "Reality Show"]
    
    private var finalSelection = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "Binge"
        
        setupView()
        
        loadCategoriesCollection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func loadCategoriesCollection() {
        categoriesCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }
    
    private func setupView() {
//        self.navigationItem.hidesBackButton = true
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        self.navigationController?.isNavigationBarHidden = true


    }

    
    @IBAction func stopPressed(_ sender: Any) {
        print("skipPressed")
//        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.popViewController(animated: false)
//        self.navigationController?.dismiss(animated: false)
        self.dismiss(animated: false)
        
    }
    

}



extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath  \(indexPath)")
        let cell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        
        if cell.isSelected {
            finalSelection = categoryNames[indexPath.row]
            print("selected  \(finalSelection)")
            
            // pass to new vc / navbar
//            let navbar = storyboard?.instantiateViewController(withIdentifier: "CategoryViewNavigationController") as! UINavigationController
//            navbar.modalPresentationStyle = .overCurrentContext
//            navbar.modalTransitionStyle = .crossDissolve
//            self.present(navbar, animated: true)
            
            
            // pass to new vc / navbar
            let navbar = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewNavigationController") as! UINavigationController

            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
            vc.headersFootersData = SupplementaryDataType(header: finalSelection)
            vc.cellsData = [CellDataType(image: "image 70", label: "1"),
                            CellDataType(image: "image 5",  label: "2"),
    //                        CellDataType(image: "image 16", label: "3"),
    //                        CellDataType(image: "image 20", label: "4"),
    //                        CellDataType(image: "image 19", label: "5"),
    //                        CellDataType(image: "image 17", label: "6"),
    //                        CellDataType(image: "image 12", label: "7"),
    //                        CellDataType(image: "image 11", label: "8"),
    //                        CellDataType(image: "image 10", label: "9"),
                            CellDataType(image: "image 9",  label: "10"),
                            CellDataType(image: "image 6",  label: "11"),
                            CellDataType(image: "image 4",  label: "12"),
                            CellDataType(image: "image 2",  label: "13"),]
//            vc.modalPresentationStyle = .overCurrentContext
//            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true)

//            let nav = UINavigationController(rootViewController: vc)
//            nav.pushViewController(vc, animated: true)

//            navbar.pushViewController(vc, animated: true)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}



extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
    
        cell.setup(label: categoryNames[indexPath.row])

        return cell
    }
    
    
}
