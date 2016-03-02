//
//  RaceViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-18.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Charts

class RaceViewController: UIViewController, ChartViewDelegate {

    
    @IBOutlet var raceLabel: UILabel!
    @IBOutlet var pieChartView: PieChartView!
    
    
    var race = ["Black","Asian/Pacific Islander","Hispanic/Latino","Native American","White","Other"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        setChart(race, values: pdata.sharedInstance.numRace)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Race")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartDataSet.colors = [UIColor(red:1.00, green:0.32, blue:0.32, alpha:1.0),
                                  UIColor(red:0.41, green:0.94, blue:0.68, alpha:1.0),
                                  UIColor(red:0.33, green:0.43, blue:1.00, alpha:1.0),
                                  UIColor(red:0.80, green:0.86, blue:0.22, alpha:1.0),
                                  UIColor(red:1.00, green:0.67, blue:0.25, alpha:1.0),
                                  UIColor(red:0.88, green:0.25, blue:0.98, alpha:1.0)]
        pieChartDataSet.drawValuesEnabled = false
        pieChartView.data = pieChartData
        pieChartView.holeRadiusPercent = 0.0
        pieChartView.transparentCircleRadiusPercent = 0.0
        pieChartView.descriptionText = ""
        pieChartView.legend.textColor = UIColor.whiteColor()
        pieChartView.legend.position = .RightOfChartCenter
        pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
        pieChartView.drawSliceTextEnabled = false
        pieChartView.usePercentValuesEnabled = false
        pieChartView.highlightValue(xIndex: 1, dataSetIndex: 0, callDelegate: true)
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        raceLabel.text = "\((Int(entry.value))) \(race[entry.xIndex]) people were killed"

    }

}
