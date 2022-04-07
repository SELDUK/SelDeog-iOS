//
//  CharacterData.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/23.
//

import UIKit

struct CharacterData {
    static var selectedShape: UIImage?
    static var selectedColorWithShape: UIImage?
    static var selectedFeature: UIImage?
    static var selectedShapeIndex: Int?
    static var selectedColorIndex: Int?
    static var selectedFeatureIndex: Int?
    static var nickname: String?
    static var selfLoveScore: Int?
    
    static let colorShapeImageList = [
        [Image.navyShapeCircle, Image.greenShapeCircle, Image.yellowShapeCircle, Image.pinkShapeCircle, Image.mauveShapeCircle],
        [Image.navyShapeCloud, Image.greenShapeCloud, Image.yellowShapeCloud, Image.pinkShapeCloud, Image.mauveShapeCloud],
        [Image.navyShapeSharpEar, Image.greenShapeSharpEar, Image.yellowShapeSharpEar, Image.pinkShapeSharpEar, Image.mauveShapeSharpEar],
        [Image.navyShapeWater, Image.greenShapeWater, Image.yellowShapeWater, Image.pinkShapeWater, Image.mauveShapeWater],
        [Image.navyShapeBread, Image.greenShapeBread, Image.yellowShapeBread, Image.pinkShapeBread, Image.mauveShapeBread],
        [Image.navyShapeRoundEar, Image.greenShapeRoundEar, Image.yellowShapeRoundEar, Image.pinkShapeRoundEar, Image.mauveShapeRoundEar],
        [Image.navyShapeJjang, Image.greenShapeJjang, Image.yellowShapeJjang, Image.pinkShapeJjang, Image.mauveShapeJjang]
    ]
}
