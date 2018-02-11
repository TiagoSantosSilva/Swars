//
//  PersonDetailsViewController.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PersonDetailsViewControllerDelegate {
    func didFetchHomeWorld()
    func didFetchCarList()
}

class PersonDetailsViewController: BaseViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var homeWorldLabel: UILabel!
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var noGenderLabel: UILabel!
    @IBOutlet weak var skinColorLabel: UILabel!
    @IBOutlet weak var informationContainer: UIScrollView!
    @IBOutlet weak var vehicleTableView: UITableView! {
        didSet {
            vehicleTableView.register(AboutCell.self)
        }
    }
    @IBOutlet weak var noVehiclesLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Dependencies
    
    typealias DependenciesList = HasNetworkService
    private var dataDependencies: DependenciesList?
    
    // MARK: - Dispose Bag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - View Model
    
    var personDetailsViewModel: PersonDetailsViewModelRepresentable?
    
    // MARK: - Data Manager
    
    private lazy var dataManager = {
        return StarWarsDataManager()
    }()
    
    // MARK: - Ready States
    
    var carsWereFetched = false
    
    var userInfoWasFetched = false
    
    // MARK: - Properties
    
    var personIdentifier: String?
    
    var vehicleList: [String]?
    
    // MARK: - Initializers
    
    convenience init(personIdentifier: String, dataDependencies: DependenciesList) {
        self.init()
        self.personIdentifier = personIdentifier
        self.dataDependencies = dataDependencies
        fetchPersonData()
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        setupDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vehicleTableView.frame = CGRect(x: vehicleTableView.frame.origin.x, y: vehicleTableView.frame.origin.y, width: vehicleTableView.frame.size.width, height: vehicleTableView.contentSize.height)
        vehicleTableView.reloadData()
    }
    
    // MARK: - Setups
    
    override func setupView() {
        super.setupView()
        setupActivityIndicatorView()
        setupDelegates()
    }
    
    func setupActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        activityIndicatorView.hidesWhenStopped = true
    }
    
    func setupDelegates() {
        vehicleTableView.dataSource = self
    }
    
    // MARK: - Bindings
    
    func fetchPersonData() {
        guard let personIdentifier = personIdentifier else { return }
        dataManager.getData(endpoint: "\(StarWarsEndpoints.personUrl)\(personIdentifier)", Person.self) { (result, error) in
            guard error == nil else {
                return
            }
            
            guard let response = result as? Person else {
                return
            }
            
            self.personDetailsViewModel = PersonDetailsViewModel(dataManager: self.dataManager, delegate: self)
            self.personDetailsViewModel?.person = response
        }
    }
}

extension PersonDetailsViewController: PersonDetailsViewControllerDelegate {
    func didFetchHomeWorld() {
        guard let viewModel = personDetailsViewModel else { return }
        guard let personHomeWorld = viewModel.homeWorld else { return }
        
        DispatchQueue.main.async {
            self.nameLabel.text = viewModel.name
            self.homeWorldLabel.text = "From \(personHomeWorld)"
            self.setSkinColorOutlet(viewModel: viewModel)
            self.setGenderOutlet(viewModel: viewModel)
        }
        
        userInfoIsReady()
    }
    
    fileprivate func setGenderOutlet(viewModel: PersonDetailsViewModelRepresentable) {
        switch viewModel.gender {
        case "male", "Male":
            genderImage.image = UIImage(named: "masculine")
            genderImage.isHidden = false
        case "female", "Female":
            genderImage.image = UIImage(named: "femenine")
            genderImage.isHidden = false
        default:
            noGenderLabel.isHidden = false
        }
    }
    
    func setSkinColorOutlet(viewModel: PersonDetailsViewModelRepresentable) {
        switch viewModel.skinColor {
        case "fair":
            skinColorLabel.textColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case "gold":
            skinColorLabel.textColor = #colorLiteral(red: 0.831372549, green: 0.6862745098, blue: 0.2156862745, alpha: 1)
        case "white":
            skinColorLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case "light":
            skinColorLabel.textColor = #colorLiteral(red: 0.9876733422, green: 0.9980342984, blue: 0.8046858311, alpha: 1)
        default:
            skinColorLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        skinColorLabel.text = viewModel.skinColor
    }
    
    func didFetchCarList() {
        guard let viewModel = personDetailsViewModel else { return }
        vehicleList = viewModel.carList
        handleVehicleList(vehicleList: vehicleList!)
        userCarsAreReady()
    }
    
    func handleVehicleList(vehicleList: [String]) {
        if vehicleList.isEmpty {
            DispatchQueue.main.async {
                self.noVehiclesLabel.isHidden = false
            }
        } else {
            DispatchQueue.main.async {
                self.vehicleTableView.isHidden = false
            }
            vehicleTableView.reloadData()
        }
    }
}

extension PersonDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vehicleCount = vehicleList?.count else { return 0 }
        return vehicleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vehicleCell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell else {
            fatalError("Could Not Dequeue Reusable Cell")
        }
        vehicleCell.informationLabel.text = vehicleList![indexPath.row]
        return vehicleCell
    }
}

extension PersonDetailsViewController {
    func displayView() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.informationContainer.isHidden = false
        }
    }
    
    internal func userInfoIsReady() {
        if carsWereFetched {
            displayView()
        } else {
            userInfoWasFetched = true
        }
    }
    
    internal func userCarsAreReady() {
        if userInfoWasFetched {
            displayView()
        } else {
            carsWereFetched = true
        }
    }
}
