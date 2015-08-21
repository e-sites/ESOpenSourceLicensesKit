//
//  ESOpenSourceLicensesTests.m
//  ESOpenSourceLicensesTests
//
//  Created by Bas van Kuijck on 18-08-15.
//  Copyright © 2015 e-sites. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ESOpenSourceLicensesView.h"
#import "ESOpenSourceLicensesViewController.h"

@interface ESOpenSourceLicensesTests : XCTestCase

@end

@implementation ESOpenSourceLicensesTests

- (void)testViewController
{
    ESOpenSourceLicensesViewController *vc = [ESOpenSourceLicensesViewController new];
    XCTAssert(vc.openSourceLicensesView != nil);
}

- (void)testView
{
    ESOpenSourceLicensesView *v = [ESOpenSourceLicensesView new];
    XCTAssertNotNil(v);
    XCTAssert(v.dataDetectorTypes == UIDataDetectorTypeNone);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"javascript-check"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *javascriptResponse = [v stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"];
        XCTAssertNotNil(javascriptResponse);
        
        javascriptResponse = [v stringByEvaluatingJavaScriptFromString:@"document.title"];
        XCTAssertEqualObjects(javascriptResponse, @"Open Source Licenses");

        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:3 handler:nil];
}

- (void)testColors
{
    
    ESOpenSourceLicensesView *v = [ESOpenSourceLicensesView new];
    NSString *rgba = [self _rgbaFromUIColor:v.backgroundColor];
    XCTAssert(rgba != nil);
    
    rgba = [self _rgbaFromUIColor:v.licenseTextColor];
    XCTAssertNotNil(rgba);
    
    rgba = [self _rgbaFromUIColor:v.licenseBorderColor];
    XCTAssertNotNil(rgba);
    
    rgba = [self _rgbaFromUIColor:v.licenseBackgroundColor];
    XCTAssertNotNil(rgba);
    
    rgba = [self _rgbaFromUIColor:v.headerTextColor];
    XCTAssertNotNil(rgba);
    
    XCTAssertNotNil(v.licenseFont);
    XCTAssertNotNil(v.headerFont);
    
    XCTAssertGreaterThan(v.licenseBorderWidth, 0);
}

- (NSString *)_rgbaFromUIColor:(UIColor *)color
{
    CGFloat red,green,blue,alpha;
    [color getRed: &red green: &green  blue: &blue alpha: &alpha];
    return [NSString stringWithFormat:@"rgba(%.0f, %.0f, %.0f, %.0f)", red * 255, green * 255, blue * 255, alpha];
}
@end
