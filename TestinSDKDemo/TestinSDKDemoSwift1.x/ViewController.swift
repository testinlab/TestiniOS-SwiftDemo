//
//  ViewController.swift
//  TestinSDKDemoSwift1.x
//
//  Created by yanshan on 15/7/3.
//  Copyright (c) 2015年 Testin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //http request button click action
    var connection: NSURLConnection?
    @IBOutlet var httpRequestBtn: UIButton?
    @IBAction func httpRequestBtnAction() {
        let url = NSURL(string: "http://www.testin.cn")
        let request = NSURLRequest(URL: url!)
        connection = NSURLConnection(request: request, delegate: self)
    }
    
    //crash button click action
    @IBOutlet var crashBtn: UIButton?
    @IBAction func crashBtnAction() {
        let exception: NSException = NSException(name: "test", reason: "test", userInfo: nil)
        exception.raise()
    }
    
    //crumblog button click action
    @IBOutlet var crumbLogBtn: UIButton?
    @IBAction func crumbLogBtnAction() {
        TestinAgent.leaveBreadcrumbWithString("my log")
    }
    
    //report custom http request button click action
    @IBOutlet var reportHttpRequestBtn: UIButton?
    @IBAction func reportHttpRequestBtnAction() {
        let url = NSURL(string: "http://www.testin.cn")
        let request = NSURLRequest(URL: url!)
        
        let requestTimestamp: NSString = NSString(format: "%.f", NSTimeIntervalSince1970 * Double(NSEC_PER_USEC))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let reponseTimestamp: NSString = NSString(format: "%.f", NSTimeIntervalSince1970 * Double(NSEC_PER_USEC))
            let latency = reponseTimestamp.doubleValue - requestTimestamp.doubleValue
            
            var recvDataSize = data?.length
            var sendDataSize = request.HTTPBody?.length
            if recvDataSize == nil {
                recvDataSize = 0
            }
            if sendDataSize == nil {
                sendDataSize = 0
            }
            if response !== nil {
                TestinAgent.reportURLRequest(request, response: response!, latency: latency, bytesRecv: recvDataSize!, bytesSend: sendDataSize!, error: error)
            }
        }
    }
    
    //testin websit
    @IBOutlet var testinURLBtn: UIButton?
    @IBAction func testinURLBtnAction() {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://apm.testin.cn")!)
    }
}

