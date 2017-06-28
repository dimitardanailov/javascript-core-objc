//
//  Thing.m
//  JavascriptApp
//
//  Created by Dimitar Danailov on 6/27/17.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ThingJSExports <JSExport>
@property (nonatomic, copy) NSString *name;
@end

@interface Thing : NSObject<ThingJSExports>
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSInteger number;
@end

@implementation Thing

- (NSString *) description {
    return [NSString stringWithFormat:@"%@: %ld", self.name, (long) self.number];
}

@end
