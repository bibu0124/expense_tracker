//
//  EmptyView.swift
//  Tourist
//
//  Created by Dong Nguyen on 11/26/18.
//  Copyright © 2018 TVT25. All rights reserved.
//

import UIKit

class NoConnectionView: UIView {

    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbDesc: UILabel!
    
    var touchRetryHandler : (()->())?
    
    func setuiWithTitle(_ title : String?, desc : String?) {
        if let title = title {
            lbTitle.text = title
        }
        if let desc = desc {
            lbDesc.text = desc
        }
    }
    
    @IBAction func didTouchAction(_ sender: Any) {
        touchRetryHandler?()
    }
}
