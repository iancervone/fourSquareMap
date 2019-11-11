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
    view.backgroundColor = .white
    return button
  }()
  
  lazy var map: MKMapView = {
    let map = MKMapView()
    return map
  }()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    setUpViews()
    setConstraints()
  }

  private func setUpViews() {
    view.addSubview(venueSearch)
    view.addSubview(locationSearch)
    view.addSubview(menuButton)
    view.addSubview(map)
  }
  
  private func setConstraints() {
    venueSearchConstraints()
    menuButtonConstraints()
    locationSearchConstraints()
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

