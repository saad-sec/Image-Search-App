//
//  Result.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

enum Result <T>{
    case Success(T)
    case Error(String)
    case Failure(String)
}
