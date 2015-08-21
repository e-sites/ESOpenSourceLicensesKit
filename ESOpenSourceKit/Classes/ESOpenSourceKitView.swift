//
//  ESOpenSourceKitView.swift
//  ESOpenSourceKit
//
//  Created by Bas van Kuijck on 19-08-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

import Foundation
import UIKit

public class ESOpenSourceKitView : UIWebView {
    
    // MARK: - Constructor
    // ____________________________________________________________________________________________________________________
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _init()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _init()
    }
    
    private func _init() {
        self.backgroundColor = UIColor.whiteColor()
        self.dataDetectorTypes = .None
        reload()
    }
        
    // MARK: - Style
    // ____________________________________________________________________________________________________________________
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The font to be used for the headers
    *  Default: Helvetica Neue; 16pt
    *
    *	@since 1.1
    *	@date 18/08/2015
    */
    
    var headerFont = UIFont(name: "HelveticaNeue", size: 16)!
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The font to be used for the license text
    *  Default: Menlo; 12pt
    *
    *	@since 1.1
    *	@date 18/08/2015
    */
    var licenseFont = UIFont(name: "Menlo-Regular", size: 12)!
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The text color of the headers
    *  Default: Black
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    var headerTextColor:UIColor = UIColor.blackColor()
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The text color of the license text
    *  Default: Black
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    var licenseTextColor = UIColor.blackColor()
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The backgroundcolor of the license text
    *  Default: #EEE
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    var licenseBackgroundColor = UIColor(white: 0.9333, alpha: 1.0)
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The border color of the license text
    *  Default: #DDD
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    var licenseBorderColor = UIColor(white: 0.8666, alpha: 1.0)
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The width of the border of the license text
    *  Default 1.0
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    var licenseBorderWidth:CGFloat = 1.0
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	The padding in the view
    *  Default 10.0
    *
    *	@since 1.2
    *	@date 19/08/2015
    */
    var padding:CGFloat = 10.0
    
    // MARK: - Reloading
    // ____________________________________________________________________________________________________________________
    
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	Reloads the license text
    *  This should be done after a style attribute is changed
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    override public func reload() {
        var bundle:NSBundle? = nil
        #if TESTS
            bundle = NSBundle(forClass: self.dynamicType)
        #else
            // Try to find ESOpenSourceKit.bundle
            let ar = [ "Frameworks", "ESOpenSourceKit.framework", "ESOpenSourceKit" ]
            var bundlePath:String? = nil
            for i in 0...2 {
                let nar = ar[i...2]
                bundlePath = NSBundle.mainBundle().pathForResource("/".join(nar), ofType: "bundle")
                if (bundlePath != nil) {
                    break
                }
            }
            if (bundlePath == nil) {
                return
            }
            bundle = NSBundle(path: bundlePath!)
        #endif
        
        let path = bundle!.pathForResource("opensource-licenses", ofType: "html")!
        let contents = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error:nil)
        let regex = NSRegularExpression(pattern: "<style>.+?</style>", options: .CaseInsensitive, error: nil)
        
        let bgRGB = _rgbaFromUIColor(self.backgroundColor!)
        let blockRGB = _rgbaFromUIColor(self.licenseBackgroundColor)
        let borderRGB = _rgbaFromUIColor(self.licenseBorderColor)
        let headerTextRGB = _rgbaFromUIColor(self.headerTextColor)
        let licenseTextRGB = _rgbaFromUIColor(self.licenseTextColor)
        
        let template = NSString(format: "<style> body { background-color: %@; margin:%.0fpx; } p { font-family:'%@'; margin-bottom:10px; display:block; background-color:%@; border:%.0fpx solid %@; font-size:%.0fpx; padding:5px; color:%@; } h2 { font-family: '%@'; font-size:%.0fpx; color:%@; } </style>",
            bgRGB, self.padding,
            self.licenseFont.fontName, blockRGB, self.licenseBorderWidth, borderRGB, self.licenseFont.pointSize, licenseTextRGB,
            self.headerFont.fontName, self.headerFont.pointSize, headerTextRGB)
        
        let modifiedString = regex!.stringByReplacingMatchesInString(contents as! String, options: .WithoutAnchoringBounds, range: NSMakeRange(0, contents!.length), withTemplate: template as String)
        self.loadHTMLString(modifiedString, baseURL: nil)
    }
    
    // MARK: - Helpers
    // ____________________________________________________________________________________________________________________
    /**
    *	@author Bas van Kuijck <bas@e-sites.nl>
    *
    *	Helper function to convert a UIColor to an @"rgba()" string
    *
    *	@param color	UIColor
    *
    *	@return NSString*
    *
    *	@since 1.1
    *	@date 19/08/2015
    */
    
    private func _rgbaFromUIColor(color: UIColor) -> NSString {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return NSString(format: "rgba(%.0f, %.0f, %.0f, %.0f)", red * 255, green * 255, blue * 255, alpha)
    }
}