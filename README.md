[![Build](https://travis-ci.org/e-sites/ESOpenSourceKit.svg)](https://travis-ci.org/e-sites/ESOpenSourceKit)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESOpenSourceKit/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceKit)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESOpenSourceKit/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceKit)
[![Quality](https://apps.e-sites.nl/cocoapodsquality/ESOpenSourceKit/badge.svg)](https://cocoapods.org/pods/ESOpenSourceKit/quality)

# ESOpenSourceKit
A bash script to automatically generate an HTML file of all the license files used with your CocoaPods Project

## Example

See [example-output.html](http://htmlpreview.github.io/?https://github.com/e-sites/ESOpenSourceKit/blob/master/Example/example-output.html) for an example output

![](Assets/pod-update.gif) ![](Assets/example.gif) 

## Usage

### Cocoapods

#### Swift
Add the following lines to your PodFile:

```ruby
pod 'ESOpenSourceKit'

post_install do |installer_representation|
   system("sh Pods/ESOpenSourceKit/ESOpenSourceKit/Scripts/generate_licenses.sh")
end
```
Run `pod update` or `pod install`

And then open a `ESOpenSourceKitViewController`:

```swift
import ESOpenSourceKit
        
let vc = ESOpenSourceKitViewController()
let navvc = UINavigationController(rootViewController: vc)
self.presentViewController(navvc, animated: true) { _ in
    
}
```

#### Objective-c (not recommended)
Add the following lines to your PodFile:

```ruby
pod 'ESOpenSourceKit'

post_install do |installer_representation|
   system("sh Pods/ESOpenSourceKit/ESOpenSourceKit/Scripts/generate_licenses.sh")
end
```

Run `pod update` or `pod install`

Make a swift / objc bridge.

And then open a `ESOpenSourceKitViewController`:

```objective-c
#import <ESOpenSourceKitViewController.h>

ESOpenSourceKitViewController *vc = [ESOpenSourceKitViewController new];
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
- See [Cocoadocs](http://cocoadocs.org/docsets/ESOpenSourceKit/1.2/Classes/ESOpenSourceKit.html)


## Todo

- [x] CocoaPods
- [x] Customization of the `ESOpenSourceKit`
- [x] Swift 1.2
- [x] Swift 2.0
- [ ] A .plist file of all the licenses
- [ ] An array representation of the license files
