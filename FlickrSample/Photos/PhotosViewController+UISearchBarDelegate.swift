//
//  PhotosViewController+UISearchBarDelegate.swift
//  FlickrSample
//
//  Created by Dylan Bruschi on 7/2/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import UIKit

extension PhotosViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tagFilteredPhotos = photos.filter({ (photo) -> Bool in
            let tmp: PhotoData.Photo = photo
            
            guard let tagsArray = tmp.tags?.components(separatedBy: " ") else { return false }
            
            for tag in tagsArray {
                let range = (tmp.tags as! NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                if range.location != NSNotFound {
                    return true
                }
            }
           return false
        })
        
        collectionView?.reloadData()
    }
}
