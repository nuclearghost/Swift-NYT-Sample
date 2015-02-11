//
//  MasterViewController.swift
//  NYT Feed
//
//  Created by Mark Meyer on 2/10/15.
//  Copyright (c) 2015 Sharethrough. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = NSMutableArray()


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "loadStories")
        self.navigationItem.rightBarButtonItem = addButton

        self.loadStories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as NSDictionary
            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as HeadlineTableViewCell

        let object = objects[indexPath.row] as NSDictionary
        cell.headlineLabel!.text = object["title"] as NSString


        if let media = object["media"] as? NSArray {
            let image = media[0] as NSDictionary
            let mediaMetadata = image["media-metadata"] as NSArray
            let large = mediaMetadata[2] as NSDictionary
            var url = NSURL(string: large["url"] as NSString)
            var data = NSData(contentsOfURL : url!)
            var uimage = UIImage(data : data!)
            cell.imgView.image = uimage
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    // MARK: - Network
    func loadStories() {
        let url = NSURL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=920f538738bd002304a99d6ac5c13f91:9:71241870")
        let urlRequest = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(urlRequest, completionHandler: { (rawData: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if ((error) == nil) {
                var parseError: NSError?
                var responseData: NSDictionary = NSJSONSerialization.JSONObjectWithData(rawData, options: NSJSONReadingOptions.MutableContainers, error: &parseError) as NSDictionary
//                println(responseData)
                var results: NSArray = responseData["results"] as NSArray
                for result in results {
                    self.objects.insertObject(result, atIndex: 0)
                }
                self.tableView.reloadData()
            } else {
                println(error)
            }
        }).resume()
    }
}

