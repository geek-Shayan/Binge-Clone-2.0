//
//  LiveTvViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit

class LiveTvViewController: UIViewController {
    
    static let identifier = "LiveTvViewController"

    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var topView: UIView!

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
                print("first carossel")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
//                item.contentInsets.trailing = 2
//                item.contentInsets.bottom = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400)), subitems: [item])

                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets.bottom = 10
                
                section.visibleItemsInvalidationHandler = { (items, scrollOffset, environment) in
                    items.forEach { item in
                        let distanceFromCenter = abs((item.frame.midX - scrollOffset.x) - environment.container.contentSize.width / 2.0)
                        let minScale: CGFloat = 0.8
                        let maxScale: CGFloat = 1.0 - (distanceFromCenter / environment.container.contentSize.width)
                        let scale = max(maxScale, minScale)
                        item.transform = CGAffineTransform(scaleX: scale, y: scale)
                    }
                }
                return section
            }
            
            else if sectionNumber == 1 {
                print("second filter")
                
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
            
            else {
                print("third ...")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25) , heightDimension: .fractionalWidth(0.25)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 8
                section.contentInsets.bottom = 16
                
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(30))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
                section.boundarySupplementaryItems = [header] //, footer
                
                return section
            }

        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "CarosselCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CarosselCollectionViewCell.identifier)
        collection.register(UINib(nibName: "FilterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        collection.register(UINib(nibName: "TVCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        collection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: LiveTvViewController.headerKind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier)
        collection.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: LiveTvViewController.footerKind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier)
                                                                                       
        return collection
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loadCollectionView()

        view.addSubview(topView)
        
    }
    
    func loadCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .clear
        
//        collectionView.allowsMultipleSelection = true //
 
        view.addSubview(collectionView)
        
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    private func setupView() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationBarHeight = (navigationController?.navigationBar.frame.size.height)!
        statusBarHeight = (view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
        topHeight = navigationBarHeight + statusBarHeight
        print("topHeight  \(topHeight)")
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

    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        searchVC.view.backgroundColor = .systemTeal
        navigationController?.pushViewController(searchVC, animated: false)
        
    }
    
    @IBAction func tvShowsPressed(_ sender: Any) {
        // pass to new vc / navbar
//        let navbar = storyboard?.instantiateViewController(withIdentifier: "CategoryViewNavigationController") as! UINavigationController
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        vc.headersFootersData = SupplementaryDataType(header: "Tv Shows")
        vc.cellsData = [CellDataType(image: "image 70", label: "1"),
                        CellDataType(image: "image 5",  label: "2"),
                        CellDataType(image: "image 16", label: "3"),
                        CellDataType(image: "image 20", label: "4"),
                        CellDataType(image: "image 19", label: "5"),
                        CellDataType(image: "image 17", label: "6"),
                        CellDataType(image: "image 12", label: "7"),
                        CellDataType(image: "image 11", label: "8"),
                        CellDataType(image: "image 10", label: "9"),
                        CellDataType(image: "image 9",  label: "10"),
                        CellDataType(image: "image 6",  label: "11"),
                        CellDataType(image: "image 4",  label: "12"),
                        CellDataType(image: "image 2",  label: "13"),]
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
        
//        self.present(nav, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func moviesPressed(_ sender: Any) {
        // pass to new vc / navbar
//        let navbar = storyboard?.instantiateViewController(withIdentifier: "CategoryViewNavigationController") as! UINavigationController
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        vc.headersFootersData = SupplementaryDataType(header: "Movies")
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
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
//        self.present(navbar, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func categoriesPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoriesViewController") as! CategoriesViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
}




extension LiveTvViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return liveTvSectionsData.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return liveTvSectionsData.sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        print("supp indexPath row, section, item", indexPath.row, indexPath.section, indexPath.item)
        switch kind {
            case LiveTvViewController.headerKind:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                header.setup(head: liveTvSectionsData.sections[indexPath.section].headerFooter.header, imageFlag: false)
                return header
                
            case LiveTvViewController.footerKind:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                footer.setup(foot: liveTvSectionsData.sections[indexPath.section].headerFooter.footer, indicatorFlag: true)
                return footer
                
            default :
                return UICollectionReusableView()

        }
    }
        
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("Cell indexPath row, section, item", indexPath.row, indexPath.section, indexPath.item)
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarosselCollectionViewCell.identifier, for: indexPath) as! CarosselCollectionViewCell
            cell.setup(image: liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].image ?? "image", indexPath: indexPath, dataSize: liveTvSectionsData.sections[indexPath.section].cells.count)
            //            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 0
            return cell
        }
        
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
            
            if cell.isSelected == true || selectedItem.contains(where: { $0 == liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label}) {
                cell.setup(label: liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                cell.selected()
                return cell
            }
            else {
                cell.setup(label: liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                cell.deSelected()
                return cell
            }
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
            cell.setup(image: liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].image ?? "image")
            //            cell.backgroundColor = .orange
            return cell
        }
    }
}


extension LiveTvViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt  \(indexPath)")
        if indexPath.section == 1 {
            let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionViewCell
            
            if cell.isSelected == true && indexPath.section == 1 {
                if selectedItem.contains(where: { $0 == liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label}) {
                    cell.deSelected()
                    
                    selectedItem.removeAll { $0 == liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label}
                    print("selectedItem removed   \(selectedItem)")
                    selectedSectionIndex = -500
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    collectionView.scrollToItem(at: [0 ,0] , at: UICollectionView.ScrollPosition.top, animated: true)
                }
                else if selectedItem.count == 1 {
                    cell.deSelected()
                    selectedItem.removeAll()
                    
                    selectedItem.append(liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                    print("selectedItem changed   \(selectedItem)")
                    selectedSectionIndex = indexPath.item
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    // [indexPath.item+2,0] might require filter check for anchoring sections
                    collectionView.scrollToSupplementaryView(ofKind: LiveTvViewController.headerKind, at: [indexPath.item+2,0], at: .top, animated: true, navigationOffset: topHeight)

                }
                else {
                    cell.selected()

                    selectedItem.append(liveTvSectionsData.sections[indexPath.section].cells[indexPath.item].label ?? "label")
                    print("selectedItem   \(selectedItem)")
                    selectedSectionIndex = indexPath.item
                    print("selectedSectionIndex  \(selectedSectionIndex)")
                    
                    // [indexPath.item+2,0] might require filter check for anchoring sections
                    collectionView.scrollToSupplementaryView(ofKind: LiveTvViewController.headerKind, at: [indexPath.item+2,0], at: .top, animated: true, navigationOffset: topHeight)
                    
                }
                collectionView.reloadData()
                
            }
        }
        
        else {
            //send to new vc
            
            let vc = UIViewController()
//            vc.view.backgroundColor = .blue
            vc.view.backgroundColor = indexPath.section == 0 ? .yellow : indexPath.section == 1 ? .blue : .orange
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt  \(indexPath)")
        
        // filter button section don't need deseltion
        if indexPath.section == 1 {
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
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let per:CGFloat = 100 + 8 + (navigationController?.navigationBar.frame.size.height)! //percentage of required view to move on while moving collection view //60
        let deductValue = CGFloat(per / 100 * topView.frame.size.height)
//        let deductValue = CGFloat(per / 100 * topView.frame.size.height) - (navigationController?.navigationBar.frame.size.height)!
        let offset = (-(per/100)) * (collectionView.contentOffset.y)
        let value = offset - deductValue
        let rect = topView.frame
        self.topView.frame = CGRectMake(rect.origin.x, value, rect.size.width, rect.size.height)
    }
    
    
}
