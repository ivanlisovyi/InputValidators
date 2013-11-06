// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSObject+IVRuntimeHelper.h"
#import <objc/runtime.h>

static const char *property_getTypeName(objc_property_t property) {
	const char *attributes = property_getAttributes(property);
	char buffer[1 + strlen(attributes)];
	strcpy(buffer, attributes);
	char *state = buffer, *attribute;
	while ((attribute = strsep(&state, ",")) != NULL) {
		if (attribute[0] == 'T') {
			size_t len = strlen(attribute);
			attribute[len - 1] = '\0';
			return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
		}
	}
	return "@";
}

@implementation NSObject (IVRuntimeHelper)

+ (void) replaceSelector:(SEL) selector withImplementation:(IMP) implementation {
    Method origMethod = class_getInstanceMethod(self, selector);
    if (!class_addMethod(self, selector, implementation, method_getTypeEncoding(origMethod))) {
        method_setImplementation(origMethod, implementation);
    }
}

+ (NSArray *) propertyNames:(Class) klass {
	NSMutableArray *propertyNames = [[NSMutableArray alloc] init];
    [[self class] classPropsForClassHierarchy:klass onArray:propertyNames];
    return propertyNames;
}

+ (NSArray *) classPropsForClassHierarchy:(Class)klass onArray:(NSMutableArray *)results {
    if (klass == NULL) {
        return nil;
    }
    
    if (klass == [NSObject class]) {
        return [NSArray arrayWithArray:results];
    }
    else{
        
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(klass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            if(propName) {
                NSString *propertyName = @(propName);
                [results addObject:propertyName];
            }
        }
        free(properties);
        
        return [[self class] classPropsForClassHierarchy:[klass superclass] onArray:results];
    }
}

+ (Class) propertyClassForPropertyName:(NSString *) propertyName ofClass:(Class) klass {
	unsigned int propertyCount = 0;
	objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
	
	const char * cPropertyName = [propertyName UTF8String];
	
	for (unsigned int i = 0; i < propertyCount; ++i) {
		objc_property_t property = properties[i];
		const char * name = property_getName(property);
        
		if (strcmp(cPropertyName, name) == 0) {
			free(properties);
			NSString *className = @(property_getTypeName(property));
			return NSClassFromString(className);
		}
	}
    
	free(properties);
	return nil;
}

- (id) associatedObjectForKey:(NSString *) aKey {
    return objc_getAssociatedObject(self, (__bridge const void *) (aKey));
}

- (void) setAssociatedObject:(id) anObject forKey:(NSString *) aKey {
    objc_setAssociatedObject(self, (__bridge const void *) (aKey), anObject, OBJC_ASSOCIATION_RETAIN);
}

- (void) removeAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

@end
