/*
 * CalendarHeaderView.swift
 * Created by Michael Michailidis on 07/04/2015.
 * http://blog.karmadust.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit
import SnapKit

open class CalendarHeaderView: UIView {
    
    var style: CalendarView.Style = CalendarView.Style.Default {
        didSet {
            updateStyle()
        }
    }
        
    var dayLabels = [UILabel]()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<7 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.backgroundColor = UIColor.clear
            
            dayLabels.append(label)
            self.addSubview(label)
        }
        
        self.addSubview(lineView)
    }
    
    public func updateStyle() {
        let formatter = DateFormatter()
        formatter.locale = style.locale
        formatter.timeZone = style.calendar.timeZone
        
        let start = style.firstWeekday == .sunday ? 0 : 1
        var i = 0
        
        for index in start..<(start+7) {
            let label = dayLabels[i]
            label.font = UIFont.nanumPen(size: 15, family: .regular)
            label.text = style.weekDayTransform == .capitalized ? formatter.veryShortWeekdaySymbols[(index % 7)].capitalized : formatter.veryShortWeekdaySymbols[(index % 7)].uppercased()
            if index == 0 {
                label.textColor = style.cellTextColorSunday
            } else if index == 6 {
                label.textColor = style.cellTextColorSaturday
            } else {
                label.textColor = style.weekdaysTextColor
            }
            label.textAlignment = .center
            
            i = i + 1
        }

        self.backgroundColor = style.weekdaysBackgroundColor
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        var isRtl = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
        
        if #available(iOS 10.0, *) {
            isRtl = self.effectiveUserInterfaceLayoutDirection == .rightToLeft
        }

        var labelFrame = CGRect(
            x: 0.0,
            y: 0.0,
            width: self.bounds.size.width / 7.0,
            height: style.weekdaysHeight
        )
        
        self.lineView.frame = CGRect(
            x: 0.0,
            y: style.weekdaysHeight,
            width: self.bounds.size.width,
            height: 1.5
        )
        
        if isRtl {
            labelFrame.origin.x = self.bounds.size.width - labelFrame.width
        }
        
        for lbl in self.dayLabels {
            lbl.frame = labelFrame
            
            labelFrame.origin.x += isRtl ? -labelFrame.size.width : labelFrame.size.width
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
    }
}
