//
//  DetailTableViewCell.swift
//  AppMusicProject
//
//  Created by Gabriel Policastro on 13/01/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static public let identifier:String = "DetailTableViewCell"
    
    var screen: DetailTableViewCellScreen = DetailTableViewCellScreen()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // toda vez que for trabalhar com celulas, eh necessario utilizar o contentView
    // se nao for utilizado, o contentView, terei uma view Sob a Subview
    private func setupViews(){
        self.contentView.addSubview(self.screen)
    }
    
    private func setupConstraints(){
        self.screen.pin(to: self.contentView)
    }
    
    public func setupCell(data: CardListModel){
        self.screen.setupCell(data: data)
    }
}
