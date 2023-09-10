//
//  ImagePicker.swift
//  VietApp
//
//  Created by Admin on 23/03/2023.
//

import Foundation
import UIKit
import YPImagePicker

public protocol ImagePickerDelegate: AnyObject {
    func didSelect(image: [UIImage])
}

open class ImagePicker: NSObject {
    static func showImagePicker(sender : UIViewController?,
                                isImage: Bool = true,
                                maxSelectableCount : Int = 1,
                                showsPhotoFilters : Bool = false,
                                showsCrop : Bool = false,
                                completeHanler : @escaping ((_ images : [UIImage], _ video: [YPMediaVideo])->())) {
        var config = YPImagePickerConfiguration()
        
        if isImage{
            config.library.mediaType = .photo
            config.screens = [.library, .photo]
            config.library.maxNumberOfItems = maxSelectableCount
            if showsCrop {
                config.showsCrop = .rectangle(ratio: 1)
            }
        }else{
            config.library.mediaType = .video
            config.screens = [.library, .video]
            config.library.maxNumberOfItems = 1
        }
        config.showsPhotoFilters = showsPhotoFilters
        //config.library.mediaType = .photoAndVideo
        config.library.itemOverlayType = .grid
        config.wordings.ok = "Ok".localized()
        config.wordings.done = "Done".localized()
        config.wordings.cancel = "Cancel".localized()
        config.wordings.save = "Save".localized()
        config.wordings.processing = "Processing".localized()
        config.wordings.trim = "Trim".localized()
        config.wordings.cover = "Cover".localized()
        config.wordings.albumsTitle = "Albums".localized()
        config.wordings.libraryTitle = "Library".localized()
        config.wordings.cameraTitle = "Photo".localized()
        config.wordings.videoTitle = "Video".localized()
        config.wordings.next = "Next".localized()
        config.wordings.filter = "Filter".localized()
        config.wordings.crop = "Crop".localized()
        config.wordings.warningMaxItemsLimit = "Warning Items Limit".localized()
        
        config.wordings.permissionPopup.title = "Permission denied".localized()
        config.wordings.permissionPopup.message = "Grant Permission".localized()
        config.wordings.permissionPopup.cancel = "Cancel".localized()
        config.wordings.permissionPopup.grantPermission = "Please allow access".localized()
        
        config.wordings.videoDurationPopup.title = "Video duration".localized()
        config.wordings.videoDurationPopup.tooShortMessage = "The video must be at least %@ seconds"
        config.wordings.videoDurationPopup.tooLongMessage = "Pick a video less than %@ seconds long"
        
        config.hidesBottomBar = false
        //config.icons.capturePhotoImage = UIImage(named: "ic_cam")!
        config.maxCameraZoomFactor = 1.0
        config.gallery.hidesRemoveButton = false
        
        config.startOnScreen = .library
        config.video.recordingTimeLimit = 600
        config.video.libraryTimeLimit = 600
        config.library.skipSelectionsGallery = false
        
        //config.video.fil
        config.showsVideoTrimmer = true
//        if showsCrop {
//            config.showsCrop = .rectangle(ratio: 3/2)
//        }
       
        //config.video.compression = AVAssetExportPreset640x480//AVAssetExportPresetLowQuality
        
        config.library.defaultMultipleSelection = false
        
        
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
            }
            
            var images = [UIImage]()
            var videos = [YPMediaVideo]()
            //var thumbnail:
            items.forEach { (item) in
                switch item {
                case .photo(let photo):
                    print("@@@@photo \(photo)")
                    images.append(photo.image)
                    print("@@@@images \(images.count)")
                    
                    picker.dismiss(animated: true, completion: nil)
                case .video(let video):
                    picker.dismiss(animated: true, completion: {})
                    videos.append(video)
                }
         
            }
            completeHanler(images, videos)
        }
        var vc = sender
        if vc == nil {
            vc = AppDelegate.shared.window?.rootViewController
        }
        vc?.present(picker, animated: true) {
//            picker.navigationBar.tintColor = R.color.m_white()
//            picker.navigationBar.backgroundColor = R.color.m_black()

        }
    }
    
    
}

