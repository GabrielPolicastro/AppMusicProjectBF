//
//  HomeViewControllerScreen.swift
//  AppMusicProject
//
//  Created by Gabriel Policastro on 06/01/23.
//

import UIKit

class HomeViewControllerScreen: UIView {
    
    lazy var tableView:UITableView  = { // segundo passo criar elemento
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        tv.showsVerticalScrollIndicator = false
        tv.register(CardViewTableViewCell.self, forCellReuseIdentifier: CardViewTableViewCell.identifier)
        return tv
    }()
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource:UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource

    }
    
    override init(frame:CGRect) { // primeiro passo, criar init
        super.init(frame: frame)
        self.addSubview(self.tableView)// 3a // add o elemento dentro do init, agora minha view sabe q ele existe
        self.setUpConstraints() // chamar o método de constraints depois de add o elemento
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() { //4a indicar quais sao as regras de layout dele, indicar as constraints
        self.tableView.pin(to: self)
    }
    
    
    
    
    
}
