//
//  ESOpenSourceLicensesKitTests.swift
//  ESOpenSourceLicensesKit
//
//  Created by Bas van Kuijck on 21-08-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class ESOpenSourceLicensesKitTests : XCTestCase {

    /**
    Test if the ESOpenSourceLicensesViewController works
    */
    func testViewController() {
        let vc = ESOpenSourceLicensesViewController()
        XCTAssertNotNil(vc.openSourceLicensesView)
    }
    
    /**
    Test if ESOpenSourceLicensesView works
    */
    func testView() {
        let v = ESOpenSourceLicensesView()
        XCTAssertNotNil(v)
        let innerHTMLCheck = self.expectation(description: "javascript-innerHTML-check")
        let titleCheck = self.expectation(description: "javascript-title-check")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            v.evaluateJavaScript("document.body.innerHTML", completionHandler: { (response, error) in
                XCTAssertNotNil(response)
                innerHTMLCheck.fulfill()
            })
            v.evaluateJavaScript("document.title") { (response, error) in
                XCTAssertEqual((response as! String), "Open Source Licenses")
                titleCheck.fulfill()
            }
        }
        self.waitForExpectations(timeout: 3) { _ in
        }
    }
    
    /**
    Test ESOpenSourceLicensesView colors and appearance
    */
    func testViewStyle() {
        let v = ESOpenSourceLicensesView()
        var rgba = _rgbaFromUIColor(color: v.backgroundColor!)
        XCTAssertNotNil(rgba)
        
        rgba = _rgbaFromUIColor(color: v.licenseTextColor)
        XCTAssertNotNil(rgba)
        
        rgba = _rgbaFromUIColor(color: v.licenseBorderColor)
        XCTAssertNotNil(rgba)
        
        rgba = _rgbaFromUIColor(color: v.licenseBackgroundColor)
        XCTAssertNotNil(rgba)
        
        rgba = _rgbaFromUIColor(color: v.headerTextColor)
        XCTAssertNotNil(rgba)
        
        rgba = _rgbaFromUIColor(color: v.licenseTextColor)
        XCTAssertNotNil(rgba)
        
        XCTAssertNotNil(v.licenseFont)
        XCTAssertNotNil(v.headerFont)
        XCTAssertGreaterThan(v.licenseBorderWidth, 0)
    }
    
    private func _rgbaFromUIColor(color: UIColor) -> NSString {
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var alpha:CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return NSString(format: "rgba(%.0f, %.0f, %.0f, %.0f)", red * 255, green * 255, blue * 255, alpha)
    }
}
