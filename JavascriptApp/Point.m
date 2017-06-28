//
//  Point.m
//  JavascriptApp
//
//  Developer: https://developer.apple.com/documentation/javascriptcore/jsexport
//
//  Created by Dimitar Danailov on 6/27/17.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MyPointExports <JSExport>

@property double x;
@property double y;

- (NSString *) description;
- (instancetype)initWithX:(double)x y:(double)y;
// + (MyPoint *)makePointWithX:(double)x y:(double)y;

@end

@interface MyPoint : NSObject<MyPointExports>

// Not in the MyPointExports, so not visible to JavaScript Code.
- (void)myPrivateMethod;

@end

@implementation MyPoint

@end
