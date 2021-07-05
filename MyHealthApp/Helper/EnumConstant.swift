//
//  EnumConstant.swift
//  MyHealthApp
//
//  Created by IDEV on 11/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import Foundation

//enum for errorhandling
  enum ResponseData<T> {
      case success(value: T)
      case failure(error: Error)
  }

enum HNError: Error {
    case noData
}

extension HNError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Storing Data Fail"
        }
    }
}
