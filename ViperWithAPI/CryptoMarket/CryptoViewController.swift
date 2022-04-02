//
//  CryptoViewController.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import UIKit
import PKHUD

class CryptoViewController: UIViewController {

    @IBOutlet  var cryptoTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var searching = false
    // MARK: - Properties
    var presenter: ViewToPresenterCryptoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }
}
extension CryptoViewController: PresenterToViewCryptoProtocol{
    func onSearchCrypto() {
        print("View receives the response from Presenter and updates itself.")
        self.cryptoTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchCryptoSuccess() {
        print("View receives the response from Presenter and updates itself.")
        self.cryptoTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchCryptoFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
}

// MARK: - UITableView Delegate & Data Source
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching == true {
             return presenter?.numberOfRowsInSectionForSearch() ?? 0
        }
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cryptoCell = self.cryptoTableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell") as? CryptoTableViewCell else {
            return UITableViewCell()
        }

        
        return self.configureCell(cell: cryptoCell, indexPath: indexPath)
    }
    
    func configureCell(cell: CryptoTableViewCell,indexPath: IndexPath) -> CryptoTableViewCell {
        if self.searching {
            cell.cryptoNameLabel?.text = "\(indexPath.row + 1) " + (presenter?.displayforSearchCryptoText(indexPath: indexPath)?.name ?? "")
            let cryptoPrice = Utils.shared.stringToFloatValue(getCryptoVal:  presenter?.displayforSearchCryptoText(indexPath: indexPath)?.marketCapUsd ?? "")
            let crypto24Th = Utils.shared.stringToFloatValue(getCryptoVal:  presenter?.displayforSearchCryptoText(indexPath: indexPath)?.changePercent24Hr ?? "")
            cell.crypto24ThLabel?.textColor = crypto24Th.1
            cell.crypto24ThLabel?.text = crypto24Th.0
            cell.cryptoPriceLabel?.textColor = cryptoPrice.1
            cell.cryptoPriceLabel?.text = cryptoPrice.0
        }else{
            cell.cryptoNameLabel?.text = "\(indexPath.row + 1) " + (presenter?.displayforCryptoText(indexPath: indexPath)?.name ?? "")
            let cryptoPrice = Utils.shared.stringToFloatValue(getCryptoVal:  presenter?.displayforCryptoText(indexPath: indexPath)?.marketCapUsd ?? "")
            let crypto24Th = Utils.shared.stringToFloatValue(getCryptoVal:  presenter?.displayforCryptoText(indexPath: indexPath)?.changePercent24Hr ?? "")
            cell.crypto24ThLabel?.textColor = crypto24Th.1
            cell.crypto24ThLabel?.text = crypto24Th.0
            cell.cryptoPriceLabel?.textColor = cryptoPrice.1
            cell.cryptoPriceLabel?.text = cryptoPrice.0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

// MARK: - UI Setup
extension CryptoViewController {
    func setupUI() {
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.searchTextField.textColor = .white
        self.cryptoTableView.addSubview(refreshControl)
        cryptoTableView.rowHeight = 70
        cryptoTableView.register(UINib(nibName: "CryptoTableViewCell", bundle: nil), forCellReuseIdentifier: "CryptoTableViewCell")
        cryptoTableView.dataSource = self
        cryptoTableView.delegate = self
        cryptoTableView.reloadData()
        self.navigationItem.title = "Simpsons Crypto"
    }
}
// MARK: -UISearchBarDelegate
extension CryptoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty  else {
            searching = false
            self.cryptoTableView.reloadData()
            return }
        searching = true
        presenter?.SearchForCrypto(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        self.view.endEditing(true)
        self.searchBar.text = ""
        self.cryptoTableView.reloadData()
    }
}
