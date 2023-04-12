//
//  CardViewTableViewCell.swift
//  AppMusicProject
//
//  Created by Gabriel Policastro on 09/01/23.
//

import UIKit

class CardViewTableViewCell: UITableViewCell {
    
    static let identifier: String = "CardViewTableViewCell"
    
    lazy var cardView: CustomCardView = {
        let v = CustomCardView(mode: .card)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupView()
        self.setupConstraints()
    }
    
    public func setupCell(data: CardViewModel){
        self.cardView.setupView(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        self.contentView.addSubview(self.cardView)
    }
    
    
    fileprivate func setupConstraints(){
        self.cardView.pin(to: self)
    }
    
}
