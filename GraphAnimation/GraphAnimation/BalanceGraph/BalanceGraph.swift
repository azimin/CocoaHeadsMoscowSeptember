//
//  BalanceGraph.swift
//  GraphAnimation
//
//  Created by Alex Zimin on 19/09/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

import UIKit

private extension UIFont {
    func sizeOfString (string: NSString, constrainedToHeight height: Double) -> CGFloat {
        return string.boundingRectWithSize(CGSize(width: DBL_MAX, height: height),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size.width + 6
    }
}

@IBDesignable
class BalanceGraph: UIView {
    
    enum GraphType {
        case Line, Column
    }
    
    // MARK: - Apperance property (ONLY @IBInspectable)
    
    @IBInspectable var numberOfRows: UInt = 0 {
        didSet {
            var newArr: [Int] = []
            
            for i in 0..<numberOfRows {
                newArr.append(Int(arc4random() % 20))
            }
            
            arrayOfActiveValues = newArr
            arrayOfInactoveValues = newArr
            
            updateData()
        }
    }
    
    @IBInspectable var numberOfColumns: UInt = 0 {
        didSet {
            var newArr: [String] = []
            
            for i in 0..<numberOfColumns {
                newArr.append("M")
            }
            
            arrayOfColumnsValues = newArr
            updateData()
        }
    }
    
    // MARK: - Apperance properties
    
    @IBInspectable var font: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            calculateMaxRowsSpaceValue()
            updateData()
        }
    }
    
    @IBInspectable var activeColor: UIColor = UIColor.whiteColor() {
        didSet {
            updateApperance()
        }
    }
    
    @IBInspectable var inactiveColor: UIColor = UIColor.grayColor() {
        didSet {
            updateApperance()
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            updateApperance()
        }
    }
    
    var graphType: GraphType = GraphType.Line {
        didSet {
            updateData()
        }
    }
    
    // MARK: - Data properties
    
    var arrayOfActiveValues: [Int] = [] {
        didSet {
            calculateMaxRowsSpaceValue()
            updateData()
        }
    }
    
    var arrayOfInactoveValues: [Int] = [] {
        didSet {
            calculateMaxRowsSpaceValue()
            updateData()
        }
    }
    
    var arrayOfColumnsValues: [String] = [] {
        didSet {
            updateData()
        }
    }
    
    // MARK: - Private properties
    
    private func calculateMaxRowsSpaceValue() {
        var maxValue: CGFloat = 0
        
        for el in arrayOfActiveValues + arrayOfInactoveValues {
            let value = font.sizeOfString(String(el), constrainedToHeight: Double(columnsValuesHeight))
            if (value > maxValue) {
                maxValue = value
            }
        }
        
        rowsValuesWidth = maxValue
        calculateRowsValues()
    }
    
    private func calculateRowsValues() {
        var minValue: Int = Int.max
        var maxValue: Int = 0
        
        for el in arrayOfActiveValues + arrayOfInactoveValues {
            if (el > maxValue) {
                maxValue = el
            }
            
            if (el < minValue) {
                minValue = el
            }
        }
        
        rowsMinValue = minValue
        rowsMaxValue = maxValue
    }
    
    private var rowsValuesWidth: CGFloat = 0
    
    private var columnsValuesHeight: CGFloat {
        return self.font.pointSize + 8
    }
    
    private var rowsMinValue = 0
    private var rowsMaxValue = 0

    // MARK: - Init methods
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, colomnsNumber: Int, rowsNumber: Int) {
        super.init(frame: frame)
    }
    
    // MARK: - Inside Views
    
    private func addColumnLabel(name: String, atIndex index: Int, withNumberOfColumns count: Int) {
        let space = (frame.width - rowsValuesWidth) / CGFloat(count);
        let spaceFromTop = frame.height - columnsValuesHeight
        
        let label = UILabel(frame: CGRectMake(rowsValuesWidth + space * CGFloat(index), spaceFromTop, space, columnsValuesHeight))
        label.textAlignment = .Center
        label.textColor = textColor
        label.text = name
        label.adjustsFontSizeToFitWidth = true
        
        self.addSubview(label)
    }
    
    private func addRowLabel(number: Int, atIndex index: Int, withNumberOfRows count: Int) {
        let space = (frame.height - columnsValuesHeight) / CGFloat(count);
        
        let label = UILabel(frame: CGRectMake(0, space * CGFloat(index), rowsValuesWidth, space))
        label.textColor = textColor
        label.text = String(number)
        label.adjustsFontSizeToFitWidth = true
        
        self.addSubview(label)
    }

    
    // MARK: - Draw Methods
    
    override func prepareForInterfaceBuilder() {
        //arrayOfColumnsValues = ["Mon", "Tue"]
    }
    
    func updateApperance() {
        
        setNeedsDisplay()
    }
    
    func updateData() {
    
        
        self.subviews.map() { $0.removeFromSuperview() }
        
        for (index, element) in enumerate(arrayOfColumnsValues) {
            addColumnLabel(element, atIndex: index, withNumberOfColumns: arrayOfColumnsValues.count)
        }
        
        for i in 0..<numberOfRows {
            let number = rowsMinValue + (rowsMaxValue - rowsMinValue) / Int(i + 1)
            addRowLabel(number, atIndex: Int(i), withNumberOfRows: Int(numberOfRows))
        }
        
        setNeedsDisplay()
    }
    
    override func layoutSubviews() {
        updateData()
    }
    
    override func drawRect(rect: CGRect) {
        
    }
}
