//
//  ViewController.swift
//  KefBytes_StickyHeader
//
//  Created by Kent Franks on 8/21/18.
//  Copyright © 2018 Kent Franks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var stickyHeader: StickyHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var translucentNavigationBar = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController != nil && self.navigationController!.navigationBar.isTranslucent {
            translucentNavigationBar = true
        }
        stickyHeader.stickyHeaderDelegate = self
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if translucentNavigationBar {
            stickyHeader.setYposition(offset: topDistance, height: topDistance, translucent: true)
        } else {
            stickyHeader.setYposition(offset: topDistance, height: 0, translucent: false)
        }
    }
    
    // MARK: - UI Setup
    func setUI() {
        tableView.backgroundColor = .clear
        self.view.backgroundColor = .lPLLightGray
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.title = "Nav Bar Title"
        self.navigationController?.navigationBar.barTintColor = .lPLLightGray
        self.navigationController?.navigationBar.tintColor = .lPLBlue1
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    // MARK: - Scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        if scrollView == tableView {
            let offset = scrollView.contentOffset.y
            if translucentNavigationBar {
                self.stickyHeader.setYposition(offset: 0, height: topDistance, translucent: true)
            } else {
                self.stickyHeader.setYposition(offset: offset, height: 0, translucent: false)
            }
            
        }
    }
    
    public var topDistance: CGFloat{
        get{
            if translucentNavigationBar {
                if let height = self.navigationController?.navigationBar.frame.size.height {
                    return height
                } else {
                    return 0
                }
            } else {
                return 0
            }
        }
    }
}

extension ViewController: StickyHeaderDelegate {
    
    func segmentedControlChanged(withIndex: Int) {
        print("Index = \(withIndex)")
    }
    
    func searchStarted(withSearchString: String) {
        print("Search string is = \(withSearchString)")
    }

}


