//
//  DatePickerViewController.swift
//  Seldeog
//
//  Created by 권준상 on 2022/04/09.
//

import UIKit
import PanModal
import SnapKit

class DatePickerViewController: UIViewController {
    
    var dateDelegate: CalendarViewController?
    private let datePicker = MonthYearPickerView()
    private let titleLabel = UILabel()
    private let confirmButton = UIButton()
    private var dateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }
    
}

extension DatePickerViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(280)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(280)
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    var allowsDragToDismiss: Bool {
        return false
    }
}

extension DatePickerViewController {
    
    private func setProperties() {
        
        view.do {
            $0.backgroundColor = .white
        }
        
        datePicker.onDateSelected = { (year: Int, month: Int) in
            self.dateString = String(format: "%d-%02d-01 00:00:00", year, month)
        }
        
        titleLabel.do {
            $0.text = "언제로 이동할까요?"
            $0.textColor = .black
        }
        
        confirmButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(sendDate), for: .touchUpInside)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(datePicker, titleLabel, confirmButton)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(-10)
        }
        
        confirmButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func sendDate() {
        dismiss(animated: true) {
            let selectedDate = self.dateString?.toDateTime()
            self.dateDelegate?.setCalendarDate(date: selectedDate ?? Date())
        }
    }
    
}
