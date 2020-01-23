//
//  FindBeerView.swift
//  BrewDog Beers
//
//  Created by Sergio Fresneda on 1/20/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class FindBeerView: UIViewController, LoadingViewProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var beersTableView: UITableView!
    
    // MARK: - Vars
    var viewModel: FindBeerViewModelProtocol?
    var presenter: FindBeerPresenterContract?
    var searchBar: UISearchBar?
    lazy var loadingView: UIView =  LoadingView.instantiate(on: self.view)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        self.viewModel?.delegate = self
        
        self.setupNavigationController()
        self.setupSearchBar()
        self.setupTableView()
        self.reloadViews()
    }
    
    private func setupNavigationController() {
        self.title = Config.shared.appName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let sortButton = UIBarButtonItem.init(title: "Sort by ABV", style: .plain, target: self, action: #selector(changeSortBy))
        self.navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupSearchBar() {
        self.searchBar = UISearchBar.init(frame: CGRect.init(x: 0,
                                                             y: 0,
                                                             width: self.beersTableView.bounds.width,
                                                             height: 40))
        self.searchBar?.showsCancelButton = true
        self.searchBar?.placeholder = "Search a 🍺…"
        self.searchBar?.searchTextField.accessibilityIdentifier = "searchBar"
    }
    
    private func setupTableView() {
        self.beersTableView.tableHeaderView = self.searchBar
        self.beersTableView.register(UINib.init(nibName: "FindBeerTableViewCell", bundle: nil), forCellReuseIdentifier: FindBeerTableViewCell.reuseViewIdentifier)
        self.beersTableView.accessibilityIdentifier = "beersTableView"
    }
    
    // MARK: - Helpers
    private func reloadViews() {
        self.viewModel?.delegate = self
        self.searchBar?.delegate = self
        self.beersTableView.delegate = self.viewModel
        self.beersTableView.dataSource = self.viewModel
        self.beersTableView.reloadData()
    }
    
    @objc private func changeSortBy() {
        self.presenter?.changeSortBy()
    }
}

// MARK: - Contract
extension FindBeerView: FindBeerViewContract {
    func vc() -> UIViewController {
        return self
    }
    
    func configure(with viewModel: FindBeerViewModel) {
        self.viewModel = viewModel
        self.reloadViews()
    }
    
    func setNoResultsView(addView: Bool) {
        let view: UIView? = addView ?
            UINib.init(nibName: String(describing: EmptyListView.self), bundle: .main)
                .instantiate(withOwner: nil, options: nil).first as? EmptyListView : nil
        self.beersTableView.tableFooterView = view
    }
    
    func vc() -> FindBeerView {
        return self
    }
}

extension FindBeerView: FindBeerViewModelDelegate {
    func newRequest(with text: String) {
        self.presenter?.newRequest(with: text)
    }
    func cellIsPressed(at indexPath: IndexPath) {
        // call to presenter
    }
    func hideKeyboard() {
        self.searchBar?.resignFirstResponder()
    }
}

extension FindBeerView: UISearchBarDelegate {
    // MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.hideKeyboard()
    }
    
    // MARK: - SearchBar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.newRequest(with: searchBar.text ?? "")
        self.hideKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.hideKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.newRequest(with: searchText)
    }
}
