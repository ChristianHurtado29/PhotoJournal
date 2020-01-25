//
//  PersistenceHelper.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(Error)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}
