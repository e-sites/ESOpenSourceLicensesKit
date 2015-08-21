
[![Build](https://travis-ci.org/e-sites/ESOpenSourceLicenses.svg)](https://travis-ci.org/e-sites/ESOpenSourceLicenses)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESOpenSourceLicenses/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceLicenses)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESOpenSourceLicenses/badge.png)](http://cocoadocs.org/docsets/ESOpenSourceLicenses)


# ESOpenSourceLicenses
A bash script to automatically generate an HTML file of all the license files used with your CocoaPods Project

## Example

See [example-output.html](http://htmlpreview.github.io/?https://github.com/e-sites/ESOpenSourceLicenses/blob/master/Example/example-output.html) for an example output

![](Assets/example.gif)

## Usage

### Manual
```bash
cd /Path/to/xcode-workspace/
sh ./generate_licenses.sh licenses.html
```

Then drag/drop the licenses.html file to your project and you can use it to load in a `UIWebView`

### Cocoapods
Add the following lines to your PodFile:

```ruby
pod 'ESOpenSourceLicenses'

post_install do |installer_representation|
   system("sh Pods/ESOpenSourceLicenses/ESOpenSourceLicenses/Scripts/generate_licenses.sh")
end
```

And then open a `ESOpenSourceLicensesViewController`:

```objective-c
#import <ESOpenSourceLicensesViewController.h>

ESOpenSourceLicensesViewController *vc = [ESOpenSourceLicensesViewController new];
UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:vc];
[self presentViewController:navVc animated:YES completion:nil];
```

## Todo

- [x] CocoaPods
- [ ] Customization of the `ESOpenSourceLicensesView`
- [ ] A .plist file of all the licenses
- [ ] An `NSArray` representation of the license files
- [ ] Swift 2.0