//
//  HomeInterface.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import Foundation

protocol HomeInterface {
    func doGetAllItem()
}

protocol HomeDelegate: AnyObject {
    func didSuccessGetItems()
    func didFailedGetItems(errorMessage: String)
}

class HomePresenter: HomeInterface {
    weak var delegate: HomeDelegate?
    private let networkManager: NetworkManager
    
    var responseItems: [ItemsModel]? = nil
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func doGetAllItem() {
        networkManager.requestItems(completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let response):
                strongSelf.responseItems = response
                strongSelf.delegate?.didSuccessGetItems()
            case .failure(let error):
                self?.delegate?.didFailedGetItems(errorMessage: error.localizedDescription)
            }
        })
    }
    
}
