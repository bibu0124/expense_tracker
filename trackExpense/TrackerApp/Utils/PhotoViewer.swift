//
//  PhotoViewer.swift
//  VietApp
//
//  Created by Admin on 04/07/2023.
//

import Foundation
import SKPhotoBrowser

class PhotoViewer {
    static func showImages(images : [Any], atIndex : Int) {
        guard let topVC = UIApplication.getTopViewController() else { return }
        let previewImages = images.compactMap { image -> SKPhoto? in
            if let image = image as? UIImage {
                return SKPhoto.photoWithImage(image)
            } else if let image = image as? String {
                return SKPhoto.photoWithImageURL(image)
            } else if let image = image as? BaseAvatar, let url = image.image_url {
                return SKPhoto.photoWithImageURL(url)
            }
            return nil
        }
        guard !previewImages.isEmpty else { return }
        let browser = SKPhotoBrowser(photos: previewImages)
        browser.initializePageIndex(atIndex)
        topVC.present(browser, animated: true, completion: nil)
    }
}
