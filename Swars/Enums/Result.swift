//
//  Result.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
