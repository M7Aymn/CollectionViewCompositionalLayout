//
//  SpecificNotification.swift
//  Day11-Task1
//
//  Created by Mohamed Ayman on 07/08/2024.
//

import UIKit

class SpecificNotification: UIViewController {
    var delegate: NotificationOnTimeProtocol?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date(timeInterval: 60, since: Date.now)
    }
    
    @IBAction func notifyButton(_ sender: UIButton) {
        let selectedDate = datePicker.date
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: selectedDate)
        
        delegate?.sendNotificationAtSpecificTime(dateComponents: dateComponents)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
