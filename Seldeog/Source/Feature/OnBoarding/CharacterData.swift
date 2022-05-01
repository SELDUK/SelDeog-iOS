//
//  CharacterData.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/23.
//

import UIKit

struct CharacterData {
    static var selectedShape: UIImage = Image.navyShapeCircle
    static var selectedColorWithShape: UIImage = Image.navyShapeCircle
    static var selectedFeature: UIImage?
    static var selectedShapeIndex: Int = 1
    static var selectedColorIndex: Int = 1
    static var selectedFeatureIndex: Int = 0
    static var nickname: String?
    static var selfLoveScore: Int?
    static var characterIndex: Int?
    static var myCharacterURLstring: String?
    
    static let colorShapeImageList = [
        [Image.navyShapeCircle, Image.yellowShapeCircle, Image.pinkShapeCircle, Image.mauveShapeCircle, Image.greenShapeCircle],
        [Image.navyShapeCloud, Image.yellowShapeCloud, Image.pinkShapeCloud, Image.mauveShapeCloud, Image.greenShapeCloud],
        [Image.navyShapeSharpEar, Image.yellowShapeSharpEar, Image.pinkShapeSharpEar, Image.mauveShapeSharpEar, Image.greenShapeSharpEar],
        [Image.navyShapeBread, Image.yellowShapeBread, Image.pinkShapeBread, Image.mauveShapeBread, Image.greenShapeBread],
        [Image.navyShapeRoundEar, Image.yellowShapeRoundEar, Image.pinkShapeRoundEar, Image.mauveShapeRoundEar, Image.greenShapeRoundEar],
        [Image.navyShapeJjang, Image.yellowShapeJjang, Image.pinkShapeJjang, Image.mauveShapeJjang, Image.greenShapeJjang]
    ]
}
