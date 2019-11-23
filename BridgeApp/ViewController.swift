//
//  ViewController.swift
//  BridgeApp
//
//  Created by Lyron Co Ting Keh on 11/22/19.
//  Copyright © 2019 Lyron Co Ting Keh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var target_status_label: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        scheduledTimerWithTimeInterval()
    }

    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateOldPersonStatus), userInfo: nil, repeats: true)
    }
    

    func targetEndpointStatusResponse() -> String {
        let session = URLSession.shared
        let url = URL(string: "https://demo6542803.mockable.io/bridgeapp")!

        let sem = DispatchSemaphore(value: 0)
        var responseStr = "NONE"
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            responseStr = String(data: data, encoding: .utf8)!
            sem.signal()
        }
        
        task.resume()
        sem.wait()
        return responseStr
    }
    
    
    @objc func updateOldPersonStatus(){
//        print("response: " + targetEndpointStatusResponse());
        if(targetEndpointStatusResponse() == "in_frame") {
            target_status_label.text = "PRESENT"
        }
        else {
            target_status_label.text = "ABSENT"
        }
    }
    
}

