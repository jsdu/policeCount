//
//  GenderViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-17.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Charts

class GenderViewController: UIViewController, ChartViewDelegate {
    
    var gender = ["Male", "Female"]
    
    @IBOutlet var pieChartView: PieChartView!
    
    @IBOutlet var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        setChart(gender, values: pdata.sharedInstance.numGender)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Gender")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartDataSet.colors = [UIColor(red:0.27, green:0.54, blue:1.00, alpha:1.0),UIColor(red:1.00, green:0.25, blue:0.51, alpha:1.0)]
        pieChartDataSet.drawValuesEnabled = false
        pieChartView.data = pieChartData
        pieChartView.holeRadiusPercent = 0.0
        pieChartView.transparentCircleRadiusPercent = 0.0
        pieChartView.descriptionText = ""
        pieChartView.legend.textColor = UIColor.whiteColor()
        pieChartView.legend.position = .RightOfChartCenter
        pieChartView.animate(xAxisDuration: 0.0, yAxisDuration: 2.0)
        pieChartView.drawSliceTextEnabled = false
        pieChartView.usePercentValuesEnabled = true
        pieChartView.highlightValue(xIndex: 1, dataSetIndex: 0, callDelegate: true)
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        genderLabel.text = "\((Int(entry.value))) \(translate(entry.xIndex)) have been killed since 2015"
    }
    
    func translate(gender: Int) -> String {
        if (gender == 0){
            return "Men"
        } else {
            return "Women"
        }
    }
}
