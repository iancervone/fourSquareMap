//
//  ViewController.swift
//  fourSquareMap
//
//  Created by Ian Cervone on 11/4/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchVC: UIViewController {
  
  var venues: [Venue] = []
  
  private let locationManager = CLLocationManager()
  let initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
  let searchRadius: CLLocationDistance = 25
  
  
  //MARK: VIEWS
  lazy var venueSearch: UISearchBar = {
    let searchbar = UISearchBar()
    return searchbar
  }()
  
  lazy var locationSearch: UISearchBar = {
    let searchbar = UISearchBar()
    return searchbar
  }()
  
  lazy var menuButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .red
    return button
  }()
  
  lazy var map: MKMapView = {
    let map = MKMapView()
    return map
  }()
  
  lazy var venueCollectionView: UICollectionView = {
    let cv = UICollectionView()
    return cv
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    setUpViews()
    setConstraints()
  }
  
  
  private func centerLocation(location: CLLocationCoordinate2D, zoomLevel: Double) {
      let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: searchRadius * zoomLevel, longitudinalMeters: searchRadius * zoomLevel)
      map.setRegion(coordinateRegion, animated: true)
    }
     

  private func setUpViews() {
    view.addSubview(venueSearch)
    view.addSubview(locationSearch)
    view.addSubview(menuButton)
    view.addSubview(map)
    view.addSubview(venueCollectionView)
  }
  
  private func setConstraints() {
    venueSearchConstraints()
    menuButtonConstraints()
    locationSearchConstraints()
    mapConstraints()
    venueCollectionViewConstraints()
  }
  
  private func venueSearchConstraints() {
    venueSearch.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      venueSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      venueSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      venueSearch.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor),
      venueSearch.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func menuButtonConstraints() {
    menuButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      menuButton.widthAnchor.constraint(equalToConstant: 50),
      menuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      menuButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func locationSearchConstraints() {
    locationSearch.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      locationSearch.topAnchor.constraint(equalTo: venueSearch.bottomAnchor),
      locationSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      locationSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      locationSearch.heightAnchor.constraint(equalToConstant: 30)
    
    ])
  }
  
  private func mapConstraints() {
    map.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      map.topAnchor.constraint(equalTo: locationSearch.bottomAnchor),
      map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      map .trailingAnchor.constraint(equalTo: view.trailingAnchor),
      map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func venueCollectionViewConstraints() {
    venueCollectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      venueCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      venueCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      venueCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
      venueCollectionView.heightAnchor.constraint(equalToConstant: 120)
    ])

  }

  
 // MARK: DATA FUNCTIONS
  
  private func locationAuthorization() {
    let status = CLLocationManager.authorizationStatus()
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      map.showsUserLocation = true
      locationManager.requestLocation()
      locationManager.startUpdatingLocation()
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
    default:
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  
}



extension SearchVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let userLocation = locationManager.location {
            centerLocation(location: userLocation.coordinate, zoomLevel: 5)
        }
        
        DispatchQueue.main.async {
            VenueAPIClient.manager.getVenues(lat: (self.locationManager.location?.coordinate.latitude)!, long: (self.locationManager.location?.coordinate.longitude)!, query: searchBar.text!) { (result) in
                switch result {
                case .success(let success):
                    self.venues = success
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
