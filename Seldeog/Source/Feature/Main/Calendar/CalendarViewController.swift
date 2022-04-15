//
//  MainViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/14.
//

import UIKit
import SnapKit
import Then
import PanModal
import Kingfisher

protocol MoveCalendarDate {
    func setCalendarDate(date: Date)
}

final class CalendarViewController: BaseViewController {
    
    var yearLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.nanumPen(size: 15, family: .bold)
    }
    
    var monthLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.nanumPen(size: 35, family: .bold)
    }
    
    let selectMonthButton = UIButton().then {
        $0.setImage(Image.arrowDownIcon, for: .normal)
    }
    
    let baseTabBarView = BaseTabBarView()
    let writeComplimentButton =  UIButton(type: .custom).then {
        $0.imageView?.contentMode = .scaleAspectFill
        guard let imgURLString = UserDefaults.standard.string(forKey: UserDefaultKey.userCharacter) else {
            return
        }
        if let imgURL = URL(string: imgURLString) {
            $0.kf.setBackgroundImage(with: imgURL, for: .normal)
        } else {
            $0.setImage(Image.navyShapeCircle, for: .normal)
        }
    }
    
    var calendarView: CalendarView!
    
    var datePicker = UIDatePicker()
    
    lazy var numberOfWeeks: Int = Date.numberOfWeeksInMonth(Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        calendarView = CalendarView()
        calendarView.cvc = self
        setLayout()
        registerTarget()
        
        let myStyle = CalendarView.Style()

        myStyle.cellShape                = .round
        myStyle.cellColorDefault         = UIColor.clear
        myStyle.cellColorToday           = UIColor(red:1.00, green:0.84, blue:0.64, alpha:1.00)
        myStyle.cellSelectedBorderColor  = UIColor.clear
        myStyle.cellSelectedColor        = UIColor.clear
        myStyle.cellEventColor           = UIColor.clear
        myStyle.headerTextColor          = UIColor.black
        myStyle.headerHeight             = 45

        myStyle.cellTextColorDefault     = UIColor.black
        myStyle.cellTextColorToday       = UIColor.white
        myStyle.cellColorOutOfRange      = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        myStyle.cellSelectedTextColor    = UIColor.black

        myStyle.headerBackgroundColor    = UIColor.white
        myStyle.weekdaysBackgroundColor  = UIColor.white
        myStyle.firstWeekday             = .sunday
        myStyle.locale                   = Locale(identifier: "en_US")

        myStyle.cellFont = UIFont.systemFont(ofSize: 16, weight: .heavy)
        myStyle.headerFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        myStyle.weekdaysFont = UIFont.systemFont(ofSize: 16, weight: .heavy)

        calendarView.style = myStyle

        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true

        calendarView.backgroundColor = UIColor.white

        let today = Date()
        setCalendarDate(date: today)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let today = Date()
        
        self.datePicker.locale = self.calendarView.style.locale
        self.datePicker.timeZone = self.calendarView.calendar.timeZone
        self.datePicker.setDate(today, animated: false)
    }
    
    func setCalendarDate(date: Date) {
        self.calendarView.selectDate(date)
        self.calendarView.setDisplayDate(date)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        yearLabel.text = dateFormatter.string(from: date).uppercased()
        
        dateFormatter.dateFormat = "MMMM"
        monthLabel.text = dateFormatter.string(from: date)

        dateFormatter.dateFormat = "yyyy-MM"
        let yearMonth = dateFormatter.string(from: date)
        calendarView.yearMonth = yearMonth
    }
    
    private func registerTarget() {
        [selectMonthButton, writeComplimentButton, baseTabBarView.aboutMeButton, baseTabBarView.selfLoveButton, baseTabBarView.settingButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
}

extension CalendarViewController: CalendarViewDataSource {
    func headerString(_ date: Date) -> String? {
        return ""
    }

    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -24

        let today = Date()
        let twoYearsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!

        return twoYearsAgo
    }

    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 24

        let today = Date()
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!

        return twoYearsFromNow
    }
}

extension CalendarViewController: CalendarViewDelegate {
    
    func calendar(_ calendar: CalendarView, didSelectDate date : Date, withEvents events: [CalendarEvent]) {
           
           print("Did Select: \(date) with \(events.count) events")
           for event in events {
               print("\t\"\(event.title)\" - Starting at:\(event.startDate)")
           }
           
       }
       
       func calendar(_ calendar: CalendarView, didScrollToMonth date : Date) {
           print(self.calendarView.selectedDates)
           self.datePicker.setDate(date, animated: true)
       }
}

extension CalendarViewController {
    private func setLayout() {
        let safeArea = view.safeAreaLayoutGuide

        view.addSubviews(yearLabel, monthLabel, selectMonthButton, calendarView, writeComplimentButton, baseTabBarView)
        
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.centerX.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        selectMonthButton.snp.makeConstraints {
            $0.centerY.equalTo(monthLabel)
            $0.leading.equalTo(monthLabel.snp.trailing).offset(8)
            $0.width.equalTo(14)
            $0.height.equalTo(9)
        }

        calendarView.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(self.view.frame.size.width + 30)
        }
        
        writeComplimentButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-35)
            $0.width.height.equalTo(95)
        }
        
        baseTabBarView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
    }
        
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case selectMonthButton:
            let datePickerViewController = DatePickerViewController()
            datePickerViewController.dateDelegate = self
            self.presentPanModal(datePickerViewController)
        case writeComplimentButton:
            let todayComplimentViewController = TodayComplimentViewController()
            navigationController?.pushViewController(todayComplimentViewController, animated: false)
        case baseTabBarView.aboutMeButton:
            navigationController?.pushViewController(WriteComplimentViewController(), animated: false)
        case baseTabBarView.selfLoveButton:
            navigationController?.pushViewController(SignUpViewController(), animated: false)
        case baseTabBarView.settingButton:
            navigationController?.pushViewController(SettingViewController(), animated: false)
        default:
            return
        }
    }
}
