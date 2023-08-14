//
//  SearchViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 10/8/23.
//

import UIKit
import Speech

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var navView: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var navLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchIconButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    static let headerKind = "headerKind"
    static let footerKind = "footerKind"
    
    //search
    private var searched = false  // T/F T- resltFound check, F- load top searches
    private var resultFound = false  // T/F T- load results, F- load not found + recommended
    private var searchedText = String()
    
    //speech
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
//    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    
    
    
    private let collectionViewWithSingleSection: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            print("Top searches/ Results")
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1) , heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 8
            item.contentInsets.bottom = 15
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets.leading = 16
            section.contentInsets.trailing = 8
//            section.contentInsets.bottom = 16
            
            let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(60))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
//            let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
            section.boundarySupplementaryItems = [header] //, footer
            
            return section
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        collection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: SearchViewController.headerKind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier)
        collection.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: SearchViewController.footerKind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier)
        
        return collection
    }()
    
    
    private let collectionViewWithMultipleSection: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionNumber, env in
            
            if sectionNumber == 0 {
                print("Results")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1) , heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.28)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 8
                section.contentInsets.bottom = 16
                
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
//                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
                section.boundarySupplementaryItems = [header] //, footer
                
                return section
            }
            
            else {
                print("Recommended Shows")
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1) , heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 15
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(96)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.contentInsets.trailing = 8
//                section.contentInsets.bottom = 16
                
                let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(60))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: headerKind, alignment: .topLeading)
//                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerHeaderSize, elementKind: footerKind, alignment: .bottomLeading)
                section.boundarySupplementaryItems = [header] //, footer
                
                return section
            }
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: "NoResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NoResultCollectionViewCell.identifier)
        collection.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
        collection.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: SearchViewController.headerKind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier)
        collection.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: SearchViewController.footerKind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier)
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        loadSearchBar()
        
        requestSpeechAuthorization()
        
        loadCollectionViewWithSingleSection()
        
        dismissKeyboard()
    }
    
    private func loadCollectionViewWithSingleSection() {
        collectionViewWithSingleSection.delegate = self
        collectionViewWithSingleSection.dataSource = self
        
        collectionViewWithSingleSection.backgroundColor = .clear
        
        containerView.addSubview(collectionViewWithSingleSection)
        
        collectionViewWithSingleSection.refreshControl = UIRefreshControl()
        collectionViewWithSingleSection.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    private func loadCollectionViewWithMultipleSection() {
        collectionViewWithMultipleSection.delegate = self
        collectionViewWithMultipleSection.dataSource = self
        
        collectionViewWithMultipleSection.backgroundColor = .clear
        
        containerView.addSubview(collectionViewWithMultipleSection)
        
        collectionViewWithMultipleSection.refreshControl = UIRefreshControl()
        collectionViewWithMultipleSection.refreshControl?.addTarget(self, action: #selector(pullDownToRefresh), for: .valueChanged)
    }
    
    private func loadSearchBar() {
        searchTextField.delegate = self
        searchTextField.backgroundColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1)
        searchTextField.addPadding(padding: .left(48))
        searchTextField.addPadding(padding: .right(34))
//        searchTextField.becomeFirstResponder()
    }
    
    private func setupView() {
        navigationController?.isNavigationBarHidden = true
//        navLabel.text = "Search"

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // load collection 2 types here  with 1 section or 2 section

        collectionViewWithSingleSection.frame = containerView.bounds
        collectionViewWithMultipleSection.frame = containerView.bounds
        searchTextField.layer.cornerRadius = (searchView.frame.size.height / 2.0 ) - 1.0
        
    }
    
    @objc private func pullDownToRefresh() {
        print("Refresh")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.searchTextField.text = ""
            
            self.collectionViewWithSingleSection.reloadData()
            self.collectionViewWithSingleSection.refreshControl?.endRefreshing()

            self.collectionViewWithMultipleSection.reloadData()
            self.collectionViewWithMultipleSection.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: false)
    }

}



extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if searched {
            if resultFound {
                //load results
                return 1
            }
            else {
                //load not found + recommended
                return 2
            }
        }
        else {
            //load top searches
            return 1
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if searched {
            if resultFound {
                //load results
                return resultsData.sections[section].cells.count
            }
            else {
                //load not found + recommended
                if section == 0 {
//                    return resultsData.sections[section].cells.count
                    return 1
                }
                else {
                    return recommendedShowsData.sections[section - 1].cells.count
                }
            }
        }
        else {
            //load top searches
            return topSearchesData.sections[section].cells.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //        print("supp indexPath row, section, item", indexPath.row, indexPath.section, indexPath.item)
        
        if searched {
            if resultFound {
                //load results
                switch kind {
                case SearchViewController.headerKind:
                    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                    header.setup(head: resultsData.sections[indexPath.section].headerFooter.header, font: .systemFont(ofSize: 24, weight: .bold), imageFlag: false)
                    return header
                    
                case SearchViewController.footerKind:
                    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                    footer.setup(foot: resultsData.sections[indexPath.section].headerFooter.footer, indicatorFlag: false)
                    return footer
                    
                default:
                    return UICollectionReusableView()
                }
            }
            
            else {
                //load not found + recommended
                if indexPath.section == 0 {
                    switch kind {
                    case SearchViewController.headerKind:
                        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                        header.setup(head: resultsData.sections[indexPath.section].headerFooter.header, font: .systemFont(ofSize: 24, weight: .bold), imageFlag: false)
                        return header
                        
                    case SearchViewController.footerKind:
                        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                        footer.setup(foot: resultsData.sections[indexPath.section].headerFooter.footer, indicatorFlag: false)
                        return footer
                        
                    default:
                        return UICollectionReusableView()
                    }
                }
                
                else {
                    switch kind {
                    case SearchViewController.headerKind:
                        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                        header.setup(head: recommendedShowsData.sections[indexPath.section - 1].headerFooter.header, font: .systemFont(ofSize: 24, weight: .bold), imageFlag: false)
                        return header
                        
                    case SearchViewController.footerKind:
                        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                        footer.setup(foot: recommendedShowsData.sections[indexPath.section - 1].headerFooter.footer, indicatorFlag: false)
                        return footer
                        
                    default:
                        return UICollectionReusableView()
                    }
                }
            }
        }
        else {
            //load top searches
            switch kind {
            case SearchViewController.headerKind:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.headerIdentifier, for: indexPath) as! HeaderCollectionReusableView
                header.setup(head: topSearchesData.sections[indexPath.section].headerFooter.header, font: .systemFont(ofSize: 24, weight: .bold), imageFlag: false)
                return header
                
            case SearchViewController.footerKind:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCollectionReusableView.footerIdentifier, for: indexPath) as! FooterCollectionReusableView
                footer.setup(foot: topSearchesData.sections[indexPath.section].headerFooter.footer, indicatorFlag: false)
                return footer
                
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if searched {
            if resultFound {
                //load results
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
                cell.setup(
                    image: resultsData.sections[indexPath.section].cells[indexPath.item].image ?? "image",
                    title: resultsData.sections[indexPath.section].cells[indexPath.item].title ?? "Title",
                    hideProgress: true,
                    duration: resultsData.sections[indexPath.section].cells[indexPath.item].duration ?? "Duration"
                )
                //            cell.backgroundColor = .orange
                return cell
            }
            
            else {
                //load not found + recommended
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoResultCollectionViewCell.identifier, for: indexPath) as! NoResultCollectionViewCell
                    //            cell.backgroundColor = .orange
                    return cell
                }
                
                else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
                    cell.setup(
                        image: recommendedShowsData.sections[indexPath.section - 1].cells[indexPath.item].image ?? "image",
                        title: recommendedShowsData.sections[indexPath.section - 1].cells[indexPath.item].title ?? "Title",
                        hideProgress: true,
                        duration: recommendedShowsData.sections[indexPath.section - 1].cells[indexPath.item].duration ?? "Duration"
                    )
                    //            cell.backgroundColor = .orange
                    return cell
                }
            }
        }
        else {
            //load top searches
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
            cell.setup(
                image: topSearchesData.sections[indexPath.section].cells[indexPath.item].image ?? "image",
                title: topSearchesData.sections[indexPath.section].cells[indexPath.item].title ?? "Title",
                hideProgress: true,
                duration: topSearchesData.sections[indexPath.section].cells[indexPath.item].duration ?? "Duration"
            )
            //            cell.backgroundColor = .orange
            return cell
        }
    }
    
}


extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt  \(indexPath)")
        
        if collectionView == collectionViewWithMultipleSection && indexPath.section == 1{
            // send to new vc
            let vc = UIViewController()
            vc.view.backgroundColor = indexPath.item == 0 ? .yellow : indexPath.item == 1 ? .blue : indexPath.item == 2 ? .orange : .green
            navigationController?.pushViewController(vc, animated: true)
    
        }
        
        else if collectionView == collectionViewWithSingleSection && indexPath.section == 0 {
            // send to new vc
            let vc = UIViewController()
            vc.view.backgroundColor = indexPath.item == 0 ? .yellow : indexPath.item == 1 ? .blue : indexPath.item == 2 ? .orange : .green

            navigationController?.pushViewController(vc, animated: true)
            navigationController?.isNavigationBarHidden = false
            
        }
    }


    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("didDeselectItemAt  \(indexPath)")

    }
    
    
}


extension SearchViewController: UITextViewDelegate {
    
    func search(containingTitle: String) -> [CellDataType] {
        let filteredResults = topSearchesData.sections[0].cells.filter{ $0.title!.uppercased().contains(containingTitle.uppercased()) }
//        print("containingTitle in topSearchesData  ", filteredResults)
        
        //        if  let resultTest = topSearchesData.sections[0].cells.first(where: {$0.title?.uppercased() == containingTitle.uppercased()}) {
        //        if  let resultTest = topSearchesData.sections[0].cells.first(where: {$0.title!.uppercased().contains(containingTitle.uppercased())}) {
        //        if  let resultTest = topSearchesData.sections[0].cells.enumerated().first(where: {$0.element.title!.uppercased().contains(containingTitle.uppercased())}) {

        return filteredResults
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        searchedText = textField.text ?? ""
        
        // logic check for loading collectionview
        
        if textField.text == "" {
            // change flags
            searched = false
            resultFound = false
            
            // load top searches
            collectionViewWithMultipleSection.removeFromSuperview()
            loadCollectionViewWithSingleSection()
            self.collectionViewWithSingleSection.reloadData()
        }
        
        if textField.text != "" {
            // change flags
            searched = true
            resultFound = false
            
            if searched /* searched true state*/ {
                
                // filter text function
                let searchedResult = search(containingTitle: searchedText)
                print("searchedResult   ", searchedResult)

                if  searchedResult.isEmpty == false /* matched*/ {
                    searched = true
                    resultFound = true
                    
                    // append into resultsdata
                    resultsData.sections[0].cells.removeAll()   //if same thing goes in again dont append so remove first
                    resultsData.sections[0].cells.append(contentsOf: searchedResult)    // Then append searchedResult in result
                    
                    // load results
                    collectionViewWithMultipleSection.removeFromSuperview()
                    loadCollectionViewWithSingleSection()
                    self.collectionViewWithSingleSection.reloadData()
                    
                }
                
                else /* not matched*/ {
                    searched = true
                    resultFound = false
                    
                    // clean resultsdata
                    resultsData.sections[0].cells.removeAll()
                    
                    // load emtpty results and recommendation
                    collectionViewWithSingleSection.removeFromSuperview()
                    loadCollectionViewWithMultipleSection()
                    self.collectionViewWithMultipleSection.reloadData()
                    
                }
            }
            else /* searched false state*/{
                // change flags
                searched = false
                resultFound = false
                
                // load top searches
                collectionViewWithMultipleSection.removeFromSuperview()
                loadCollectionViewWithSingleSection()
                self.collectionViewWithSingleSection.reloadData()
            }
        }
    }

}



extension SearchViewController: SFSpeechRecognizerDelegate {
        
    //MARK: IBActions and Cancel
    @IBAction func speechButtonPressed(_ sender: UIButton) {
        searchTextField.becomeFirstResponder()
        searchTextField.text = ""
        recordAndRecognizeSpeech()
        isRecording = true
        speechButton.tintColor = .red
        speechButton.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.searchTextField.resignFirstResponder()
            self.cancelRecording()
            self.isRecording = false
            self.speechButton.tintColor = .lightGray
            self.speechButton.isUserInteractionEnabled = true
        }

    }
    
    func cancelRecording() {
        recognitionTask?.finish()
        recognitionTask = nil
        
        // stop audio
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
    
    //MARK: - Recognize Speech
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(title: "Speech Recognizer Error", message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(title: "Speech Recognizer Error", message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in

            if let result = result {
//                print(result)
                let bestString = result.bestTranscription.formattedString
                print(bestString)
                self.setSearchBarWithResult(resultString: bestString)
            }
//            else if let error = error {
//                self.sendAlert(title: "Speech Recognizer Error", message: "There has been a speech recognition error.\(error)")
//                print(error)
//            }
        })
    }
        
    //MARK: - Check Authorization Status
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.speechButton.isEnabled = true
                case .denied:
                    self.speechButton.isEnabled = false
                    print("User denied access to speech recognition")
                case .restricted:
                    self.speechButton.isEnabled = false
                    print("Speech recognition restricted on this device")
                case .notDetermined:
                    self.speechButton.isEnabled = false
                    print("Speech recognition not yet authorized")
                @unknown default:
                    return
                }
            }
        }
    }
        
    //MARK: - UI / Set SearchBar.
    func setSearchBarWithResult(resultString: String) {
        self.searchTextField.text = resultString
    }
        
    //MARK: - Alert
    func sendAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
