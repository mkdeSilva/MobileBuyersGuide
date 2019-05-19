//
//  ViewController.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

protocol MobileListDelegate : class {
    func didTapFavourite(with index : Int)
    func didTapSortPriceHighToLow()
    func didTapSortPriceLowToHigh()
    func didTapSortRatingHighToLow()
    func didTapSortCancel()
}

class ListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, MobileListDelegate {
    
    // MobileList which contains what phones to display
    private var mobileList : MobilePhonesList = MobilePhonesList(mobiles: [], showFavourites: false)
    
    @IBAction func didTapSortButton(_ sender: Any) {
        sortView.isHidden = false
    }
    
    @IBOutlet weak var sortView: SortView!
    
    // Segmented Control for switching between All & Favourites
    @IBAction func didTapListToggleControl(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            // Tapped on all segment
            mobileList.showFavourites = false
            tableView.reloadData()
        case 1:
            // Tapped on favourites segment
            mobileList.showFavourites = true
            tableView.reloadData()
        default:
            print("Unknown segment index")
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var splashView : SplashView?
    
    let api = MobilePhoneAPI()
    
    // Shows a splash screen
    // Hide the SortView and set table view delegates and data source
    override func viewDidLoad() {
        super.viewDidLoad()
     
        splashView = SplashView(view)
        showSplashScreen()
        
        sortView.delegate = self
        sortView.configure()
        sortView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        fetchMobileList()
    }
    
    // If a row has been selected and the list view is appearing, de-select the selected row
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: API Requests
    // Get mobile list data from the API and call getMobileImages when done
    // If an error occurs, it will print the error and display error splash screen
    private func fetchMobileList() {
        api.getAllMobilePhoneData() { [unowned self] (result) in
            switch (result) {
            case .success(let values):
                self.mobileList = MobilePhonesList(mobiles: values.compactMap(MobileViewModel.init), showFavourites: false)
                self.getMobileImages()
                
                DispatchQueue.main.async {
                    self.hideSplashScreen()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.showErrorSplashScreen()
                }
            }
        }
    }
    
    // Gets images for each mobile that needs to be displayed
    private func getMobileImages() {
        for mobile in mobileList.mobilesToDisplay {
            api.getImage(urlString: mobile.imageUrl) { [unowned self] (result) in
                switch(result) {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        print("Bad data for thumbnail image for \(mobile.modelName)")
                        return
                    }
                    DispatchQueue.main.async {
                        mobile.setImage(image)
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: Handling various sort taps
    func didTapSortPriceHighToLow() {
        mobileList.sortOption = .priceHighToLow
        sortView.isHidden = true
        tableView.reloadData()
    }
    
    func didTapSortPriceLowToHigh() {
        mobileList.sortOption = .priceLowToHigh
        sortView.isHidden = true
        tableView.reloadData()
    }
    
    func didTapSortRatingHighToLow() {
        mobileList.sortOption = .ratingFiveToOne
        sortView.isHidden = true
        tableView.reloadData()
    }
    
    func didTapSortCancel() {
        sortView.isHidden = true
    }
    
    // Toggle favourite of the selected cell and set the favourite button
    func didTapFavourite(with index: Int) {
        mobileList.mobilesToDisplay[index].isFavourite.toggle()
        let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! MobileCell
        cell.setFavouriteButtonImage(favourite: mobileList.mobilesToDisplay[index].isFavourite)
    }
    
    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobileList.mobilesToDisplay.count
    }
    
    // Create a cell and configure it to the view model
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell", for: indexPath) as! MobileCell
        
        let viewModel = mobileList.mobilesToDisplay[indexPath.row]
        cell.configure(mobileViewModel: viewModel, index: indexPath.row)
        cell.delegate = self
        
        cell.setFavouriteButtonState(hidden: mobileList.showFavourites)
        
        return cell
    }
    
    // Only enables editing (deletion) when the mobileList is showing favourites
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return mobileList.showFavourites
    }
    
    // Deleting a row will toggle favourite
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            mobileList.mobilesToDisplay[indexPath.row].isFavourite.toggle()
            tableView.reloadData()
        }
    }
    
    // MARK: Segue
    
    // Segue to detail view and configure the detail view with the selected view model
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        
        let viewModel = mobileList.mobilesToDisplay[tableView.indexPathForSelectedRow!.row]
        destination.configure(with: viewModel)
    }
    
    // MARK: Splash Screen
    
    // Hides the nav bar and shows the splash screen
    fileprivate func showSplashScreen() {
        self.navigationController?.isNavigationBarHidden = true
        splashView?.showSplash()
    }
    
    // Shows the nav bar and hides the splash screen
    fileprivate func hideSplashScreen() {
        self.navigationController?.isNavigationBarHidden = false
        splashView?.hideSplash()
    }
    
    // Shows an error label on the splash screen
    fileprivate func showErrorSplashScreen() {
        splashView?.showErrorSplash()
    }
}
