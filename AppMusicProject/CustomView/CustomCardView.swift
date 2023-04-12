//
//  CustomCardView.swift
//  AppMusicProject
//
//  Created by Gabriel Policastro on 09/01/23.
//

import UIKit

enum ViewMode{
    case full
    case card
}

class CustomCardView: UIView {
    
    
    //MARK: - PROPRIEDADES
    
    var vmode: ViewMode? // sistema de vizualizaçao full ou card
    var containerLeadingConstraints: NSLayoutConstraint?
    var containerTopConstraints: NSLayoutConstraint?
    var containerTrailingConstraints: NSLayoutConstraint?
    var containerBottomConstraints: NSLayoutConstraint?
    var dataModel: CardViewModel?
    
    //MARK: - ELEMENTOS
    
    // view do card
    lazy var cardContainerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false // n eh necessario com snpkit
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize(width:0, height: -2)
        v.layer.shadowRadius = 20
        return v
    }()
    
    // imagem sobre o card como um todo
    
    lazy var cardImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // n eh necessario com snpkit
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .black
        return img
    }()
    
    // view que escurece imagem do card
    
    lazy var overlayView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false // n eh necessario com snpkit
        v.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return v
    }()
    
    // bordas que ficam ao redor da imagem de perfil
    
    lazy var profileBorderView: UIView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false // n eh necessario com snpkit
        v.backgroundColor = .black
        v.layer.borderWidth = 1 // espessura
        v.layer.borderColor = UIColor.white.cgColor // borda branca
        v.layer.cornerRadius = 25 //arredondamento
        return v
    }()
    
    // imagem do Usuário
    
    lazy var cardProfilePicture: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // n eh necessario com snpkit
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .clear
        img.clipsToBounds = true
        img.layer.cornerRadius = 20 //arredondamento
        return img
    }()
    
    // Botao de adicionar imagem do Usuário
    
    lazy var addProfileImageButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    // categoria da musica
    
    lazy var cardCategoryTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        l.textColor = .white
        return l
    }()
    
    // data categoria
    
    lazy var cardCategoryDateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        l.textColor = .white
        return l
    }()
    
    // titulo
    
    lazy var cardTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    // gostei e tempo
    
    lazy var likeAndTimeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    // descricao do titulo
    
    lazy var descriptionTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .white
        l.textAlignment = .center
        l.numberOfLines = 0 // ele se auto ajusta
        return l
    }()
    
    lazy var actionsView: CardActionView = {
        let v = CardActionView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    init(mode: ViewMode){
        let frame = CGRect.zero
        super.init(frame: frame)
        self.addSubviews()
        self.setUpConstraints()
        self.updateLayout(for: mode)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // metodo criado para add elementos
    private func addSubviews(){
        self.addSubview(self.cardContainerView)
        self.cardContainerView.addSubview(self.cardImage)
        self.cardContainerView.addSubview(self.overlayView)
        
        self.cardContainerView.addSubview(self.profileBorderView)
        self.cardContainerView.addSubview(self.cardProfilePicture)
        self.cardContainerView.addSubview(self.addProfileImageButton)
        
        self.cardContainerView.addSubview(self.cardCategoryTitleLabel)
        self.cardContainerView.addSubview(self.cardCategoryDateLabel)
        self.cardContainerView.addSubview(self.cardTitle)
        self.cardContainerView.addSubview(self.likeAndTimeLabel)
        self.cardContainerView.addSubview(self.descriptionTitleLabel)
        self.cardContainerView.addSubview(self.actionsView)

    }
    
    private func setUpConstraints(){
        
        self.containerLeadingConstraints = cardContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        self.containerLeadingConstraints?.isActive = true
        
        self.containerTopConstraints = cardContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        self.containerTopConstraints?.isActive = true
        
        self.containerBottomConstraints = cardContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        self.containerBottomConstraints?.isActive = true
        
        self.containerTrailingConstraints = cardContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        self.containerTrailingConstraints?.isActive = true
        
        self.overlayView.pin(to: self.cardContainerView)
        self.cardImage.pin(to: self.cardContainerView)
        
        NSLayoutConstraint.activate([
            self.profileBorderView.topAnchor.constraint(equalTo: self.cardContainerView.topAnchor, constant: 60),
            self.profileBorderView.centerXAnchor.constraint(equalTo: cardContainerView.centerXAnchor),
            self.profileBorderView.widthAnchor.constraint(equalToConstant: 50),
            self.profileBorderView.heightAnchor.constraint(equalToConstant: 50),
            
            self.addProfileImageButton.trailingAnchor.constraint(equalTo: self.profileBorderView.trailingAnchor, constant: 4),
            self.addProfileImageButton.bottomAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: -4),
            self.addProfileImageButton.widthAnchor.constraint(equalToConstant: 20),
            self.addProfileImageButton.heightAnchor.constraint(equalToConstant: 20),
            
            self.cardProfilePicture.centerXAnchor.constraint(equalTo: self.profileBorderView.centerXAnchor),
            self.cardProfilePicture.centerYAnchor.constraint(equalTo: self.profileBorderView.centerYAnchor),
            self.cardProfilePicture.widthAnchor.constraint(equalToConstant: 40),
            self.cardProfilePicture.heightAnchor.constraint(equalToConstant: 40),
            
            self.cardCategoryTitleLabel.topAnchor.constraint(equalTo: self.profileBorderView.bottomAnchor, constant: 10),
            self.cardCategoryTitleLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardCategoryDateLabel.topAnchor.constraint(equalTo: self.cardCategoryTitleLabel.bottomAnchor, constant: 2),
            self.cardCategoryDateLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.cardTitle.topAnchor.constraint(equalTo: self.cardCategoryDateLabel.bottomAnchor, constant: 20),
            self.cardTitle.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 20),
            self.cardTitle.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -20),
            
            self.likeAndTimeLabel.topAnchor.constraint(equalTo: self.cardTitle.bottomAnchor, constant: 10),
            self.likeAndTimeLabel.centerXAnchor.constraint(equalTo: self.cardContainerView.centerXAnchor),
            
            self.descriptionTitleLabel.topAnchor.constraint(equalTo: self.likeAndTimeLabel.bottomAnchor, constant: 30),
            self.descriptionTitleLabel.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor, constant: 40),
            self.descriptionTitleLabel.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor, constant: -40),
            
            self.actionsView.bottomAnchor.constraint(equalTo: self.cardContainerView.bottomAnchor,constant: -20),
            self.actionsView.leadingAnchor.constraint(equalTo: self.cardContainerView.leadingAnchor,constant: 20),
            self.actionsView.trailingAnchor.constraint(equalTo: self.cardContainerView.trailingAnchor,constant: -20),
            self.actionsView.heightAnchor.constraint(equalToConstant: 80)
           
            ])
    }
    
    
    
    
    private func updateLayout(for mode: ViewMode){
        if mode == .full{  // se o modo for full entao....
            self.containerLeadingConstraints?.constant = 0
            self.containerTopConstraints?.constant = 0
            self.containerBottomConstraints?.constant = 0
            self.containerTrailingConstraints?.constant = 0
            self.descriptionTitleLabel.isHidden = false
        }else{
            self.containerLeadingConstraints?.constant = 30
            self.containerTopConstraints?.constant = 15
            self.containerBottomConstraints?.constant = -15
            self.containerTrailingConstraints?.constant = -30
            self.descriptionTitleLabel.isHidden = true
        }
        self.actionsView.updateLayout(for: mode)
    }
    
    // Quando cria-se uma cell ou algo customizavel, preciso de um metodo de setUp
    
    public func setupView(data: CardViewModel){
        self.cardCategoryTitleLabel.text = data.categoryName
        self.cardCategoryDateLabel.text = data.categoryDate
        self.cardTitle.text = data.cardTitle
        self.likeAndTimeLabel.attributedText = NSAttributedString.featureText(data.likeCount ?? "", data.duration ?? "")
        self.descriptionTitleLabel.text = data.cardDescription
        self.cardImage.image = UIImage(named: data.cardImage ?? "")
        self.cardProfilePicture.image = UIImage(named: data.categoryImage ?? "")

        
    }
    
    
}
