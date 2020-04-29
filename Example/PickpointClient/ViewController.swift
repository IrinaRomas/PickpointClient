//
//  ViewController.swift
//  PickpointDemo
//
//  Created by Irina Romas on 25.04.2020.
//  Copyright © 2020 Irina Romas. All rights reserved.
//

import UIKit
import PickpointClient

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapCitiesBoxberry(_ sender: Any) {
        let pick = PickpointClient(serviceProvider: CityBoxberryProvider())
        pick.get(completion: { result in
            print(result.count)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func tapPickppointsBoxberry(_ sender: Any) {
        let pick = PickpointClient(serviceProvider: PointsBoxberryProvider())
        pick.get(completion: { result in
            print(result.count)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    @IBAction func tapCitiesCDEK(_ sender: Any) {
        let pick = PickpointClient(serviceProvider: CityCDEKProvider())
        pick.get(completion: { result in
            print(result.count)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func tapPickpointsCDEK(_ sender: Any) {
        let pick = PickpointClient(serviceProvider: PointsCDEKProvider())
        pick.get(completion: { result in
            print(result.count)
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
    
    
}
