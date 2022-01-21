//
//  Photos.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [FPhoto]
}
