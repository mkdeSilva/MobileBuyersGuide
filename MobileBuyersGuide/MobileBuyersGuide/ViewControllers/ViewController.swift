//
//  ViewController.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class ViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBAction func didTapSortButton(_ sender: UIButton) {
    }
    
    @IBAction func didTapListToggleControl(_ sender: UISegmentedControl) {
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "heh")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath) as! MobileCell
        
        let viewModel = MobileViewModel(image: UIImage(named: "unknown-phone-image")!, modelName: "iPhone 7 Plus", description: "This phone is incredible blah blabh ludem dare lorem ipsum the cyberpunk world will come to chase us down as the night comes for us and prey on the weak and crippled.", price: 43000, rating: 4.7)
        cell.configure(mobileViewModel: viewModel)
        cell.accessoryType = .detailButton
        return cell
    }
}
