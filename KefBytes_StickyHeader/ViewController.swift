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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KefBytes"
        setupNavigationBar()
        setupStickyHeader()
        stickyHeader.stickyHeaderDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let navBarHeight = self.navigationController?.navigationBar.frame.size.height else {
            return
        }
        stickyHeader.setYposition(height: navBarHeight)
    }
    
    // MARK: - UI Setup
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .lPLMediumGray
        self.navigationController?.navigationBar.tintColor = .lPLBlue1
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupStickyHeader() {
        stickyHeader.searchBar?.backgroundImage = UIImage()
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
            let contentOffset = scrollView.contentOffset.y
            print("contentOffset: ", contentOffset)
            guard let navBarHeight = self.navigationController?.navigationBar.frame.size.height else {
                return
            }
            self.stickyHeader.setYposition(height: navBarHeight)
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


