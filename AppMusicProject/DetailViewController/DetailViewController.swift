//
//  DetailViewController.swift
//  AppMusicProject
//
//  Created by Gabriel Policastro on 11/01/23.
//

import UIKit

enum StateAnimation{
    case long
    case short
}

class DetailViewController: UIViewController {
    
    var screen:DetailViewControllerScreen? // tela detail
    var cardModel: CardViewModel?
    var valueAnimation: StateAnimation = .long
    
    // toda vez que vamos utilizar uma screen, precisamos utilizar uma loadView, pois eh da responsabilidade dele fazer toda a renderizacao
    override func loadView() {
        self.screen = DetailViewControllerScreen(dataView: self.cardModel)
        self.screen?.configAllDelegates(tableViewDelegate: self, tableViewDataSource: self, scrollViewDelegate: self, detailViewScreenDelegate: self)
        self.view = self.screen
    }
    
    override var prefersStatusBarHidden: Bool { //
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func animationWithView(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // isso tudo serve para validar o NavBarTopAnchor
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows.filter({$0.isKeyWindow}).first
        
        let topPadding = window?.safeAreaInsets.top
        print(topPadding as Any)
        // se a posicao for até 300
        if scrollView.contentOffset.y >= 300 {
            self.screen?.navBarTopAnchor?.constant = 0  // aqui ele esta pequeno
            
            if valueAnimation == .long { // o ultimo estado dele era longo
                animationWithView() // após disparada a animacao, troca do estado longo p o curto. A animacao confere a condicao a todo momento, enquanto o usuario faz a scrollagem,
            }
            self.valueAnimation = .short // logo ele vira pequeno
            
        } else { // aqui ele esta grande
            self.screen?.navBarTopAnchor?.constant = -((topPadding ?? 0.0) + 80)
            
            if valueAnimation == .short {
                animationWithView()
            }
            self.valueAnimation = .long
        }
    }
}


extension DetailViewController: DetailViewControllerScreenDelegate{
    func tappedCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardModel?.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell
        cell?.setupCell(data: self.cardModel?.cardList?[indexPath.row] ?? CardListModel())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.screen?.playerView.setupView(data: self.cardModel?.cardList?[indexPath.row] ?? CardListModel())
        self.screen?.playerViewBottomAnchor?.constant = 0
        self.animationWithView()
    }
    
}





