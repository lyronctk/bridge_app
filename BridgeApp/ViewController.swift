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
    

    func targetEndpointStatusResponse() -> Int {
        var res = 1
        let sem = DispatchSemaphore(value: 0)
        let url = URL(string: "https://demo6542803.mockable.io/bridgeapp")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                res = Int(json["status"] as! String)!
                sem.signal()
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        sem.wait()
        
        return res;
    }
    
    
    @objc func updateOldPersonStatus(){
        if(targetEndpointStatusResponse() == 1) {
            target_status_label.text = "PRESENT"
        }
        else {
            target_status_label.text = "ABSENT"
        }
    }
    
}

