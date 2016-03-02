//
//  ViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-13.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var year2015 = 0
    var year2016 = 0
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var casualtyLabel: SACountingLabel!
    
    @IBOutlet var peopleLabel: UILabel!
    var recentArr: [policeData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.70, blue:0.00, alpha:1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
        let jsonUrl = "http://thecountedapi.com/api/counted"
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: jsonUrl)
        let task = session.dataTaskWithURL(shotsUrl!, completionHandler: {
            (data,response,error) -> Void in
            do {
                guard let data = data else {
                    return
                }
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if let entry = json as? NSMutableArray{
                            
                        for entries in entry{
                            let newData = policeData()
                            
                            if let year = entries["year"] as? String{
                                if (Int(year) == 2016){
                                    self.year2016++
                                    newData.year = 2016
                                } else if (Int(year) == 2015){
                                    self.year2015++
                                    newData.year = 2015
                                }
                            }
                            
                            if let month = entries["month"] as? String{
                                newData.month = month
                            }
                            
                            if let day = entries["day"] as? String {
                                newData.day = Int(day)!
                            }
                            
                            if let state = entries["state"] as? String {
                                newData.state = state
                            }
                            
                            if let cause = entries["cause"] as? String {
                                newData.cause = cause
                            }
                            
                            if let age = entries["age"] as? String {
                                if (age == "Unknown") {
                                    newData.age = ""
                                } else {
                                    newData.age = age
                                }
                            }
                            
                            if let sex = entries["sex"] as? String {
                                newData.sex = sex
                            }
                            
                            if let name = entries["name"] as? String {
                                newData.name = name
                            }
                            
                            if let race = entries["race"] as? String {
                                newData.race = race
                            }
                            
                            if let address = entries["address"] as? String {
                                newData.address = address
                            }
                            
                            pdata.sharedInstance.newData.append(newData)
                        }
                        
                        var counter = 0.0
                        var sum = 0.0
                        for items in pdata.sharedInstance.newData {
                            if (items.sex == "Male"){
                                pdata.sharedInstance.numGender[0]++
                            } else if (items.sex == "Female") {
                                pdata.sharedInstance.numGender[1]++
                            }
                            
                            if (items.cause == "Gunshot"){
                                pdata.sharedInstance.numCause[0]++
                            } else if (items.cause == "Death in custody"){
                                pdata.sharedInstance.numCause[1]++
                            } else if (items.cause == "Taser"){
                                pdata.sharedInstance.numCause[2]++
                            } else if (items.cause == "Struck by vehicle"){
                                pdata.sharedInstance.numCause[3]++
                            }
                            
                            if (items.race == "Black"){
                                pdata.sharedInstance.numRace[0]++
                            } else if (items.race == "Asian/Pacific Islander") {
                                pdata.sharedInstance.numRace[1]++
                            } else if (items.race == "Hispanic/Latino") {
                                pdata.sharedInstance.numRace[2]++
                            } else if (items.race == "Native American") {
                                pdata.sharedInstance.numRace[3]++
                            } else if (items.race == "White") {
                                pdata.sharedInstance.numRace[4]++
                            } else {
                                pdata.sharedInstance.numRace[5]++
                            }
                            
                            if let age = Int(items.age) {
                                counter++
                                
                                if (age <= 2) {
                                    pdata.sharedInstance.numAge[0]++
                                } else if (age <= 4) {
                                    pdata.sharedInstance.numAge[1]++
                                } else if (age <= 6) {
                                    pdata.sharedInstance.numAge[2]++
                                } else if (age <= 8) {
                                    pdata.sharedInstance.numAge[3]++
                                } else if (age <= 10) {
                                    pdata.sharedInstance.numAge[4]++
                                } else if (age <= 12) {
                                    pdata.sharedInstance.numAge[5]++
                                } else if (age <= 14) {
                                    pdata.sharedInstance.numAge[6]++
                                } else if (age <= 16) {
                                    pdata.sharedInstance.numAge[7]++
                                } else if (age <= 18) {
                                    pdata.sharedInstance.numAge[8]++
                                } else if (age <= 20) {
                                    pdata.sharedInstance.numAge[9]++
                                } else if (age <= 22) {
                                    pdata.sharedInstance.numAge[10]++
                                } else if (age <= 24) {
                                    pdata.sharedInstance.numAge[11]++
                                } else if (age <= 26) {
                                    pdata.sharedInstance.numAge[12]++
                                } else if (age <= 28) {
                                    pdata.sharedInstance.numAge[13]++
                                } else if (age <= 30) {
                                    pdata.sharedInstance.numAge[14]++
                                } else if (age <= 32) {
                                    pdata.sharedInstance.numAge[15]++
                                } else if (age <= 34) {
                                    pdata.sharedInstance.numAge[16]++
                                } else if (age <= 36) {
                                    pdata.sharedInstance.numAge[17]++
                                } else if (age <= 38) {
                                    pdata.sharedInstance.numAge[18]++
                                } else if (age <= 40) {
                                    pdata.sharedInstance.numAge[19]++
                                } else if (age <= 42) {
                                    pdata.sharedInstance.numAge[20]++
                                } else if (age <= 44) {
                                    pdata.sharedInstance.numAge[21]++
                                } else if (age <= 46) {
                                    pdata.sharedInstance.numAge[22]++
                                } else if (age <= 48) {
                                    pdata.sharedInstance.numAge[23]++
                                } else if (age <= 50) {
                                    pdata.sharedInstance.numAge[24]++
                                } else if (age <= 52) {
                                    pdata.sharedInstance.numAge[25]++
                                } else if (age <= 54) {
                                    pdata.sharedInstance.numAge[26]++
                                } else if (age <= 56) {
                                    pdata.sharedInstance.numAge[27]++
                                } else if (age <= 58) {
                                    pdata.sharedInstance.numAge[28]++
                                } else if (age <= 60) {
                                    pdata.sharedInstance.numAge[29]++
                                } else if (age <= 62) {
                                    pdata.sharedInstance.numAge[30]++
                                } else if (age <= 64) {
                                    pdata.sharedInstance.numAge[31]++
                                } else if (age <= 66) {
                                    pdata.sharedInstance.numAge[32]++
                                } else if (age <= 68) {
                                    pdata.sharedInstance.numAge[33]++
                                } else if (age <= 70) {
                                    pdata.sharedInstance.numAge[34]++
                                } else if (age <= 72) {
                                    pdata.sharedInstance.numAge[35]++
                                } else if (age <= 74) {
                                    pdata.sharedInstance.numAge[36]++
                                } else if (age <= 76) {
                                    pdata.sharedInstance.numAge[37]++
                                } else if (age <= 78) {
                                    pdata.sharedInstance.numAge[38]++
                                } else if (age <= 80) {
                                    pdata.sharedInstance.numAge[39]++
                                } else if (age <= 82) {
                                    pdata.sharedInstance.numAge[40]++
                                } else if (age <= 84) {
                                    pdata.sharedInstance.numAge[41]++
                                } else if (age <= 86) {
                                    pdata.sharedInstance.numAge[42]++
                                } else if (age <= 88) {
                                    pdata.sharedInstance.numAge[43]++
                                } else if (age <= 90) {
                                    pdata.sharedInstance.numAge[44]++
                                } else if (age <= 92) {
                                    pdata.sharedInstance.numAge[45]++
                                } else if (age <= 94) {
                                    pdata.sharedInstance.numAge[46]++
                                } else if (age <= 96) {
                                    pdata.sharedInstance.numAge[47]++
                                } else if (age <= 98) {
                                    pdata.sharedInstance.numAge[48]++
                                } else if (age <= 100) {
                                    pdata.sharedInstance.numAge[49]++
                                }
                                
                                if (age < pdata.sharedInstance.young){
                                    pdata.sharedInstance.young = age
                                }
                                
                                if (age > pdata.sharedInstance.old) {
                                    pdata.sharedInstance.old = age
                                }
                                sum = sum + Double(age)
                            }
                            
                            if (items.state == "AL"){
                                pdata.sharedInstance.numState[0]++
                            } else if (items.state == "AK"){
                                pdata.sharedInstance.numState[1]++
                            } else if (items.state == "AZ"){
                                pdata.sharedInstance.numState[2]++
                            } else if (items.state == "AR"){
                                pdata.sharedInstance.numState[3]++
                            } else if (items.state == "CA"){
                                pdata.sharedInstance.numState[4]++
                            } else if (items.state == "CO"){
                                pdata.sharedInstance.numState[5]++
                            } else if (items.state == "CT"){
                                pdata.sharedInstance.numState[6]++
                            } else if (items.state == "DE"){
                                pdata.sharedInstance.numState[7]++
                            } else if (items.state == "FL"){
                                pdata.sharedInstance.numState[8]++
                            } else if (items.state == "GA"){
                                pdata.sharedInstance.numState[9]++
                            } else if (items.state == "HI"){
                                pdata.sharedInstance.numState[10]++
                            } else if (items.state == "ID"){
                                pdata.sharedInstance.numState[11]++
                            } else if (items.state == "IL"){
                                pdata.sharedInstance.numState[12]++
                            } else if (items.state == "IN"){
                                pdata.sharedInstance.numState[13]++
                            } else if (items.state == "IA"){
                                pdata.sharedInstance.numState[14]++
                            } else if (items.state == "KS"){
                                pdata.sharedInstance.numState[15]++
                            } else if (items.state == "KY"){
                                pdata.sharedInstance.numState[16]++
                            } else if (items.state == "LA"){
                                pdata.sharedInstance.numState[17]++
                            } else if (items.state == "ME"){
                                pdata.sharedInstance.numState[18]++
                            } else if (items.state == "MD"){
                                pdata.sharedInstance.numState[19]++
                            } else if (items.state == "MA"){
                                pdata.sharedInstance.numState[20]++
                            } else if (items.state == "MI"){
                                pdata.sharedInstance.numState[21]++
                            } else if (items.state == "MN"){
                                pdata.sharedInstance.numState[22]++
                            } else if (items.state == "MS"){
                                pdata.sharedInstance.numState[23]++
                            } else if (items.state == "MO"){
                                pdata.sharedInstance.numState[24]++
                            } else if (items.state == "MT"){
                                pdata.sharedInstance.numState[25]++
                            } else if (items.state == "NE"){
                                pdata.sharedInstance.numState[26]++
                            } else if (items.state == "NV"){
                                pdata.sharedInstance.numState[27]++
                            } else if (items.state == "NH"){
                                pdata.sharedInstance.numState[28]++
                            } else if (items.state == "NJ"){
                                pdata.sharedInstance.numState[29]++
                            } else if (items.state == "NM"){
                                pdata.sharedInstance.numState[30]++
                            } else if (items.state == "NY"){
                                pdata.sharedInstance.numState[31]++
                            } else if (items.state == "NC"){
                                pdata.sharedInstance.numState[32]++
                            } else if (items.state == "ND"){
                                pdata.sharedInstance.numState[33]++
                            } else if (items.state == "OH"){
                                pdata.sharedInstance.numState[34]++
                            } else if (items.state == "OK"){
                                pdata.sharedInstance.numState[35]++
                            } else if (items.state == "OR"){
                                pdata.sharedInstance.numState[36]++
                            } else if (items.state == "PA"){
                                pdata.sharedInstance.numState[37]++
                            } else if (items.state == "RI"){
                                pdata.sharedInstance.numState[38]++
                            } else if (items.state == "SC"){
                                pdata.sharedInstance.numState[39]++
                            } else if (items.state == "SD"){
                                pdata.sharedInstance.numState[40]++
                            } else if (items.state == "TN"){
                                pdata.sharedInstance.numState[41]++
                            } else if (items.state == "TX"){
                                pdata.sharedInstance.numState[42]++
                            } else if (items.state == "UT"){
                                pdata.sharedInstance.numState[43]++
                            } else if (items.state == "VT"){
                                pdata.sharedInstance.numState[44]++
                            } else if (items.state == "VA"){
                                pdata.sharedInstance.numState[45]++
                            } else if (items.state == "WA"){
                                pdata.sharedInstance.numState[46]++
                            } else if (items.state == "WV"){
                                pdata.sharedInstance.numState[47]++
                            } else if (items.state == "WI"){
                                pdata.sharedInstance.numState[48]++
                            } else if (items.state == "WY"){
                                pdata.sharedInstance.numState[49]++
                            }
                        }
                        
                        pdata.sharedInstance.average = sum/counter

                    }
                    self.casualtyLabel.countFrom(0, to: Float(self.year2016), withDuration: 2.0, andAnimationType: .Linear, andCountingType: .Int)
                    
                    var count = 0
                    for picker in pdata.sharedInstance.newData.reverse() {
                        count++
                        self.recentArr.append(picker)
                        if (count > 10){
                            break
                        }
                    }
                    self.recentArr.sortInPlace({ (o1: policeData, o2: policeData) -> Bool in
                        return o1.month == o2.month ? (o1.day > o2.day) : (o1.month > o2.month)
                        
                    })
                    self.tableView.reloadData()
                    return
                }
                
            } catch {
                print("json error")
            }
        })
        task.resume()



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recentArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 	{
        let cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! customCell
        let recent = recentArr[indexPath.row]
        if (recent.age == ""){
            cell.ageLabel.text = "\(recent.name), \(recent.cause)"
        } else {
            cell.ageLabel.text = "\(recent.name) \(recent.age), \(recent.cause)"
        }
        cell.dateLabel.text = "\(recent.state)"
        return cell
        
    }
    
    // 4
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
    }
    
    // 5
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    
    @IBAction func yearChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.casualtyLabel.countFrom(0, to: Float(self.year2015), withDuration: 3.0, andAnimationType: .Linear, andCountingType: .Int)
            peopleLabel.text = "people in 2015"
        case 1:
            self.casualtyLabel.countFrom(0, to: Float(self.year2016), withDuration: 2.0, andAnimationType: .Linear, andCountingType: .Int)
            peopleLabel.text = "people in 2016"
        default:
            break; 
        }
    }
    

}

