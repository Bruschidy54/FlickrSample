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
        
        struct Media: Codable {
            let image: String?
            
            enum CodingKeys : String, CodingKey {
                case image = "m"
            }
        }
        
        let media: Media?
        let title: String?
        let link: String?
        let author: String?
        let authorId: String?
        let tags: String?
        let published: String?
        let dateTaken: String?
        
        
        enum CodingKeys : String, CodingKey {
            case media
            case title
            case link
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
