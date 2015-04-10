    
import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate
{
    @IBOutlet var tbData : UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var parser: Parser!
    var series: [Serie]!
    var selectedSerie: Serie?
    
    override func viewDidLoad()
    {
        //http://thetvdb.com/api/983E743A757CA344/series/257655/all
        super.viewDidLoad()
        parser = Parser()
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
                    self.series = self.parser.beginParsing(data)
                    self.tbData.reloadData()
                })
            }
        })
        task.resume()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSerie = series[indexPath.row]
        
        self.performSegueWithIdentifier("detail", sender: self)
        //TODO new screen
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       
    //Tableview Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(series == nil){
            return 0
        }
        return series.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell;
        }
        
        cell.textLabel?.text = series[indexPath.row].name
        cell.detailTextLabel?.text = series[indexPath.row].firstAired
        
        return cell as UITableViewCell
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "detail") {
            var svc = segue!.destinationViewController.topViewController as DetailViewController;
            let indexPath = self.tbData.indexPathForSelectedRow()
            svc.serie = self.series[indexPath!.row]
        }
    }
}