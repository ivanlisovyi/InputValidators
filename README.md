# InputValidators
[![Build Status](https://travis-ci.org/kshin/InputValidators.svg?branch=master)](https://travis-ci.org/kshin/InputValidators)
[![codecov.io](https://codecov.io/github/kshin/InputValidators/coverage.svg?branch=master)](https://codecov.io/github/kshin/InputValidators?branch=master)

Simple Objective-C solution for text validation.

Currently available validators:

> * Required validator
* Email validator
* Alpha validator
* Numeric validator
* Length validator
* Regex validator
* Multiple validator

## Important
The latest version `1.0.0` contains breaking changes and it is **not backward compatible** with previous latests version `0.3.3`. In case if you need a support for pre iOS7 versions use previous latest version `0.3.3`.

## Requirements
* Xcode 7.0 or higher
* iOS 7.0 or higher
* ARC

## Installation

### Cocoa Pods

The recommended approach for installating `InputValidators` is via the [CocoaPods](http://cocoapods.org/) package manager.

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
NSString *email = @"email@example.com"

InputValidator *validator = [LKEmailValidator validator];
NSError *error = nil;
BOOL isValid = [validator validate:email error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

### Text Validation with multiple validators

``` objective-c
NSString *email = @"email@example.com"

LKValidator *validator = [LKMultipleValidator validator];
validator.validators = [[LKRequiredInputValidator validator], [LKEmailInputValidator validator]];
NSError *error = nil;
BOOL isValid = [LKValidator validate:email validators:validators error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

## Roadmap

- [ ] Documentation

## License

InputValidators is available under the MIT license.

Copyright © 2013-2015 Ivan Lisovyi, Denis Kotenko.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
