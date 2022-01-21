//
//  ImageModel.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FPhoto) {
        imageURL = photo.imageURL
    }
}
