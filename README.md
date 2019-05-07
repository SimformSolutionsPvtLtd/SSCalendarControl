# SSCalendarControl
SSCalendarControl is Small and beautiful calendar control written in swift 4.2.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform][platform-image]][platform-url]
[![PRs Welcome][PR-image]][PR-url]

![Alt text](https://github.com/simformsolutions/SSCalendar/blob/develop/SSCalendar_Demo.gif)

# Features!
- Customizable control
- Flexible date range
- Customizable week day
- Selection delegates
- Customizable month and days cells
- CocoaPods

# Requirements
- iOS 10.0+
- Xcode 9+

# Installation
# Installation
 
- You can use CocoaPods to install SSCalendarControl by adding it to your Podfile:

       use_frameworks!
       pod 'SSCalendarControl'

-  
       import UIKit
       import SSCalendarControl

**Manually**
-   Download and drop **SSCalendarControl** folder in your project.
-   Congratulations!

# Usage example

-   In the storyboard add a UIView and change its class to SSCalendarView
   ![Alt text](https://github.com/simformsolutions/SSCalendar/blob/develop/SSCalendar_Usage.png)

**Setup Calendar**

    calendarView.setUpCalendar(startDate: startDate, endDate: endDate, weekStartDay: .monday, shouldSelectPastDays: true, sholudAllowMultipleSelection: false)

**Weekday Customization**

    calendarView.configuration.weekDayBorderColor = UIColor.black
    calendarView.configuration.weekDayLabelBackgroundColor = UIColor.clear
    calendarView.configuration.weekDayLabelTextColor = UIColor.black

**Month Customization**

    calendarView.configuration.monthViewBackgroundColor = UIColor.white
    calendarView.configuration.monthViewBottomLineColor = UIColor.darkGray
    calendarView.configuration.monthLabelFont = UIFont.systemFont(ofSize: 20)
    calendarView.configuration.monthLabelTextColor = UIColor.red

**Days Customization**

    calendarView.configuration.previousDayTextColor = UIColor.black
    calendarView.configuration.previousDayBorderColor = UIColor.clear
    calendarView.configuration.upcomingDaysBorderColor = UIColor.clear
    calendarView.configuration.upcomingDaysBorderColor = UIColor.clear
    calendarView.configuration.upcomingDayTextColor = UIColor.brown
    calendarView.configuration.selectedDayTextColor = UIColor.yellow
    calendarView.configuration.currentDayBorderColor = UIColor.black
    calendarView.configuration.currentDayTextColor = UIColor.white
    calendarView.configuration.currentDayBackgroundColor = UIColor.red

**Selection Delegates**
    
    calendarView.delegate = self
    
    extension ViewController: SSCalendarDeleagte {
    
        func dateSelected(_ date: Date) {
            print("selected: \(date)")
        }
    
        func dateDeSelected(_ date: Date) {
            print("deSelected: \(date)")
        }
    }

#  Contribute
-   We would love you for the contribution to SSCalendarControl, check the LICENSE file for more info.

#  Meta
-    Distributed under the MIT license. See LICENSE for more information.

[swift-image]:https://img.shields.io/badge/swift-4.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/assets/svg/badges/C-ffb83f-7198e9a1b7ad7f73977b0c9a5c7c3fffbfa25f262510e5681fd8f5a3188216b0.svg
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
[platform-image]:https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat
[platform-url]:http://cocoapods.org/pods/LFAlertController
[cocoa-image]:https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg
[cocoa-url]:https://img.shields.io/cocoapods/v/LFAlertController.svg
[PR-image]:https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
[PR-url]:http://makeapullrequest.com
