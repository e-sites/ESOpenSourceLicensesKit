[![Build](https://travis-ci.org/e-sites/ESOpenSourceLicensesKit.svg)](https://travis-ci.org/e-sites/ESOpenSourceLicensesKit)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESOpenSourceLicensesKit/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceLicensesKit)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESOpenSourceLicensesKit/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceLicensesKit)
[![Quality](https://apps.e-sites.nl/cocoapodsquality/ESOpenSourceLicensesKit/badge.svg?002)](https://cocoapods.org/pods/ESOpenSourceLicensesKit/quality)
[![Coverage Status](https://coveralls.io/repos/e-sites/ESOpenSourceLicensesKit/badge.svg?branch=master&service=github)](https://coveralls.io/github/e-sites/ESOpenSourceLicensesKit?branch=master)

# ESOpenSourceLicensesKit
A bash script to automatically generate an HTML file of all the license files used with your CocoaPods Project

## Example

See [example-output.html](http://htmlpreview.github.io/?https://github.com/e-sites/ESOpenSourceLicensesKit/blob/master/Example/example-output.html) for an example output

![](Assets/pod-update.gif) ![](Assets/example.gif) 

## Usage

### Cocoapods

#### Swift
Add the following lines to your PodFile:

```ruby
pod 'ESOpenSourceLicensesKit'

post_install do |installer_representation|
   system("sh Pods/ESOpenSourceLicensesKit/ESOpenSourceLicensesKit/Scripts/generate_licenses.sh")
end
```
Run `pod update` or `pod install`

And then open a `ESOpenSourceLicensesViewController`:

```swift
import ESOpenSourceLicensesKit
        
let vc = ESOpenSourceLicensesViewController()
let navvc = UINavigationController(rootViewController: vc)
self.presentViewController(navvc, animated: true) { _ in
    
}
```

#### Objective-c (not recommended)
Add the following lines to your PodFile:

```ruby
pod 'ESOpenSourceLicensesKit'

post_install do |installer_representation|
   system("sh Pods/ESOpenSourceLicensesKit/ESOpenSourceLicensesKit/Scripts/generate_licenses.sh")
end
```

Run `pod update` or `pod install`

Make a swift / objc bridge.

And then open a `ESOpenSourceLicensesViewController`:

```objective-c
#import <ESOpenSourceLicensesViewController.h>

ESOpenSourceLicensesViewController *vc = [ESOpenSourceLicensesViewController new];
UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
[self presentViewController:navVc animated:YES completion:nil];
```


### Manual 
Remember that the project depends on CocoaPods. Because it searches for LICENSE files within the `Pods` directory.
But if you prefer not to use this pod, you can manually call the bash script from your terminal:

```bash
cd /Path/to/xcode-workspace/
sh ./generate_licenses.sh licenses.html
```

Then drag/drop the licenses.html file to your project and you can use it to load in a `UIWebView`

## Customization
- See [e-sites.github.io/ESOpenSourceLicensesKit](http://e-sites.github.io/ESOpenSourceLicensesKit/Classes.html)


## Todo

- [x] CocoaPods
- [x] Customization of the `ESOpenSourceLicensesKit`
- [x] Swift 1.2
- [x] Swift 2.0
- [ ] A .plist file of all the licenses
- [ ] An array representation of the license files
