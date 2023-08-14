//
//  MyListViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class MyListViewController: UIViewController {
    
    static let identifier = "MyListViewController"

    static let headerKind = "headerKind"
    static let footerKind = "footerKind"
    
    private var selectedItem = [String]()
    private var selectedSectionIndex = Int()
    
    private var topHeight = CGFloat()
    private var navigationBarHeight = CGFloat()
    private var statusBarHeight = CGFloat()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            if sectionNumber == 0 {
                print("first filter")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1)))
//                item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(8), bottom: nil)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(1000), heightDimension: .absolute(28)), subitems: [item])
//                group.interItemSpacing = .fixed(8)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 16
                section.contentInsets.bottom = 16
                section.interGroupSpacing = 8
                
                return section
            }
            
            else if sectionNumber == 1 {
                print("second")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.23), heightDimension: .fractionalWidth(0.23)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 8
                section.contentInsets.bottom = 8
                
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
                //                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
                section.boundarySupplementaryItems = [header] //, footer
                
                return section
            }
            
            else{
                print("third ...")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1) , heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 15
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 4
                section.contentInsets.bottom = 8
                
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
                //                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
                section.boundarySupplementaryItems = [header] //, footer
                
                return section
            }
        }
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        collection.register(UINib(nibName: "TVCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collection.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        collection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: MyListViewController.headerKind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier)
        collection.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: MyListViewController.footerKind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier)
        
        
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollectionView()
        
    }
    
    func loadCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    @objc private func pullDownToRefresh() {
        print("Refresh")
        
        selectedItem = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
        
    @IBAction func actionButtonPressed(_ sender: UIBarButtonItem) {
        let vc = UIViewController()
        vc.view.backgroundColor = .orange
        self.navigationController?.pushViewController(vc, animated: true)
        //        self.present(vc, animated: true)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        searchVC.view.backgroundColor = .systemTeal
        navigationController?.pushViewController(searchVC, animated: false)
        
    }
        
}


extension MyListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myListSectionsData.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myListSectionsData.sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //        print("supp indexPath row, section, item", indexPath.row, indexPath.section, indexPath.item)
        
        switch kind {
        case MyListViewController.headerKind:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
            header.setup(head: myListSectionsData.sections[indexPath.section].headerFooter.header, imageFlag: false)
            return header
            
        case MyListViewController.footerKind:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
            footer.setup(foot: myListSectionsData.sections[indexPath.section].headerFooter.footer, indicatorFlag: false)
            return footer
            
        default :
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
            
//            if indexPath.section == 0 && indexPath.item == 0 { // all is always selected first
//                cell.setup(label: myListSectionsData.sections[indexPath.section].cells[indexPath.item].label)
//                cell.selected()
//                return cell
//            }
            
            if cell.isSelected == true || selectedItem.contains(where: { $0 == myListSectionsData.sections[indexPath.section].cells[indexPath.item].label}) {
                cell.setup(label: myListSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                cell.selected()
                return cell
            }
            else {
                cell.setup(label: myListSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                cell.deSelected()
                return cell
            }
        }
        
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
            cell.setup(image: myListSectionsData.sections[indexPath.section].cells[indexPath.item].image ?? "image")
            //            cell.backgroundColor = .orange
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
            cell.setup(
                image: myListSectionsData.sections[indexPath.section].cells[indexPath.item].image ?? "image",
                title: myListSectionsData.sections[indexPath.section].cells[indexPath.item].title ?? "Title",
                progress: myListSectionsData.sections[indexPath.section].cells[indexPath.item].progress ?? 0.5,
                duration: myListSectionsData.sections[indexPath.section].cells[indexPath.item].duration ?? "Duration"
            )
            //        cell.backgroundColor = .orange
            return cell
        }
    }
    
}


extension MyListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt  \(indexPath)")
        if indexPath.section == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
            
            if cell.isSelected == true && indexPath.section == 0 {
                if selectedItem.contains(where: { $0 == myListSectionsData.sections[indexPath.section].cells[indexPath.item].label}) {
                    cell.deSelected()
                    
                    selectedItem.removeAll { $0 == myListSectionsData.sections[indexPath.section].cells[indexPath.item].label}
                    print("selectedItem removed   \(selectedItem)")
                    selectedSectionIndex = -500
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    collectionView.scrollToItem(at: [0 ,0] , at: UICollectionView.ScrollPosition.top, animated: true)
                }
                else if selectedItem.count == 1 {
                    cell.deSelected()
                    selectedItem.removeAll()
                    
                    selectedItem.append(myListSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                    print("selectedItem changed   \(selectedItem)")
                    selectedSectionIndex = indexPath.item
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    // [indexPath.item+2,0] might require filter check for anchoring sections
//                    collectionView.scrollToSupplementaryView(ofKind: MyListViewController.headerKind, at: [indexPath.item,0], at: .top, animated: true, navigationOffset: topHeight)

                }
                else {
                    cell.selected()

                    selectedItem.append(myListSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                    print("selectedItem   \(selectedItem)")
                    selectedSectionIndex = indexPath.item
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    // [indexPath.item+2,0] might require filter check for anchoring sections
//                    collectionView.scrollToSupplementaryView(ofKind: MyListViewController.headerKind, at: [indexPath.item,0], at: .top, animated: true, navigationOffset: topHeight)
                    
                }
                collectionView.reloadData()
                
            }
        }
        
        //other sections
        else {
//            send to new vc
            
            let vc = UIViewController()
//            vc.view.backgroundColor = .blue
            vc.view.backgroundColor = indexPath.section == 1 ? .yellow : indexPath.section == 2 ? .blue : .orange
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt  \(indexPath)")
        
        // filter button section don't need deseltion
        if indexPath.section == 0 {
            print("filter button section don't need deseltion")
//            let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
//            // deselection,
//            if cell.isSelected == false && indexPath.section == 1 {
//                print("deselection  \(indexPath.section)")
//            }
        }
        
        // other sections might need deseltion
        else {
//            print("deselection  \(indexPath.section)")
        }
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let per:CGFloat = 100 + 8 + (navigationController?.navigationBar.frame.size.height)! //percentage of required view to move on while moving collection view //60
//        let deductValue = CGFloat(per / 100 * topView.frame.size.height)
////        let deductValue = CGFloat(per / 100 * topView.frame.size.height) - (navigationController?.navigationBar.frame.size.height)!
//        let offset = (-(per/100)) * (collectionView.contentOffset.y)
//        let value = offset - deductValue
//        let rect = topView.frame
//        self.topView.frame = CGRectMake(rect.origin.x, value, rect.size.width, rect.size.height)
//    }
    
    
}

