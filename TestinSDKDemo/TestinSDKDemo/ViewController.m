//
//  ViewController.m
//  TestinSDKDemo
//
//  Created by maximli on 15/6/11.
//  Copyright (c) 2015年 Testin. All rights reserved.
//

#import "ViewController.h"

#import "TestinAgent/TestinAgent.h"

@interface ViewController (Private)
@end

@implementation ViewController (Private)
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - handleHttpRequestBtnAction
- (IBAction)handleHttpRequestBtnAction
{
    NSURL* url = [NSURL URLWithString:@"http://www.testin.cn"];
    
    __block NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 5;
    connection_ = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

#pragma mark - handleCrashBtnAction
- (IBAction)handleCrashBtnAction
{
    [NSDictionary dictionaryWithObject:nil forKey:@"exception"];
}

#pragma mark - handleExceptionBtnAction
- (IBAction)handleExceptionBtnAction
{
    @try {
        [NSDictionary dictionaryWithObject:nil forKey:@"crash"];
    }
    @catch (NSException *exception) {
        //上报异常
        [TestinAgent reportCustomizedException:exception message:@"catch exception"];
    }
}

#pragma mark - handleCrumbLogBtnAction
- (IBAction)handleCrumbLogBtnAction
{
    /**
     *  log string max length 199
     *  log record max count  100
     */
    //面包屑
    [TestinAgent leaveBreadcrumbWithString:@"my log"];
    [TestinAgent leaveBreadcrumbWithFormat:@"%@", @"my log"];
}

#pragma mark - handleReportHttpRequestBtnAction
- (IBAction)handleReportHttpRequestBtnAction
{
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    __block NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 5;
    
    __block NSString* requestTimestamp = [NSString stringWithFormat:@"%.f", [NSDate date].timeIntervalSince1970 * NSEC_PER_USEC];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSString* reponseTimestamp = [NSString stringWithFormat:@"%.f", [NSDate date].timeIntervalSince1970 * NSEC_PER_USEC];
        NSTimeInterval latency = reponseTimestamp.doubleValue - requestTimestamp.doubleValue;
        //自定义HTTP请求
        [TestinAgent reportURLRequest:request
                            response:response
                             latency:latency
                           bytesRecv:data.length
                           bytesSend:request.HTTPBody.length
                                error:connectionError];
    }];
}

#pragma mark - handleURLBtnAction
- (void)handleURLBtnAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apm.testin.cn"]];
}

@end
