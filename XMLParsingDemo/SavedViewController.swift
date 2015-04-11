
import UIKit

class SavedViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{
    var parser: Parser!
    var series: [Serie]!
    var originalSeries: [Serie]!
    
    @IBOutlet weak var tbData: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        //http://thetvdb.com/api/983E743A757CA344/series/257655/all
        super.viewDidLoad()
        
        searchBar.delegate = self
        tbData.delegate = self
        tbData.dataSource = self
        loadSeries()
    }
    
    func loadSeries() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var data = defaults.objectForKey("series") as? [NSString]
        if data == nil {
            return
        } else if data?.count == 0 {
            return
        }
        
        var series = [Serie]()
        for s in data! {
            parser = Parser()
            var xml = s.dataUsingEncoding(NSUTF8StringEncoding)
            var serie = parser.beginParsing(xml!)
            series.append(serie[0])
        }
        self.series = series
        self.originalSeries = series
        dispatch_async(dispatch_get_main_queue(), {
            self.tbData.reloadData()
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var i = 0
        series = originalSeries
        if searchBar.text == "" {
            tbData.reloadData()
            return
        }
        for s in series {
            if (s.name.lowercaseString.rangeOfString(searchBar.text) == nil) {
                series.removeAtIndex(i)
                i--
            }
            i++
        }
        tbData.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SavedDetail", sender: self)
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
            // show detail
        
        
        if (segue.identifier == "SavedDetail") {
            var svc = segue!.destinationViewController as SavedDetailViewController;
            let indexPath = self.tbData.indexPathForSelectedRow()
            svc.serie = self.series[indexPath!.row]
            // self.navigationController?.popViewControllerAnimated(true)
        }
    }
}