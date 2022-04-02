//
//  ViperWithAPITests.swift
//  ViperWithAPI
//
//Created by Podalakur prasanth on 02/04/22.
//

import XCTest
@testable import ViperWithAPI

class mockPresenterToViewCryptoProtocol: PresenterToViewCryptoProtocol{
    
    func onFetchCryptoSuccess() {
        print("onFetchCryptoSuccess")
    }
    
    func onSearchCrypto() {
        print("onSearchCrypto")
    }
    
    func onFetchCryptoFailure(error: String) {
        print("onFetchCryptoFailure")
    }
    
    func showHUD() {
        print("showHUD")
    }
    
    func hideHUD() {
        print("hideHUD")
    }
}

class mockPresenterToInteractorCryptoProtocol: PresenterToInteractorCryptoProtocol{
    var presenter: InteractorToPresenterCryptoProtocol?
    
    func loadCrypto() {
        
    }
    
    func retrieveCrypto(at index: Int) {
        
    }
}

class mockCryptoRouter: PresenterToRouterCryptoProtocol{
    static func createModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(identifier: "CryptoViewController") as! CryptoViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        let presenter: ViewToPresenterCryptoProtocol & InteractorToPresenterCryptoProtocol = CryptoPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CryptoRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CryptoInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return navigationController
    }
    
    
}


class mockViewToPresenterCryptoProtocol: ViewToPresenterCryptoProtocol , InteractorToPresenterCryptoProtocol{
    func fetchCryptoSuccess(crypto: [CryptoResultStruct]) {
        
    }
    
    func fetchCryptoFailure(errorCode: Int) {
        
    }
    
    func getCryptoSuccess(_ crypto: CryptoResultStruct) {
        
    }
    
    func getCryptoFailure() {
        
    }
    
    var view: PresenterToViewCryptoProtocol?
    
    var interactor: PresenterToInteractorCryptoProtocol?
    
    var router: PresenterToRouterCryptoProtocol?
    
    var cryptoResult: [CryptoResultStruct]?
    
    func viewDidLoad() {
        print("viewDidLoad")
    }
    
    func refresh() {
        print("viewDidLoad")
    }
    
    func numberOfRowsInSection() -> Int {
        return 0
    }
    
    func numberOfRowsInSectionForSearch() -> Int {
        return 0
    }
    
    func SearchForCrypto(searchText: String) {
        print("SearchForCrypto")
    }
    
    func displayforCryptoText(indexPath: IndexPath) -> CryptoResultStruct? {
        let crypto = CryptoResultStruct(id: "12", rank: "12", symbol: "symbol", name: "name", supply: "supply", maxSupply: "maxSupply", marketCapUsd: "marketCapUsd", volumeUsd24Hr: "12.00", priceUsd: "1234", changePercent24Hr: "123.00", vwap24Hr: "98.00", explorer: "123")
        return crypto
    }
    
    func displayforSearchCryptoText(indexPath: IndexPath) -> CryptoResultStruct? {
        let crypto = CryptoResultStruct(id: "12", rank: "12", symbol: "symbol", name: "name", supply: "supply", maxSupply: "maxSupply", marketCapUsd: "marketCapUsd", volumeUsd24Hr: "12.00", priceUsd: "1234", changePercent24Hr: "123.00", vwap24Hr: "98.00", explorer: "123")
        return crypto
    }
    
    
}

class ViperWithAPITests: XCTestCase {
    var cryptoView: CryptoViewController?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCryptoViewController(){
        cryptoView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CryptoViewController") as! CryptoViewController
        cryptoView?.searchBar = UISearchBar()
        cryptoView?.refreshControl = UIRefreshControl()
        cryptoView?.cryptoTableView = UITableView()
        cryptoView?.viewDidLoad()
        cryptoView?.refresh()
        cryptoView?.onSearchCrypto()
        cryptoView?.onFetchCryptoFailure(error: "test")
        cryptoView?.searchBar((cryptoView?.searchBar ?? UISearchBar()), textDidChange: "test")
        cryptoView?.searchBarCancelButtonClicked((cryptoView?.searchBar ?? UISearchBar()))
        let cell = cryptoView?.tableView((cryptoView?.cryptoTableView ?? UITableView()), cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        cryptoView?.tableView((cryptoView?.cryptoTableView ?? UITableView()), didSelectRowAt: IndexPath(row: 0, section: 0))
       _ = cryptoView?.tableView((cryptoView?.cryptoTableView ?? UITableView()), numberOfRowsInSection: 0)
        cryptoView?.searching = true
       _ = cryptoView?.configureCell(cell: CryptoTableViewCell(), indexPath: IndexPath(row: 0, section: 0))
        cryptoView?.searching = false
       _ = cryptoView?.configureCell(cell: CryptoTableViewCell(), indexPath: IndexPath(row: 0, section: 0))
    }

    func testProtocalls() {
        cryptoView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CryptoViewController") as! CryptoViewController
        let presenter: ViewToPresenterCryptoProtocol & InteractorToPresenterCryptoProtocol = mockViewToPresenterCryptoProtocol()
        
        cryptoView?.presenter = presenter
        cryptoView?.presenter?.router = mockCryptoRouter()
        cryptoView?.presenter?.interactor = CryptoInteractor()
        cryptoView?.presenter?.interactor?.presenter = presenter
        cryptoView?.presenter?.SearchForCrypto(searchText: "searchText")
    }
    
//
//    func testTableViewHasDelegate() {
//            XCTAssertNotNil(cryptoView.cryptoTableView.delegate)
//        }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
