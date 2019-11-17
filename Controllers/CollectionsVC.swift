//
//  CollectionsViewController.swift
//  fourSquareMap
//
//  Created by Ian Cervone on 11/10/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit

class CollectionsVC: UIViewController {
  
  lazy var addButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  lazy var myCollectionsLabel: UILabel = {
    let label = UILabel()
    return label
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
    view.addSubview(addButton)
    view.addSubview(myCollectionsLabel)
    view.addSubview(collectionView)

    
  }
  
  private func setConstraints() {
    myCollectionsLabelConstraints()
    addButotnConstraints()
    collectionViewConstraints()
  }
  
  private func myCollectionsLabelConstraints() {
    myCollectionsLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      myCollectionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
      myCollectionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      myCollectionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      myCollectionsLabel.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func addButotnConstraints() {
    addButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      addButton.widthAnchor.constraint(equalToConstant: 50),
      addButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func collectionViewConstraints() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: myCollectionsLabel.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  

}
