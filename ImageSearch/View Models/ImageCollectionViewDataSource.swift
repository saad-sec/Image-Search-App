//
//  ImageCollectionViewDataSource.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

class ImageCollectionViewDataSource<CELL : UICollectionViewCell,T> : NSObject, UICollectionViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL) -> () = {_ in }
    var configureWillDisplayCell : (CELL, IndexPath, T) -> () = {_,_,_ in }
    //var loadNextPage : (() -> Void) = {}
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL) -> (), configureWillDisplayCell:  @escaping (CELL,IndexPath, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
        self.configureWillDisplayCell = configureWillDisplayCell
    }
    
    func makeEmpty(){
        items.removeAll()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
       
       self.configureCell(cell)
       return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
       
       let item = self.items[indexPath.row]
       self.configureWillDisplayCell(cell, indexPath, item)
       
        
//        guard let cell = cell as? ImageThumbCollectionViewCell else {
//            return
//        }
//
//        let model = self.items[indexPath.row]
//        cell.model = ImageModel.init(withPhotos: model as! FPhoto)
//
//        if indexPath.row == (self.items.count - 10) {
//            loadNextPage()
//        }
    }
    
}
