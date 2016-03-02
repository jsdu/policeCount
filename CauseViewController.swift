//
//  CauseViewController.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-18.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Charts
class CauseViewController: UIViewController, ChartViewDelegate {

    
    
    @IBOutlet var causeLabel: UILabel!
    @IBOutlet var pieChartView: PieChartView!
    var cause = ["Gunshot","Death in custody","Taser","Struck by vehicle"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        setChart(cause, values: pdata.sharedInstance.numCause)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Cause")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartDataSet.colors = ChartColorTemplates.joyful()
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
        if (entry.xIndex == 0) {
            causeLabel.text = "\((Int(entry.value))) people killed by a gunshot wound"
        } else if (entry.xIndex == 1) {
            causeLabel.text = "\((Int(entry.value))) people killed in custody"
        } else if (entry.xIndex == 2) {
            causeLabel.text = "\((Int(entry.value))) people killed by a taser"
        } else if (entry.xIndex == 3) {
            causeLabel.text = "\((Int(entry.value))) people killed by a vehicle"
        }
    }
    

}
