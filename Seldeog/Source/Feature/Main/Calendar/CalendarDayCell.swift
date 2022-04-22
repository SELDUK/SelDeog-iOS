/*
 * CalendarDayCell.swift
 * Created by Michael Michailidis on 02/04/2015.
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
import Then
import Kingfisher

open class CalendarDayCell: UICollectionViewCell {

    var cvc: CalendarViewController?
    var yearMonth: String?

    var style: CalendarView.Style = CalendarView.Style.Default
    
    static var characterIndex = 0

    override open var description: String {
        let dayString = self.textLabel.text ?? " "
        return "<DayCell (text:\"\(dayString)\")>"
    }

    var eventsCount = 0 {
        didSet {
            self.setNeedsLayout()
        }
    }


    var day: Int? {
        set {
            guard let value = newValue else { return self.textLabel.text = nil }
            guard let cvc = cvc else { return }

            self.textLabel.text = String(value)
            for character in cvc.charactersForCalendar {
                let index = String.Index(utf16Offset: 8, in: character.usrChrDateCrt)
                if let characterDay = Int(character.usrChrDateCrt[index...]) {
                    if value == characterDay {
                        let imgURL = URL(string: character.usrChrImg)
                        self.characterImageView.kf.setImage(with: imgURL)
                        break
                    }
                }
            }
        }
        get {
            guard let value = self.textLabel.text else { return nil }
            return Int(value)
        }
    }

    func updateTextColor() {
        if isSelected {
            if !isToday {
                self.textLabel.textColor = style.cellSelectedTextColor
                self.textBackView.backgroundColor = .white
            }
        }
        else if isToday {
            self.textLabel.textColor = .white
            self.textBackView.backgroundColor = .black
        }
        else if isOutOfRange {
            self.textLabel.textColor = style.cellColorOutOfRange
            self.textBackView.backgroundColor = .white
        }
        else if isAdjacent {
            self.textLabel.textColor = style.cellColorAdjacent
            self.textBackView.backgroundColor = .white
        }
        else {
            self.textLabel.textColor = style.cellTextColorDefault
            self.textBackView.backgroundColor = .white
        }
    }

    var isToday : Bool = false {
        didSet {
            updateTextColor()
        }
    }

    var isOutOfRange : Bool = false {
        didSet {
            updateTextColor()
        }
    }

    var isAdjacent : Bool = false {
        didSet {
            updateTextColor()
        }
    }

    var isWeekend: Bool = false {
        didSet {
            updateTextColor()
        }
    }

    override open var isSelected : Bool {
        didSet {
            updateTextColor()
        }
    }

    // MARK: - Public methods
    public func clearStyles() {
        self.textLabel.textColor = style.cellTextColorDefault
        self.eventsCount = 0
    }

    let characterBackView = UIView().then {
        $0.backgroundColor = .white
    }

    let characterImageView = UIImageView()

    let textLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont.nanumPen(size: 11, family: .regular)
        $0.textColor = .white
    }
    
    let textBackView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5.5
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setLayout() {
        self.addSubviews(
            textBackView,
            characterBackView)
        
        textBackView.addSubview(textLabel)
        textBackView.bringSubviewToFront(textLabel)

        characterBackView.addSubview(
            characterImageView)
        
        textBackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(25)
            $0.height.equalTo(12)
        }
        
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        characterBackView.snp.makeConstraints {
            $0.top.equalTo(textBackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(characterBackView.snp.width)
        }

        characterImageView.snp.makeConstraints {
            $0.edges.equalTo(characterBackView)
        }
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        characterBackView.backgroundColor = .white
        textLabel.text = nil
        characterImageView.image = nil
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        characterBackView.layer.cornerRadius = characterBackView.frame.height/2
        characterBackView.layer.masksToBounds = true
    }
}
