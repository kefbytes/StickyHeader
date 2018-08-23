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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        customizeSegmentedControl()
        customizeSearchBar()
    }

    func customizeSegmentedControl() {
        segmentedControl?.backgroundColor = .lPLLightGray
    }
    
    func customizeSearchBar() {
        searchBar?.backgroundImage = UIImage()
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
