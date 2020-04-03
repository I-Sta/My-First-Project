//
//  ViewController.swift
//  SIMPSONSAPP
//
//  Created by Field Employee on 3/28/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
//import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    let simpsonURL = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"

    func displayData(index: Int) {
    
        let task = URLSessionShared.downloadTask(with: simpsonURL) {
      
      (location, response, error) in
        guard let  = UIImage(data: imageData) else { return }
        OperationQueue.main.addOperation {
          self.imageView.image = image
        }
    }
    task.resume()
        
    }
//    func getImageData(location: URL) -> Data? {
//      var imageData: Data? = nil
//      do {
//        try imageData = Data(contentsOf: location)
//      } catch {
//
//      }
//      return imageData
//
//    }
}

