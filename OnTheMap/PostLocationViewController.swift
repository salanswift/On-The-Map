//
//  PostLocationViewController.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 05/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import UIKit
import MapKit
class PostLocationViewController: UIViewController{

    @IBOutlet weak var geolocationActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var txtFieldSearchAddress: UITextField!
    
    
    @IBOutlet weak var txtViewLinkShare: UITextView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var tapRecognizer: UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        /* Configure tap recognizer */
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1
         self.view.addGestureRecognizer(tapRecognizer!)
        
        geolocationActivityIndicator.hidden = true
        
    }
 
    @IBOutlet weak var findLocationView: UIView!
    @IBAction func findOnMap(sender: AnyObject) {
        
        geolocationActivityIndicator.hidden = false
        geolocationActivityIndicator.startAnimating()
        
        var address = txtFieldSearchAddress.text
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                 self.findLocationView.hidden = true
            }
            else
            {
                var alert = UIAlertController(title: "Sorry!", message: "Location Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            self.geolocationActivityIndicator.hidden = true
            self.geolocationActivityIndicator.stopAnimating()
            
        })
        
      
        
    }
    @IBAction func cancelPost(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    @IBAction func submitLink(sender: AnyObject) {
   self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Keyboard Fixes
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    
    }


   