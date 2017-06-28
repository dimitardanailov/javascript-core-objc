//
//  ViewController.m
//  JavascriptApp
//
//  Created by Dimitar Danailov on 6/23/17.
//
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "ViewController.h"
#import "Thing.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loadJavaScript();
    callJavaScriptFunction();
    // callExternalJavaScript();
    
    callJSFactorial();
    
    callThingJavaScript();
    
    loadWebView(_webView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void loadWebView(UIWebView *webView) {
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
}

void jsCallBack() {
    JSContext *context = [[JSContext alloc] init];
    
    context[@"callback"] = ^{
        JSValue *object = [JSValue valueWithNewObjectInContext:[JSContext currentContext]];
        
        // https://stackoverflow.com/questions/21603609/comparing-in-objective-c-implicit-conversion-of-int-to-id-is-disallowed-wi
        object[@"x"] = [NSNumber numberWithInt:3];
        object[@"y"] = [NSNumber numberWithInt:2];
        
        return object;
    };
}

void loadJavaScript() {
    JSContext *context = [[JSContext alloc] init];
    
    JSValue *result = [context evaluateScript: @"2 + 2"];
    NSLog(@"2 + 2 = %d", [result toInt32]);
}

void callJavaScriptFunction() {
    JSContext *context = [[JSContext alloc] init];
    
    NSString* factorialFunction = @"\
    var factorial = function(n) { \
    if (n < 0) \
    return; \
    if (n === 0) \
    return 1; \
    return n * factorial (n - 1) \
    }; \
    ";

    [context evaluateScript: factorialFunction];
    
    JSValue *function = context[@"factorial"];
    JSValue *result = [function callWithArguments:@[@5]];
    
    NSLog(@"factorial(5) = %d", [result toInt32]);
}

void callExternalJavaScript() {
    JSContext *context = [[JSContext alloc] init];
    
    NSURL *sourceUrl = [NSURL URLWithString:@"factorial.js"];
   
    [context evaluateScript:@"" withSourceURL:sourceUrl];
    
    JSValue *function = context[@"factorial"];
    JSValue *result = [function callWithArguments:@[@15]];
    
    NSLog(@"factorial(15) = %d", [result toInt32]);
}

void callJSFactorial() {
    JSContext *context = [[JSContext alloc] init];
    
    context[@"factorialFunc"] = ^(int x) {
        int factorial = 1;
        for (; x > 1; x--) {
            factorial *= x;
        }
        
        return factorial;
    };
    
    [context evaluateScript: @"var factorial = factorialFunc(7)"];
    JSValue *value = context[@"factorial"];
    
    NSLog(@"factorial(7) = %d", [value toInt32]);
}

/*!
 *\ https://www.bignerdranch.com/blog/javascriptcore-and-ios-7/
 */
void callThingJavaScript() {
    Thing *thing = [[Thing alloc] init];
    thing.name = @"Alfred";
    thing.number = 3;
    
    JSContext *context = [[JSContext alloc] init];
    context[@"thing"] = thing;
    
    JSValue *thingValue = context[@"thing"];
    
    NSLog(@"Thing: %@", thing);
    NSLog(@"Thing JSValue: %@", thingValue);
    
    thing.name = @"Betty";
    thing.number = 8;
    
    NSLog(@"Thing: %@", thing);
    NSLog(@"Thing JSValue: %@", thingValue);
}

@end
