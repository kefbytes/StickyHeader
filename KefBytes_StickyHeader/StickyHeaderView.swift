//
//  StickyHeaderView.swift
//  KefBytes_StickyHeader
//
//  Created by Kent Franks on 8/21/18.
//  Copyright © 2018 Kent Franks. All rights reserved.
//

import UIKit

enum PhoneHeight: Int {
    case iPhoneX = 45
    case iPhoneStandard = 20
}

protocol StickyHeaderDelegate {
    func searchStarted(withSearchString: String)
}

extension StickyHeaderDelegate {
    func segmentedControlChanged(withIndex: Int) { }
}

class StickyHeaderView: UIView, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar?
    @IBOutlet var segmentedControl: UISegmentedControl?
    
    var stickyHeaderDelegate: StickyHeaderDelegate?
    let buttonBar = UIView()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        customizeSegmentedControl()
        customizeSearchBar()
    }

    // MARK: - UI
    func customizeSearchBar() {
        searchBar?.backgroundImage = UIImage()
    }
    
    func customizeSegmentedControl() {
        // create segments
        segmentedControl?.removeAllSegments()
        segmentedControl?.insertSegment(withTitle: "Client", at: 0, animated: true)
        segmentedControl?.insertSegment(withTitle: "Prospect", at: 1, animated: true)
        segmentedControl?.insertSegment(withTitle: "Local", at: 2, animated: true)
        segmentedControl?.selectedSegmentIndex = 0
        
        // set colors
        segmentedControl?.backgroundColor = .clear
        segmentedControl?.tintColor = .clear
        buttonBar.backgroundColor = UIColor.darkGray
        
        // set titles
        segmentedControl?.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 18) as Any, NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: .normal)
        segmentedControl?.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "Helvetica", size: 18) as Any, NSAttributedStringKey.foregroundColor: UIColor.darkGray], for: .selected)
        segmentedControl?.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
        
        // add as subviews
        self.addSubview(buttonBar)
        
        // Constraints
        segmentedControl?.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl?.topAnchor.constraint(equalTo: self.topAnchor)
        segmentedControl?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        segmentedControl?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonBar.topAnchor.constraint(equalTo: (segmentedControl?.bottomAnchor)!).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: (segmentedControl?.leftAnchor)!).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: (segmentedControl?.widthAnchor)!, multiplier: 1 / CGFloat((segmentedControl?.numberOfSegments)!)).isActive = true
    }

    
    // MARK: - UI Calculations
    func setYposition(offset: CGFloat = 0, height: CGFloat = 0, translucent: Bool)  {
        if translucent {
            self.frame.origin.y = height + CGFloat(getHeightForPhone().rawValue)
        } else {
            if offset < 0 {
                self.frame.origin.y = -offset
            }
        }
    }
    
    func getHeightForPhone() -> (PhoneHeight){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return .iPhoneX
            default:
                return .iPhoneStandard
            }
        }
        return .iPhoneStandard
    }
    
    // MARK: - Actions
    @IBAction func segmentControlValueChanged(segmentedControl: UISegmentedControl)  {
        stickyHeaderDelegate?.segmentedControlChanged(withIndex: segmentedControl.selectedSegmentIndex)
    }

    // MARK: - Selector
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = ((self.segmentedControl?.frame.width)! / CGFloat((self.segmentedControl?.numberOfSegments)!)) * CGFloat((self.segmentedControl?.selectedSegmentIndex)!)
        }
    }

    
    // MARK: - SearchBar
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
        guard let searchString = searchBar.text  else {
            return true
        }
        stickyHeaderDelegate?.searchStarted(withSearchString: searchString)
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    
}
