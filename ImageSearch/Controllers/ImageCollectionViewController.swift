//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit


class Layout{
    static func gridLayout(numberOfColumns: CGFloat, width: CGFloat)->UICollectionViewFlowLayout{
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = (width - ((numberOfColumns - 1) * 10))/numberOfColumns
        collectionFlowLayout.itemSize = CGSize(width: width , height: width)
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 10
        return collectionFlowLayout
    }
}


class ImageCollectionViewController: UIViewController {
    
    private var dataSource : ImageCollectionViewDataSource<ImageThumbCollectionViewCell, FPhoto>!

    private var searchBarController: UISearchController!
    private var numberOfColumns: CGFloat = ImageSearchConstants.defaultColumnCount
    private var viewModel = FlickrViewModel()
    private var isFirstTimeActive = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
        updateDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstTimeActive {
            searchBarController.isActive = true
            isFirstTimeActive = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: PRIVATE FUNCTION
    
    func updateDataSource(){
        
        self.dataSource = ImageCollectionViewDataSource(cellIdentifier: ImageThumbCollectionViewCell.nibName, items: viewModel.photoArray, configureCell: { (cell) in
            cell.imageView.image = nil
        }, configureWillDisplayCell: { [weak self] (cell, indexPath, model) in
            
            cell.model = ImageModel.init(withPhotos: model)
            
            if indexPath.row == ((self?.viewModel.photoArray.count)! - 10) {
                self?.loadNextPage()
            }
        })
        
        DispatchQueue.main.async {
            self.collectionView.dataSource = self.dataSource
            self.collectionView.reloadData()
        }
    }
    
    private func showAlert(title: String = "Image Search", message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: .default) {(action) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK:- Configure UI
extension ImageCollectionViewController {
    
    fileprivate func changeLayout(numberOfColumns: CGFloat){
        self.numberOfColumns = numberOfColumns
        self.collectionView.startInteractiveTransition(to: Layout.gridLayout(numberOfColumns: numberOfColumns, width: self.collectionView.bounds.width), completion: nil)
        self.collectionView.finishInteractiveTransition()
        //self.collectionView.reloadData()
    }
    
    fileprivate func showGridLayoutAlert() {
        let alert = UIAlertController(title: "Layout", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "2", style: .default , handler:{ (UIAlertAction)in
            self.changeLayout(numberOfColumns: 2)
        }))
        
        alert.addAction(UIAlertAction(title: "3", style: .default , handler:{ (UIAlertAction)in
            self.changeLayout(numberOfColumns: 3)
        }))

        alert.addAction(UIAlertAction(title: "4", style: .default , handler:{ (UIAlertAction)in
            self.changeLayout(numberOfColumns: 4)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    fileprivate func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(layoutChangeOptionAction))

        createSearchBar()
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        collectionView.delegate = self
        //collectionView.dataSource = self
        collectionView.register(nib: ImageThumbCollectionViewCell.nibName)
        collectionView.setCollectionViewLayout(Layout.gridLayout(numberOfColumns: numberOfColumns, width: self.collectionView.bounds.width), animated: false)
        
    }
    
    @objc func layoutChangeOptionAction(sender: UIBarButtonItem) {
        // Function body goes here
        showGridLayoutAlert()
    }
}

extension ImageCollectionViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    private func createSearchBar() {
        searchBarController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBarController
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, text.count > 1 else {
            return
        }
        
        
        self.dataSource.makeEmpty()
        self.collectionView.reloadData()
        
        viewModel.search(text: text) {
            print("search completed.")
        }
        
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

//MARK:- Clousers
extension ImageCollectionViewController {
    
    fileprivate func viewModelClosures() {
        
        viewModel.showAlert = { [weak self] (message) in
            self?.searchBarController.isActive = false
            self?.showAlert(message: message)
        }
        
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            self?.updateDataSource()
        }
    }
    
    private func loadNextPage() {
        viewModel.fetchNextPage {
            print("next page fetched")
        }
    }
}

//MARK:- UICollectionViewDataSource
extension ImageCollectionViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageThumbCollectionViewCell else {
            return
        }
        
        let model = viewModel.photoArray[indexPath.row]
        cell.model = ImageModel.init(withPhotos: model)
        
        if indexPath.row == (viewModel.photoArray.count - 10) {
            loadNextPage()
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
//extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (collectionView.bounds.width - 20)/numberOfColumns
//        return CGSize(width: width, height: width)
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}



