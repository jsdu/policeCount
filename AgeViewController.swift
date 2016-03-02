//
//  AgeViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-18.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Charts

class AgeViewController: UIViewController {

    @IBOutlet var youngLabel: UILabel!
    @IBOutlet var oldLabel: UILabel!
    @IBOutlet var averageLabel: UILabel!
    @IBOutlet var lineChartView: LineChartView!
    var age = ["2","4","6","8","10","12","14","16","18","20","22","24","26","28","30","32","34","36","38","40","42","44","46","48","50","52","54","56","58","60","62","64","66","68","70","72","74","76","78","80","82","84","86","88","90","92","94","96","98","100"]
    override func viewDidLoad() {
        super.viewDidLoad()
        youngLabel.text = "Youngest death: \(pdata.sharedInstance.young)"
        oldLabel.text = "Oldest death: \(pdata.sharedInstance.old)"
        averageLabel.text = "Average death: \(Int(pdata.sharedInstance.average))"
    }
    
    override func viewDidAppear(animated: Bool) {
        setChart(age, values: pdata.sharedInstance.numAge)
    }
    
    func setChart(dataPoints:[String], values:[Double]){
        
        var dataEntries:[ChartDataEntry] = []
        for (var i = 0; i < values.count; i++){
            dataEntries.append(ChartDataEntry.init(value: values[i], xIndex: i))
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Age")
        chartDataSet.fillColor = UIColor.whiteColor()
        chartDataSet.drawCubicEnabled = true
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.setColor(UIColor.whiteColor())
        chartDataSet.drawValuesEnabled = false
        let chartData = LineChartData(xVals: dataPoints, dataSet: chartDataSet)
        
        lineChartView.descriptionText = ""
        lineChartView.xAxis.labelPosition = .Bottom
        lineChartView.animate(xAxisDuration: 2.0)
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.labelTextColor = UIColor.whiteColor()
        lineChartView.legend.textColor = UIColor.whiteColor()
        lineChartView.xAxis.labelTextColor = UIColor.whiteColor()
        lineChartView.userInteractionEnabled = false
        
        lineChartView.data = chartData

    }
    
}
