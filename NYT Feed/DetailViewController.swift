//
//  DetailViewController.swift
//  NYT Feed
//
//  Created by Mark Meyer on 2/10/15.
//  Copyright (c) 2015 Sharethrough. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: NSDictionary = self.detailItem as? NSDictionary {
            if let wv = self.webView {
                let url = NSURL(string: detail.objectForKey("url") as NSString)
                let urlRequest = NSURLRequest(URL: url!)
                wv.loadRequest(urlRequest)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

