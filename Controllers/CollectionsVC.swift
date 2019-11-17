//
//  CollectionsViewController.swift
//  fourSquareMap
//
//  Created by Ian Cervone on 11/10/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {
  
  lazy var addButotn: UIButton = {
    let button = UIButton()
    return button
  }()
  
  lazy var collectionView: UICollectionView = {
    let cv = UICollectionView()
    return cv
  }()

  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpViews()
      setConstraints()
  }
    
  private func setUpViews() {
    view.addSubview(addButotn)
    view.addSubview(collectionView)

    
  }
  
  private func setConstraints() {
    addButotnConstraints()
    collectionViewConstraints()
  }
  
  private func addButotnConstraints() {
    addButotn.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addButotn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      addButotn.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      addButotn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      addButotn.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  

}
