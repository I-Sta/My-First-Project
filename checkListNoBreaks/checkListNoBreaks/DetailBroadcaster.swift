//
//  DetailBroadcaster.swift
//  checkListNoBreaks
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

protocol UpdateLabelTextDelegate {
    func updateLabelText(withText text: String)
}

class DetailBroadcaster: UIViewController{
    
     var delegate : UpdateLabelTextDelegate?
    
    @IBOutlet weak var titleName: UITextField!
    
    @IBOutlet weak var dateSelected: UIDatePicker!
    
    @IBAction func sendTheDetails(_ sender: Any) {
        print("details")
        delegate?.updateLabelText(withText: titleName.text ?? "")
        delegate?.updateLabelText(withText: "\(String(describing: dateSelected))")
        dismiss(animated: true, completion: nil)
    }

}
