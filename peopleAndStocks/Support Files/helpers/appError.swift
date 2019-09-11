//
//  appError.swift
//  peopleAndStocks
//
//  Created by Alyson Abril on 9/5/19.
//  Copyright © 2019 Alyson Abril. All rights reserved.
//

import Foundation
enum appError:Error {
    case decodingError(Error)
    case dataError(Error)
    
}
