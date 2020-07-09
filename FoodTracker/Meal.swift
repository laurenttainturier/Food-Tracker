//
//  Meal.swift
//  FoodTracker
//
//  Created by Laurent Tainturier on 08/07/2020.
//  Copyright © 2020 Laurent Tainturier. All rights reserved.
//

import UIKit
import os.log

class Meal: Codable {
       
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL: URL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    enum CodingKeys: String, CodingKey {
        case name
        case photo
        case rating
    }
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
         
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    // MARK: Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(photo?.pngData(), forKey: .photo)
        try container.encode(rating, forKey: .rating)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        photo = try UIImage(data: container.decode(Data.self, forKey: .photo))
        rating = try container.decode(Int.self, forKey: .rating)
    }
}
