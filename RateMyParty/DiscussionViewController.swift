//
//  DiscussionViewController.swift
//  RateMyParty
//
//  Created by Bradley Eusabio Carrion on 5/4/15.
//  Copyright (c) 2015 BB. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class DiscussionViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var toggleViews: UISegmentedControl?
    
    var talkAboutItView = UIView()
    var discussionTableView = UITableView()
    var reviewIt = UIView()
    var reviewPercentageSlider = UISlider()
    var submitReviewButton = UIButton()
    var reviewPercentageLabel = UILabel()
    var reviewPercentage = Int(0)
    var talkAboutItTextInput = UITextField()
    var yourReviewLabel = UILabel()
    var discussionMessagesArray = [ReviewItem]()
    
    var theAddress:String?
    
    var redValue   = 255.0
    var greenValue = 0.0
    var blueValue  = 0.0
    
    
    
    @IBAction func indexChanged(sender:UISegmentedControl)
    {
        switch toggleViews!.selectedSegmentIndex
        {
        case 0:
            talkAboutItView.hidden = false
            reviewIt.hidden = true
        case 1:
            talkAboutItView.hidden = true
            reviewIt.hidden = false
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let address = theAddress {
            println(address)
        }
        /* DISCUSSION PAGE */
        /* the discussion page attributes */
        
        // setting up the discussion view
        talkAboutItView.frame = CGRectMake(0, 100, self.view.frame.width, (self.view.frame.height - 100))
        self.view.addSubview(talkAboutItView)

        // the Discussion table view
        discussionTableView.frame = CGRectMake(0, 0, talkAboutItView.frame.width, talkAboutItView.frame.height - 45)
        discussionTableView.delegate = self
        discussionTableView.dataSource = self
        discussionTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        discussionTableView.backgroundColor = UIColor.blackColor()
        talkAboutItView.addSubview(discussionTableView)
        
        let revDB = ReviewDatabase()
        dispatch_async(dispatch_get_main_queue()) {
            revDB.getHouseReviews(self.theAddress!) { (results) in
                if let reviews = results {
                    for review in reviews {
                        let message = review.objectForKey("message") as! String
                        let date    = review.objectForKey("date") as! NSDate
                        let address = review.objectForKey("address") as! String
                        let aReview = ReviewItem(date: date, address: address, message: message)
                        self.discussionMessagesArray.append(aReview)
                    }
                    self.discussionTableView.reloadData()
                }
            }
        }
        
        // the talkAboutItTextBox setup
        talkAboutItTextInput.frame = CGRectMake(0, (talkAboutItView.frame.height - 40), talkAboutItView.frame.width, 40)
        talkAboutItTextInput.placeholder = "Talk About This Party."
        talkAboutItTextInput.delegate = self
        talkAboutItTextInput.backgroundColor = UIColor(red: 28, green: 111, blue: 255, alpha: 0)
        talkAboutItView.addSubview(talkAboutItTextInput)
        
        
        
        
        
        /* REVIEW PAGE */
        /* the review page attributes */
        
        // setting up the review view
        reviewIt.frame = CGRectMake(0, 100, self.view.frame.width, (self.view.frame.height - 100))
        reviewIt.backgroundColor = UIColor.blackColor()
        self.view.addSubview(reviewIt)
        
        // setting up the percentage label
        reviewPercentageLabel.frame = CGRectMake(0, 60, reviewIt.frame.size.width, 200)
        reviewPercentageLabel.text = "0%"
        reviewPercentageLabel.textColor = UIColor(red: CGFloat(redValue/255), green: CGFloat(greenValue/255), blue: CGFloat(0.0), alpha: CGFloat(1.0))
        reviewPercentageLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 110)
        reviewIt.addSubview(reviewPercentageLabel)
        
        // setting up the percentage slider
        reviewPercentageSlider.frame = CGRectMake(20, (reviewIt.frame.height - 200), (reviewIt.frame.width - 40), 5)
        reviewPercentageSlider.backgroundColor = UIColor.blackColor()
        reviewPercentageSlider.minimumValue = 0
        reviewPercentageSlider.maximumValue = 100
        reviewPercentageSlider.continuous = true
        reviewPercentageSlider.value = 0
        reviewPercentageSlider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        reviewIt.addSubview(reviewPercentageSlider)
        
        
        // setting up the UIButton to submit the review to the cloud
        submitReviewButton.frame = CGRectMake((reviewIt.frame.width / 2) - 50, (reviewIt.frame.height - 75), 100, 25)
        submitReviewButton.setTitle("Submit", forState: UIControlState.Normal)
        submitReviewButton.addTarget(self, action: "submitReviewToDiscussion:", forControlEvents: UIControlEvents.TouchUpInside)
        reviewIt.addSubview(submitReviewButton)
        
        // Your review label
        yourReviewLabel.frame = CGRectMake(10, 15, reviewIt.frame.width, 60)
        yourReviewLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 60)
        yourReviewLabel.text = "Your Rating"
        yourReviewLabel.textColor = UIColor.whiteColor()
        reviewIt.addSubview(yourReviewLabel)
        
        
        // initial values apon page load //
        talkAboutItView.hidden = false
        reviewIt.hidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Changing the percentage value from slider
    func sliderValueChanged(sender: UISlider) {
       
        reviewPercentage = Int(sender.value)
        
        if (reviewPercentage < 50) {
            var slope = (255.0 / 50.0) * Double(reviewPercentage)
            greenValue = slope
            blueValue  = slope
        }
        else if (reviewPercentage == 50) {
            redValue   = 255.0
            greenValue = 255.0
            blueValue  = 255.0
        }
        else {
            var slope = (255.0 / -50.0) *  Double(reviewPercentage)
            blueValue = slope + 510
            redValue  = slope + 510
        }
        
        reviewPercentageLabel.textColor = UIColor(red: CGFloat(redValue/255), green: CGFloat(greenValue/255), blue: CGFloat(blueValue/255), alpha: CGFloat(1.0))
        reviewPercentageLabel.text = "\(reviewPercentage)%"
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.submitToDiscussionBoard(talkAboutItTextInput.text)
        talkAboutItTextInput.text = ""
        self.view.endEditing(true)
        return false
    }
    
    func submitToDiscussionBoard(message: String) {
        if (discussionMessagesArray.count == 1 && discussionMessagesArray[0] == "Be the first to discuss.") {
            discussionMessagesArray.removeAll(keepCapacity: true)
        }
        
        let revDB = ReviewDatabase()
        let date = NSDate()
        revDB.pushReview(message, address: theAddress!, date: date) {}
        
        let review = ReviewItem(date: date, address: theAddress!, message: message)
        discussionMessagesArray.append(review)
        discussionTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(discussionMessagesArray.count == 0) {
            return 1
        }
        return self.discussionMessagesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = discussionTableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        if (discussionMessagesArray.count == 0) {
            cell.textLabel?.text = "Be the first to leave a review"
            return cell
        }
        cell.textLabel?.text = self.discussionMessagesArray[indexPath.row].message
        return cell
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 253)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 253)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    func submitReviewToDiscussion(sender: UIButton) {
        var reviewSubmission:String = "Someone gave this party a " + String(reviewPercentage) + " rating"
        submitReviewButton.enabled = false
        submitToDiscussionBoard(reviewSubmission)
        toggleViews?.selectedSegmentIndex = 0
        talkAboutItView.hidden = false
        reviewIt.hidden = true

    }
    
    
    /*
    // Do this later!
    
    func getDirections() {
        
       // MKMapItem.openMapsWithItems([currentLocationMapItem, mapItem], launchOptions: launchOptions)
    }*/
    
    
}