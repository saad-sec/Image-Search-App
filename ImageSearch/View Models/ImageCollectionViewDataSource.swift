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
    //var loadNextPage : (() -> Void) = {}
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
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
    
    
}
