//
//  DetailViewController.swift
//  SIMPSONSAPP
//
//  Created by Field Employee on 3/29/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

struct SimpsonJSON: Codable {
  struct SimpsonItem: Codable {
    let media: Dictionary<String, String>
    let text: String
  }
  let items: [SimpsonsItem]
}

struct SimpsonList {
  let text: UIImage
}

class DetailViewController: UITableViewController {

    var photos: [SimpsonList] = []
  
    override func viewDidLoad() {
      super.viewDidLoad()
      loadSimpsonList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return photos.count
    }

    func loadSimpsonList() {
      
      // Create a configuration
      
      let configuration = URLSessionConfiguration.ephemeral
      
      // Create a session
      
      let session = URLSession(configuration: configuration)
      
      // Setup the url
      let url = URL(string: "http://api.duckduckgo.com/?q=simpsons+characters&format=json")!
      
      // Create the task

      let task = session.dataTask(with: url) {
        
        (data, response, error) in
        
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
              return
            }
            do {
              let decoder = JSONDecoder()
              let media = try decoder.decode(SimpsonJSON.self, from: data)
              for item in media.items {
                if let imageURL = item.media["m"] {
                  let url = URL(string: imageURL)!
                  let imageData = try Data(contentsOf: url)
                  if let image = UIImage(data: imageData) {
                    let simpsonImage = SimpsonList(image: image, title: item.title)
                    self.photos.append(simpsonImage)
                  }
                }
              }
              let queue = OperationQueue.main
              queue.addOperation {
                self.tableView.reloadData()
              }
            } catch {
              print("Error info: \(error)")
            }
          }
        task.resume()
      }
  
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpsonCell", for: indexPath)

        cell.imageView?.image = photos[indexPath.row].image
        cell.textLabel?.text = photos[indexPath.row].title

        return cell
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PhotoSegue" {
      guard let cell = sender as? UITableViewCell, let photoViewController = segue.destination as? PhotoViewController,  let indexPath = tableView.indexPath(for: cell) else {
        return
      }
      let SimpsonList = photos[indexPath.row]
      photoViewController.photo = SimpsonList.image
    
    }
  }

}

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
