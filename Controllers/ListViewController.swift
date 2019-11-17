//
//  listViewController.swift
//  fourSquareMap
//
//  Created by Ian Cervone on 11/10/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
  
 //MARK: VIEWS
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        return navBar
      }()
  
  lazy var tableView: UITableView = {
      let tv = UITableView()
      return tv
    }()
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .blue
      setUpViews()
      setConstraints()
    }

  
  //MARK: VIEW CONSTRAINTS

    private func setUpViews() {
      view.addSubview(navBar)
      view.addSubview(tableView)

      
    }
    
    private func setConstraints() {
      navBarConstraints()
      tableViewConstraints()
    }
    
    private func navBarConstraints() {
      navBar.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        navBar.heightAnchor.constraint(equalToConstant: 50)
      ])
    }
    
    private func tableViewConstraints() {
      tableView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
    }
    
    
    
    

    
    
    
    
    
  }

