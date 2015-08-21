//
//  ESOpenSourceKitViewController.swift
//  ESOpenSourceKit
//
//  Created by Bas van Kuijck on 19-08-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

import Foundation
import UIKit

public class ESOpenSourceKitViewController : UIViewController {
    
    // MARK: - Constructor
    // ____________________________________________________________________________________________________________________
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        _init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _init()
    }
    
    private func _init() {
        self.view = ESOpenSourceKitView()
        self.title = NSLocalizedString("Open Source Licenses", comment: "Open Source Licenses View controller title")
    }
    
    // MARK: - Properties
    // ____________________________________________________________________________________________________________________
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	A ESOpenSourceKitView
    *
    *	@since 1.0
    *	@date 18/08/2015
    */
    var openSourceLicensesView:ESOpenSourceKitView {
        get {
            return self.view as! ESOpenSourceKitView
        }
    }
}
