//
//  CategoryViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class CategoryViewController: UIViewController {
    
    static let identifier = "CategoryViewController"

    @IBOutlet weak var navView: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navLabel: UILabel!
    @IBOutlet weak var castButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var dataset = String()
    var headersFootersData = SupplementaryDataType() //SupplementaryDataType(header: "Sports", footer: "")
    var cellsData = [CellDataType]()
//    var cellsData = [
//        CellDataType(image: "image 70", label: "1"),
//        CellDataType(image: "image 5",  label: "2"),
//        CellDataType(image: "image 16", label: "3"),
//        CellDataType(image: "image 20", label: "4"),
//        CellDataType(image: "image 19", label: "5"),
//        CellDataType(image: "image 17", label: "6"),
//        CellDataType(image: "image 12", label: "7"),
//        CellDataType(image: "image 11", label: "8"),
//        CellDataType(image: "image 10", label: "9"),
//        CellDataType(image: "image 9",  label: "10"),
//        CellDataType(image: "image 6",  label: "11"),
//        CellDataType(image: "image 4",  label: "12"),
//        CellDataType(image: "image 2",  label: "13"),
//    ]
//
//    private var sectionHeadersFooters: [SupplementaryDataType] = [SupplementaryDataType(header: "Sports", footer: ""),
//                                                                  SupplementaryDataType(header: "Sports", footer: ""),
//                                                                  SupplementaryDataType(header: "Sports", footer: "E"),
//                                                                  SupplementaryDataType(header: "News (Free: Robi Data, Mob App)", footer: "R"),
//                                                                  SupplementaryDataType(header: "Entertainment", footer: "R"),
//                                                                  SupplementaryDataType(header: "Local TV (Free: Robi Data, Mob App)", footer: "R"),
//                                                                  SupplementaryDataType(header: "Movies", footer: ""),
//                                                                  SupplementaryDataType(header: "Music", footer: ""),
//                                                                  SupplementaryDataType(header: "Kids", footer: ""),
//                                                                  SupplementaryDataType(header: "Infotainment", footer: ""),
//                                                                  SupplementaryDataType(header: "Religious", footer: "")]
//
//
//    private var sectionData3: [CellDataType] = [
//                                                CellDataType(image: "image 20", label: "1"),
//                                                CellDataType(image: "image 5",  label: "2"),
//                                                CellDataType(image: "image 16", label: "3"),
//                                                CellDataType(image: "image 70", label: "4"),
//                                                CellDataType(image: "image 19", label: "5"),
//                                                CellDataType(image: "image 17", label: "6"),
//                                                CellDataType(image: "image 12", label: "7"),
//                                                CellDataType(image: "image 11", label: "8"),
//                                                CellDataType(image: "image 10", label: "9"),
//                                                CellDataType(image: "image 9",  label: "10"),
//                                                CellDataType(image: "image 6",  label: "11"),
//                                                CellDataType(image: "image 4",  label: "12"),
//                                                CellDataType(image: "image 2",  label: "13"),
//                                                CellDataType(image: "image 20", label: "1"),
//                                                CellDataType(image: "image 5",  label: "2"),
//                                                CellDataType(image: "image 16", label: "3"),
//                                                CellDataType(image: "image 70", label: "4"),
//                                                CellDataType(image: "image 19", label: "5"),
//                                                CellDataType(image: "image 17", label: "6"),
//                                                CellDataType(image: "image 12", label: "7"),
//                                                CellDataType(image: "image 11", label: "8"),
//                                                CellDataType(image: "image 10", label: "9"),
//                                                CellDataType(image: "image 9",  label: "10"),
//                                                CellDataType(image: "image 6",  label: "11"),
//                                                CellDataType(image: "image 4",  label: "12"),
//                                                CellDataType(image: "image 2",  label: "13"),
//                                                CellDataType(image: "image 20", label: "1"),
//                                                CellDataType(image: "image 5",  label: "2"),
//                                                CellDataType(image: "image 16", label: "3"),
//                                                CellDataType(image: "image 70", label: "4"),
//                                                CellDataType(image: "image 19", label: "5"),
//                                                CellDataType(image: "image 17", label: "6"),
//                                                CellDataType(image: "image 12", label: "7"),
//                                                CellDataType(image: "image 11", label: "8"),
//                                                CellDataType(image: "image 10", label: "9"),
//                                                CellDataType(image: "image 9",  label: "10"),
//                                                CellDataType(image: "image 6",  label: "11"),
//                                                CellDataType(image: "image 4",  label: "12"),
//                                                CellDataType(image: "image 2",  label: "13"),
//
//                                                CellDataType(image: "Desh-TV_110x110", label: ""),
//                                                CellDataType(image: "CHANNEL-I-HD_110x110", label: ""),
//                                                CellDataType(image: "RTV-HD_110x110", label: ""),
//                                                CellDataType(image: "Ekattor-HD_110x110", label: ""),
//                                                CellDataType(image: "Somoy-News_110x110", label: ""),
//                                                CellDataType(image: "Independent-TV_110x110", label: ""),
//                                                CellDataType(image: "Bijoy-TV_110x110", label: ""),
//                                                CellDataType(image: "Channel-24_110x110", label: ""),
//                                                CellDataType(image: "NTV_110x110", label: ""),
//                                                CellDataType(image: "Desh-TV_110x110", label: ""),
//                                                CellDataType(image: "Ekattor-HD_110x110", label: ""),
//                                                CellDataType(image: "Somoy-News_110x110", label: ""),
//                                                CellDataType(image: "Independent-TV_110x110", label: ""),
//                                                CellDataType(image: "Bijoy-TV_110x110", label: ""),
//                                                CellDataType(image: "Channel-24_110x110", label: ""),
//                                                CellDataType(image: "RTV-HD_110x110", label: ""),
//                                                CellDataType(image: "Ekattor-HD_110x110", label: ""),
//                                                CellDataType(image: "Somoy-News_110x110", label: "")]
    
    
    static let headerKind = "headerKind"
    static let footerKind = "footerKind"
    
    private let collectionView: UICollectionView = {

        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            print("first ...")
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33) , heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 8
            item.contentInsets.bottom = 8
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.trailing = 4
//            section.contentInsets.bottom = 16
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(60))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
            section.boundarySupplementaryItems = [header] //, footer
            
            return section

        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        collection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: CategoryViewController.headerKind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier)
        collection.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: CategoryViewController.footerKind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier)
                                                                                       
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollectionView()
        
        self.navigationController?.isNavigationBarHidden = true
        
        title = "Binge"
        
        navLabel.text = "Category"

    }
    
    func loadCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
 
        containerView.addSubview(collectionView)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = containerView.bounds
    }
    
    @objc private func pullDownToRefresh() {
        print("Refresh")
        
//        selectedItem = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
//        navigationController?.isNavigationBarHidden = false
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt  \(indexPath)")
        if indexPath.section == 0 {
//            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            
            //send to new vc
            let vc = UIViewController()
            vc.view.backgroundColor = .orange
            
            self.navigationController?.isNavigationBarHidden = false

            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sectionData3.count
        return cellsData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        print("supp indexPath row, section, item", indexPath.row, indexPath.section, indexPath.item)
        switch kind {
            case CategoryViewController.headerKind:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                header.setup(head: headersFootersData.header, font: .systemFont(ofSize: 24, weight: .bold), imageFlag: false)
                return header
                
            case CategoryViewController.footerKind:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                footer.setup(foot: headersFootersData.footer, indicatorFlag: false)
                return footer
                
            default :
                return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
//        cell.setup(image: sectionData3[indexPath.item].image ?? "image")
        cell.setup(image: cellsData[indexPath.item].image ?? "image")
//        cell.backgroundColor = .orange
        return cell
    }
    
    
}
