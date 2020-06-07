//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Divyansh on 6/7/20.
//  Copyright © 2020 Div. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable> (_ file: String) -> [T] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let decoded = try? decoder.decode([T].self, from:data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return decoded
    }
}
