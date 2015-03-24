//
//  ViewController.swift
//  XMLParsingDemo
//
//  Created by TheAppGuruz-New-6 on 31/07/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate, UISearchBarDelegate, UITableViewDelegate
{
    @IBOutlet var tbData : UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    
    override func viewDidLoad()
    {
        //http://thetvdb.com/api/983E743A757CA344/series/257655/all
        super.viewDidLoad()
        searchBar.delegate = self
        tbData.delegate = self
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let param = searchBar.text
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "http://thetvdb.com/api/GetSeries.php?seriesname=" + param)
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    self.beginParsing(data)
                })
            }
        })
        task.resume()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = posts.objectAtIndex(indexPath.row).valueForKey("SeriesName") as NSString
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing(data: NSData)
    {
        posts = []
        parser = NSXMLParser(data: data)
        parser.delegate = self
        parser.parse()
        
        tbData!.reloadData()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!)
    {
        element = elementName
        if (elementName as NSString).isEqualToString("Series")
        {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            title1 = NSMutableString.alloc()
            title1 = ""
            date = NSMutableString.alloc()
            date = ""
        }
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("Series") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "SeriesName")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "FirstAired")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if element.isEqualToString("SeriesName") {
            title1.appendString(string)
        } else if element.isEqualToString("FirstAired") {
            date.appendString(string)
        }
    }
    
    //Tableview Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell;
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("SeriesName") as NSString
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("FirstAired") as NSString
        
        return cell as UITableViewCell
    }
}