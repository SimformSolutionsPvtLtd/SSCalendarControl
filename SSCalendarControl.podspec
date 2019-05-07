#
#  Be sure to run `pod spec lint SSCalendar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "SSCalendarControl"
  spec.version      = "1.0.1"
  spec.summary      = "A simple and lightweight calendar control written in swift."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = "A simple and lightweight calendar control written in swift."

  spec.homepage     = "https://github.com/simformsolutions/SSCalendar.git"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "Ketan Chopda" => "ketan.c@simformsolutions.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "10.0"
  spec.swift_version = '4.2'

  spec.source       = { :git => "https://github.com/simformsolutions/SSCalendar.git", :tag => "#{spec.version}" }

  spec.source_files  = "SSCalendar/SSCalendar/SSCalendar/**/*.swift"
  spec.resources = ['SSCalendar/SSCalendar/SSCalendar/**/*.xib']

end
