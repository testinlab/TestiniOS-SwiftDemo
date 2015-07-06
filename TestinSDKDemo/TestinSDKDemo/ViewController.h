//
//  ViewController.h
//  TestinSDKDemo
//
//  Created by maximli on 15/6/11.
//  Copyright (c) 2015年 Testin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UIButton* httpRequestBtn_;
    IBOutlet UIButton* crashBtn_;
    IBOutlet UIButton* handleExceptionBtn_;
    IBOutlet UIButton* crumbLog_;
    IBOutlet UIButton* reportHttpRequest_;
    
    IBOutlet UIButton* testinURL_;
    
    NSURLConnection* connection_;
}

- (IBAction)handleHttpRequestBtnAction;
- (IBAction)handleCrashBtnAction;
- (IBAction)handleExceptionBtnAction;
- (IBAction)handleCrumbLogBtnAction;
- (IBAction)handleReportHttpRequestBtnAction;


- (IBAction)handleURLBtnAction;

@end

