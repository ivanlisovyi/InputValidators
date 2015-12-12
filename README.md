# InputValidators 
[![Build Status](https://travis-ci.org/kshin/InputValidators.svg?branch=master)](https://travis-ci.org/kshin/InputValidators)
[![codecov.io](https://codecov.io/github/kshin/InputValidators/coverage.svg?branch=master)](https://codecov.io/github/kshin/InputValidators?branch=master)

Simple Objective-C solution for text validation.

Currently available default validators:

> * Required validator
* Email validator
* Alpha validator
* Numeric validator
* Length validator
* RegularExpression validator

## Requirements
* Xcode 5.0 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

## Installation

### Cocoa Pods 

The recommended approach for installating `InputValidators` is via the [CocoaPods](http://cocoapods.org/) package manager.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add InputValidators:

``` bash
pod 'InputValidators'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file

``` bash
$ open MyProject.xcworkspace
```

### Manual Install

All you need to do is drop `InputValidators` files into your project, and add `#import "LKValidators.h"` to the top of classes that will use it.

## Example Usage

#### Text Validation 

``` objective-c
NSString *emailString = @"email@example.com"

InputValidator *validator = [LKEmailInputValidator validator];
NSError *error = nil;
BOOL isValid = [validator validateInput:emailString error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

### Text Validation with multiple validators

``` objective-c
NSString *emailString = @"email@example.com"

NSArray *validators = @[[LKRequiredInputValidator validator], [LKEmailInputValidator validator]];
NSError *error = nil;
BOOL isValid = [LKValidator validateInput:emailString validators:validators error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

## License

InputValidators is available under the MIT license.

Copyright © 2013-2015 Ivan Lisovyi, Denis Kotenko.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


