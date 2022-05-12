//
//  Image.swift
//  Seldeog
//
//  Created by 권준상 on 2022/03/14.
//

import UIKit.UIImage

enum Image {
    // 기본 아이콘
    static let arrowDownIcon = UIImage(named: "ic_arrow_down")!
    static let arrowLeftIcon = UIImage(named: "ic_arrow_left")!
    static let arrowRightIcon = UIImage(named: "ic_arrow_right")!
    static let arrowUpIcon = UIImage(named: "ic_arrow_up_line")!
    static let xLineIcon = UIImage(named: "ic_x_line")!
    static let validIcon = UIImage(named: "ic_valid")!
    static let invalidIcon = UIImage(named: "ic_invalid")!
    static let userIcon = UIImage(named: "ic_user")!
    static let lockIcon = UIImage(named: "ic_lock")!
    static let checkPasswordIcon = UIImage(named: "ic_checkPassword")!
    static let guideIcon = UIImage(named: "ic_guide")!
    static let notificationIcon = UIImage(named: "ic_notification")!
    static let informationIcon = UIImage(named: "ic_information")!
    static let logoutIcon = UIImage(named: "ic_logout")!
    static let refreshIcon = UIImage(named: "ic_refresh")!
    static let aboutMeIconClicked = UIImage(named: "ic_aboutme")!
    static let calendarIconClicked = UIImage(named: "ic_calendar")!
    static let loveIconClicked = UIImage(named: "ic_love")!
    static let settingIconClicked = UIImage(named: "ic_setting")!
    static let aboutMeIcon = UIImage(named: "ic_aboutme_gray")!
    static let calendarIcon = UIImage(named: "ic_calendar_gray")!
    static let loveIcon = UIImage(named: "ic_love_gray")!
    static let settingIcon = UIImage(named: "ic_setting_gray")!
    static let tabBarBG = UIImage(named: "bg_tabbar")!
    static let selectColorViewBG = UIImage(named: "bg_selectColorView")!
    static let hashTagIcon = UIImage(named: "ic_hashtag")!
    static let deleteIcon = UIImage(named: "ic_delete")!
    static let modifyIcon = UIImage(named: "ic_modify")!
    static let gradientLine = UIImage(named: "gradient_line")!
    static let greenCheck = UIImage(named: "green_check")!
    
    // 캐릭터 모양
    static let navyShapeCircle = UIImage(named: "shape_navy_circle")!
    static let navyShapeCloud = UIImage(named: "shape_navy_cloud")!
    static let navyShapeBread = UIImage(named: "shape_navy_bread")!
    static let navyShapeSharpEar = UIImage(named: "shape_navy_sharpEar")!
    static let navyShapeRoundEar = UIImage(named: "shape_navy_roundEar")!
    static let navyShapeJjang = UIImage(named: "shape_navy_jjang")!
    
    static let yellowShapeCircle = UIImage(named: "shape_yellow_circle")!
    static let yellowShapeCloud = UIImage(named: "shape_yellow_cloud")!
    static let yellowShapeBread = UIImage(named: "shape_yellow_bread")!
    static let yellowShapeSharpEar = UIImage(named: "shape_yellow_sharpEar")!
    static let yellowShapeRoundEar = UIImage(named: "shape_yellow_roundEar")!
    static let yellowShapeJjang = UIImage(named: "shape_yellow_jjang")!
    
    static let pinkShapeCircle = UIImage(named: "shape_pink_circle")!
    static let pinkShapeCloud = UIImage(named: "shape_pink_cloud")!
    static let pinkShapeBread = UIImage(named: "shape_pink_bread")!
    static let pinkShapeSharpEar = UIImage(named: "shape_pink_sharpEar")!
    static let pinkShapeRoundEar = UIImage(named: "shape_pink_roundEar")!
    static let pinkShapeJjang = UIImage(named: "shape_pink_jjang")!
    
    static let mauveShapeCircle = UIImage(named: "shape_mauve_circle")!
    static let mauveShapeCloud = UIImage(named: "shape_mauve_cloud")!
    static let mauveShapeBread = UIImage(named: "shape_mauve_bread")!
    static let mauveShapeSharpEar = UIImage(named: "shape_mauve_sharpEar")!
    static let mauveShapeRoundEar = UIImage(named: "shape_mauve_roundEar")!
    static let mauveShapeJjang = UIImage(named: "shape_mauve_jjang")!
    
    static let greenShapeCircle = UIImage(named: "shape_green_circle")!
    static let greenShapeCloud = UIImage(named: "shape_green_cloud")!
    static let greenShapeBread = UIImage(named: "shape_green_bread")!
    static let greenShapeSharpEar = UIImage(named: "shape_green_sharpEar")!
    static let greenShapeRoundEar = UIImage(named: "shape_green_roundEar")!
    static let greenShapeJjang = UIImage(named: "shape_green_jjang")!
    
    // 캐릭터 표정
    static let expressionSmile = UIImage(named: "expression_smile")!
    static let expressionWink = UIImage(named: "expression_wink")!
    static let expressionExciting = UIImage(named: "expression_exciting")!
    static let expressionBlank = UIImage(named: "expression_blank")!
    static let expressionLaugh = UIImage(named: "expression_laugh")!
    
    // 캐릭터 특징
    static let featureHair1 = UIImage(named: "feature_hair1")!
    static let featureHair2 = UIImage(named: "feature_hair2")!
    static let featureSleepHat = UIImage(named: "feature_sleepHat")!
    static let featureHat = UIImage(named: "feature_hat")!
    static let featureFrog = UIImage(named: "feature_frog")!
    static let featureSunglasses = UIImage(named: "feature_sunglasses")!
    static let featureAngel = UIImage(named: "feature_angel")!
    static let featureHeadphone = UIImage(named: "feature_headphone")!
    static let featureRibbon = UIImage(named: "feature_ribbon")!
    
    static let featureBarHair1 = UIImage(named: "featureBar_hair1")!
    static let featureBarHair2 = UIImage(named: "featureBar_hair2")!
    static let featureBarSleepHat = UIImage(named: "featureBar_sleepHat")!
    static let featureBarHat = UIImage(named: "featureBar_hat")!
    static let featureBarFrog = UIImage(named: "featureBar_frog")!
    static let featureBarSunglasses = UIImage(named: "featureBar_sunglasses")!
    static let featureBarAngel = UIImage(named: "featureBar_angel")!
    static let featureBarHeadphone = UIImage(named: "featureBar_headphone")!
    static let featureBarRibbon = UIImage(named: "featureBar_ribbon")!
    static let featureBarNone = UIImage(named: "featureBar_none")!

    
    // 캐릭터 색
    static let colorNavy = UIImage(named: "color_navy")!
    static let colorMauve = UIImage(named: "color_mauve")!
    static let colorPink = UIImage(named: "color_pink")!
    static let colorGreen = UIImage(named: "color_green")!
    static let colorYellow = UIImage(named: "color_yellow")!
    
    static let checkButton = UIImage(named: "checkButton_normal")!
    static let checkButtonClicked = UIImage(named: "checkButton_clicked")!
    static let checkButtonRepeat = UIImage(named: "checkButton_repeat")!
    
    static let logoGIF = UIImage.gifImageWithName("seldukGIF")
    static let selduk = UIImage(named: "selduk")
    
    static let guide1 = UIImage(named: "user_guide1")!
    static let guide2 = UIImage(named: "user_guide2")!
    static let guide3 = UIImage(named: "user_guide3")!
    static let guide4 = UIImage(named: "user_guide4")!

}
