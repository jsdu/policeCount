//
//  StateViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-17.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Charts

class StateViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var barChartView: BarChartView!
    var state = ["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
    
    
    @IBOutlet var stateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.delegate = self
        setChart(state, values: pdata.sharedInstance.numState)
    }
    
    func setChart(dataPoints:[String], values:[Double]){

        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "")
        chartDataSet.colors = ChartColorTemplates.liberty()
        let chartData = BarChartData(xVals: state, dataSet: chartDataSet)
        barChartView.descriptionText = ""
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.data = chartData
        barChartView.xAxis.labelTextColor = UIColor.whiteColor()
        barChartView.leftAxis.labelTextColor = UIColor.whiteColor()
        barChartView.rightAxis.enabled = false
        barChartView.maxVisibleValueCount = 0
        barChartView.legend.enabled = false
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.scaleYEnabled = false
        barChartView.highlightValue(xIndex: 0, dataSetIndex: 0, callDelegate: true)

    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        stateLabel.text = "\(Int(entry.value)) people killed in \(translate(state[entry.xIndex]))"
    }
    
    func translate(code: String)->String {
        if (code == "AL"){
            return "Alabama"
        } else if (code == "AK"){
            return "Alaska"
        } else if (code == "AZ"){
            return "Arizona"
        } else if (code == "AR"){
            return "Arkansas"
        } else if (code == "CA"){
            return "California"
        } else if (code == "CO"){
            return "Colorado"
        } else if (code == "CT"){
            return "Connecticut"
        } else if (code == "DE"){
            return "Delaware"
        } else if (code == "FL"){
            return "Florida"
        } else if (code == "GA"){
            return "Georgia"
        } else if (code == "HI"){
            return "Hawaii"
        } else if (code == "ID"){
            return "Idaho"
        } else if (code == "IL"){
            return "Illinois"
        } else if (code == "IN"){
            return "Indiana"
        } else if (code == "IA"){
            return "Iowa"
        } else if (code == "KS"){
            return "Kansas"
        } else if (code == "KY"){
            return "Kentucky"
        } else if (code == "LA"){
            return "Louisiana"
        } else if (code == "ME"){
            return "Maine"
        } else if (code == "MD"){
            return "Maryland"
        } else if (code == "MA"){
            return "Massachusetts"
        } else if (code == "MI"){
            return "Michigan"
        } else if (code == "MN"){
            return "Minnesota"
        } else if (code == "MS"){
            return "Mississippi"
        } else if (code == "MO"){
            return "Missouri"
        } else if (code == "MT"){
            return "Montana"
        } else if (code == "NE"){
            return "Nebraska"
        } else if (code == "NV"){
            return "Nevada"
        } else if (code == "NH"){
            return "New Hampshire"
        } else if (code == "NJ"){
            return "New Jersey"
        } else if (code == "NM"){
            return "New Mexico"
        } else if (code == "NY"){
            return "New York"
        } else if (code == "NC"){
            return "North Carolina"
        } else if (code == "ND"){
            return "North Dakota"
        } else if (code == "OH"){
            return "Ohio"
        } else if (code == "OK"){
            return "Oklahoma"
        } else if (code == "OR"){
            return "Oregon"
        } else if (code == "PA"){
            return "Pennsylvania"
        } else if (code == "RI"){
            return "Rhode Island"
        } else if (code == "SC"){
            return "South Carolina"
        } else if (code == "SD"){
            return "South Dakota"
        } else if (code == "TN"){
            return "Tennessee"
        } else if (code == "TX"){
            return "Texas"
        } else if (code == "UT"){
            return "Utah"
        } else if (code == "VT"){
            return "Vermont"
        } else if (code == "VA"){
            return "Virginia"
        } else if (code == "WA"){
            return "Washington"
        } else if (code == "WV"){
            return "West Virginia"
        } else if (code == "WI"){
            return "Wisconsin"
        } else if (code == "WY"){
            return "Wyoming"
        }
        return ""
    }
}
