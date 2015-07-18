//
//  ListViewController.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 05/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//
import UIKit

class ListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate
{

    @IBOutlet weak var locationListTableView: UITableView!
    var locations: [OTMStudentLocation] = [OTMStudentLocation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Create and set the logout button */
        self.parentViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "logoutButtonTouchUp")
        
        self.parentViewController?.navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "logoutButtonTouchUp"),UIBarButtonItem(image: UIImage(named: "pin"), style: .Plain, target: self, action: "postPinButtonTouchUp")]
        
        if(OTMClient.sharedInstance().locations.count > 0) {
          
            locations = OTMClient.sharedInstance().locations
            locationListTableView.reloadData()
        }
        else
        {
            getStudentLocations()
        }
    }
    
    //Mark : Fetch Student Locations
    
    func getStudentLocations(){
        
        OTMClient.sharedInstance().getStudentLocations { studentLocation, error in
            if let studentLocation = studentLocation {
          
                OTMClient.sharedInstance().locations = studentLocation
                self.locations = studentLocation
                dispatch_async(dispatch_get_main_queue()) {
                   self.locationListTableView.reloadData()
                }
            } else {
                println(error)
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
          }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Get cell type */
        let cellReuseIdentifier = "ListTableViewCell"
        let location = locations[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! UITableViewCell
      
        //
        let first = location.firstName
        let last = location.lastName
        let mediaURL = location.mediaURL
        
        /* Set cell defaults */
        cell.textLabel!.text = "\(first) \(last)"
        cell.imageView!.image = UIImage(named: "pin")
        cell.detailTextLabel?.text = mediaURL
        
        cell.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
               
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        let location = locations[indexPath.row]
        let mediaURL = location.mediaURL
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: mediaURL)!)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func logoutButtonTouchUp() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    func refreshButtonTouchUp(){
        getStudentLocations()
    }
    
    func postPinButtonTouchUp(){
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PostStudentLocation") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }


}