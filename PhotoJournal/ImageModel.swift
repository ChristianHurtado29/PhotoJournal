//
//  ImageModel.swift
//  PhotoJournal
//
//  Created by Christian Hurtado on 1/25/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation

struct Image: Codable & Equatable {
  let imageData: Data
  let date: Date
  let identifier = UUID().uuidString
  let description: String
}
