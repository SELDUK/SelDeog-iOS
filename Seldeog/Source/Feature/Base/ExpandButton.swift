//
//  ExpandButton.swift
//  Seldeog
//
//  Created by 권준상 on 2022/05/13.
//

import UIKit.UIButton

class ExpandButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)

        let touchArea = bounds.insetBy(dx: -10, dy: -20)
        return touchArea.contains(point)
    }

}
