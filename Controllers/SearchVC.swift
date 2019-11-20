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
  
  var venues = [Venue]() {
      didSet {
          venueCollectionView.reloadData()
      }
  }
  
  var images = [VenuePhoto]() {
         didSet {
             venueCollectionView.reloadData()
         }
     }
  
  var searchString: String? = nil {
     didSet{
      loadVenues()
//       map.addAnnotations(venues.filter{ $0.hasValidCoordinates })
     }
   }
  
  private let locationManager = CLLocationManager()
  let initialLocation = CLLocation(latitude: 40.742054, longitude: -73.769417)
  let searchRadius: CLLocationDistance = 25
  
  
  //MARK: VIEWS
  lazy var venueSearch: UISearchBar = {
    let searchbar = UISearchBar()
    searchbar.text = "enter a type of food"
    return searchbar
  }()
  
  lazy var locationSearch: UISearchBar = {
    let searchbar = UISearchBar()
    searchbar.text = "enter name of a city"
    return searchbar
  }()
  
  lazy var listButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "text.justify"), for: .normal)
//    button.backgroundColor = .red
    return button
  }()
  
  lazy var map: MKMapView = {
    let map = MKMapView()
    return map
  }()
  
  lazy var venueCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    layout.scrollDirection = .horizontal
//    cv.delegate = self as! UICollectionViewDelegate
//    cv.dataSource = self as! UICollectionViewDataSource
    cv.register(CollectionsVCCollectionCell.self, forCellWithReuseIdentifier: "collectionCell")
    cv.backgroundColor = .cyan
    return cv
    return cv
  }()
  
  
  //MARK: LIFECYCLES
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setUpViews()
    setConstraints()
    locationManager.delegate = self
    map.delegate = self
    locationSearch.delegate = self
    venueSearch.delegate = self
    venueCollectionView.delegate = self
    venueCollectionView.dataSource = self
    map.userTrackingMode = .follow
    locationAuthorization()
    loadVenues()
  }
  
  
  
  private func loadVenues() {
    VenueAPIClient.manager.getVenues(near: searchString ?? "New York", query: "pizza") { (result) in
          DispatchQueue.main.async {
              switch result {
              case .success(let success):
                self.venues = success
              case .failure(let error):
                  print(error)
              }
          }
      }
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

  
  
//  private func centerLocation(location: CLLocationCoordinate2D, zoomLevel: Double) {
//      let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: searchRadius * zoomLevel, longitudinalMeters: searchRadius * zoomLevel)
//      map.setRegion(coordinateRegion, animated: true)
//    }
     
  //MARK: SETUP VIEWS / CONSTRAINTS
  private func setUpViews() {
    view.addSubview(venueSearch)
    view.addSubview(locationSearch)
    view.addSubview(listButton)
    view.addSubview(map)
    view.addSubview(venueCollectionView)
  }
  
  private func setConstraints() {
    venueSearchConstraints()
    listButtonConstraints()
    locationSearchConstraints()
    mapConstraints()
    venueCollectionViewConstraints()
  }
  
  private func venueSearchConstraints() {
    venueSearch.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      venueSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      venueSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      venueSearch.trailingAnchor.constraint(equalTo: listButton.leadingAnchor),
      venueSearch.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func listButtonConstraints() {
    listButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      listButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      listButton.widthAnchor.constraint(equalToConstant: 50),
      listButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      listButton.heightAnchor.constraint(equalToConstant: 50)
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
      venueCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
      venueCollectionView.heightAnchor.constraint(equalToConstant: 120)
    ])
  }

  

  
  
}

//MARK: EXTENSIONS

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionsVCCollectionCell
        
        let theVenue = venues[indexPath.row]

      cell.venueImage.text = theVenue.venue?.name
//        cell.weeksOnLabel.text = "\(book.weeksOnList ?? 0) weeks as best seller"
//        cell.descriptionLabel.text = book.bookInfo?[0].bookDetailDescription
     
//          ImageAPIClient.manager.getImages { (result) in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let pic):
//                      self.images = pic!
//                      cell.venueImage.image = pic
//
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
//            }
        
//      if images.count > 0, let imageURL = "\(self.images[indexPath.row].prefix)\(self.images[indexPath.row].suffix)" {
//        ImageHelper.shared.getImage(urlStr: imageURL) { (result) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success (let image):
//                    cell.venueImage.image = image
//                case .failure(let error):
//                    print(error)
//              }
//            }
//          }
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("cell pressed")
//        let dvc = DetailVC()
//        dvc.modalPresentationStyle = .currentContext
//        let selectedBook = bestsellers[indexPath.row]
//        let selectedImage = images[indexPath.row]
//        dvc.bestSeller = selectedBook
//        dvc.bestSellerImage = selectedImage
//        self.present(dvc, animated: true, completion: nil)
//
//    }
    
}



extension SearchVC: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("new location \(locations)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("authorization status change to \(status.rawValue)")
    
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      locationManager.requestLocation()
    default:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}


extension SearchVC: MKMapViewDelegate {
}


extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      searchString = searchText
      print(searchString)
    }
  
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.text = ""
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
       
       let searchRequest = MKLocalSearch.Request()
       searchRequest.naturalLanguageQuery = searchBar.text
       let activeSearch = MKLocalSearch(request: searchRequest)
       activeSearch.start { (response, error) in
         
         if response == nil {
           print(error)
         } else {
           let annotaions = self.map.annotations
           self.map.removeAnnotations(annotaions)
           
           let latitude = response?.boundingRegion.center.latitude
           let longitude = response?.boundingRegion.center.longitude
           
           let newAnnotation = MKPointAnnotation()
           newAnnotation.title = searchBar.text
           newAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
           self.map.addAnnotation(newAnnotation)
           
           let coordinateRegion = MKCoordinateRegion.init(center: newAnnotation.coordinate, latitudinalMeters: self.searchRadius * 500.0, longitudinalMeters: self.searchRadius * 500.0)
           self.map.setRegion(coordinateRegion, animated: true)
         }
       }
     }
}
