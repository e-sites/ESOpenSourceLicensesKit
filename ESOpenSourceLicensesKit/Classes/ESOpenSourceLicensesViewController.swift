//
//  ESOpenSourceLicensesViewController.swift
//  ESOpenSourceLicensesKit
//
//  Created by Bas van Kuijck on 19-08-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

import Foundation
import UIKit

/**
 A UIViewController that is wrapped around a `ESOpenSourceLicensesView` instance
*/
public class ESOpenSourceLicensesViewController : UIViewController {
    
    // MARK: - Constructor
    // ____________________________________________________________________________________________________________________
    
    /**
     A convenience initializer
     This will invoke init(nibName:, bundle:)
    
     - returns a ESOpenSourceLicensesViewController instance
    */
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
        _init()
    }
    

    /**
    Returns an object initialized from data in a given unarchiver.
    
    - parameter: aDecoder	An unarchiver object.
    
    - returns:  `self`, initialized using the data in decoder.
    */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        _init()
    }
    
    private func _init() {
        self.view = ESOpenSourceLicensesView()
        self.title = NSLocalizedString("Open Source Licenses", comment: "Open Source Licenses View controller title")
    }
    
    // MARK: - Properties
    // ____________________________________________________________________________________________________________________
    
    /**
     The `view` aka `ESOpenSourceLicensesView`
    
     - author: Bas van Kuijck <bas@e-sites.nl>
     - since: 1.0
     - date: 18/08/2015
    */
    public var openSourceLicensesView:ESOpenSourceLicensesView {
        get {
            return self.view as! ESOpenSourceLicensesView
        }
    }
}
