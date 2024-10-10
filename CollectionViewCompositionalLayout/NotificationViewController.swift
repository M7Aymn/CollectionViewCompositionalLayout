//
//  ViewController.swift
//  Day11-Task1
//
//  Created by Mohamed Ayman on 07/08/2024.
//

import UIKit

class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate, NotificationOnTimeProtocol {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNotificationCenter.delegate = self
        self.requestNotificationAuthorization()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        userNotificationCenter.removeAllDeliveredNotifications()
//        userNotificationCenter.setBadgeCount(0)
//    }
    
    @IBAction func notifyAfter10SecButton(_ sender: UIButton) {
        self.sendNotificationAfter10Seconds()
    }
    
    @IBAction func notifyAtSpecificTimeButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpecificNotification") as! SpecificNotification
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestNotificationAuthorization() {
//        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
//        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
//            if let error = error {
//                print("Error: ", error)
//            }
//        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        userNotificationCenter.requestAuthorization(options: authOptions) { (granted, error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func sendNotificationAfter10Seconds() {
//        let content = UNMutableNotificationContent()
//        content.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Notification title: 5 seconds"
        notificationContent.body = "Notification body: testing notification body text size and style."
        notificationContent.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        
        notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "sunflower-street-drumloop-85bpm-163900.mp3"))
        
        if let url = Bundle.main.url(forResource: "imageNotFound", withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "imageNotFound", url: url, options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification",  content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func sendNotificationAtSpecificTime(dateComponents: DateComponents) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Notification title: Callender trigger"
        notificationContent.body = "Notification body: testing notification body text size and style."
        notificationContent.badge = NSNumber(value: 1)
        
        if let url = Bundle.main.url(forResource: "imageNotFound", withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "imageNotFound", url: url, options: nil) {
                notificationContent.attachments = [attachment]
            }
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification",  content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
      print(response.notification.request.identifier)
        self.tabBarController?.selectedIndex = 1
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

