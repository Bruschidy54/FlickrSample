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
            
            let range = (tmp.tags as! NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        collectionView?.reloadData()
    }
}
