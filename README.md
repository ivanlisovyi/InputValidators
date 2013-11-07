# InputValidators

Simple Objective-C text validation.

Currently available default validators:

> * Required validator
* Email validator
* Alpha validator
* Numeric validator

## Requirements
* Xcode 4.5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

## Installation

### Cocoa Pods 

Soon...

### Manual Install

All you need to do is drop `InputValidators` files into your project, and add `#import "InputValidator.h"` to the top of classes that will use it. Also if you want to add validators to the UITextField you need to add `#import "UITextField+InputValidator.h"`.

## Example Usage

#### Text Validation 

``` objective-c
NSString *emailString = @"email@example.com"

InputValidator *validator = [InputValidator emailValidator];
NSError *error = nil;
BOOL isValid = [validator validateInput:emailString error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

### Text Validation with multiple validators

``` objective-c
NSString *emailString = @"email@example.com"

NSArray *validators = @[[InputValidator requiredValidator], [InputValidator emailValidator]];
NSError *error = nil;
BOOL isValid = [InputValidator validateInput:emailString validators:validators error:&error];

if (!isValid) {
  NSLog(@"%@", [error localizedFailureReason]);
}
```

## License

InputValidators is available under the MIT license.

Copyright © 2013 Ivan Lisovoy, Denis Kotenko.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
