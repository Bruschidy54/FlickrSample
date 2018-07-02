//
//  Photo.swift
//  FlickrSample
//
//  Created by Dylan Bruschi on 7/1/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import Foundation

struct PhotoData: Codable {
    
    struct Photo: Codable {
        let title: String?
        let link: String?
        let description: String?
        let author: String?
        let authorId: String?
        let tags: String?
        let published: String?
        let dateTaken: String?
        
        
        enum CodingKeys : String, CodingKey {
            case title
            case link
            case description
            case author
            case authorId = "author_id"
            case tags
            case published
            case dateTaken = "date_taken"
            
        }
    }
        
        let photos: [Photo]
        
        enum CodingKeys : String, CodingKey {
            case photos = "items"
        }
    }