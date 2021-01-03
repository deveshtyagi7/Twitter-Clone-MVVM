//
//  ActionSheetLauncher.swift
//  TwitterClone
//
//  Created by Devesh Tyagi on 01/01/21.
//  Copyright © 2021 Devesh Tyagi. All rights reserved.
//

import UIKit
private let reuseIdentifier = "ActionSheetCell"
class  ActionSheetLauncher: NSObject {
    //MARK: - Properties
    
    private let user : User
    private let tableView =  UITableView()
    private var window : UIWindow?
    private lazy var viewModel = ActionSheetViewModel(user: user)
    private lazy var blackView : UIView = {
       let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    private lazy var footerView : UIView = {
        let view = UIView()
        
        view.addSubview(cancleButton)
        cancleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancleButton.anchor(left : view.leftAnchor,right: view.rightAnchor,
                            paddingLeft: 12, paddingRight: 12)
        cancleButton.centerY(inView: view)
        cancleButton.layer.cornerRadius = 50 / 2
        
       return view
    }()
    private lazy var cancleButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGroupedBackground
        btn.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
       return btn
    }()
    
    //MARK: - Lifecycle
    init(user : User){
        self.user = user
        super.init()
        configureTableView()
    }
    
    //MARK: - Helpers
  
    func show(){
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = window.frame
        let height = CGFloat(viewModel.options.count * 60) + 100
        window.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: height)
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.blackView.alpha = 1
            strongSelf.tableView.frame.origin.y -= height
        })
    }
    
    func configureTableView(){
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = true
        
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    //MARK: - Selectors
   @objc func handleDismissal(){
    UIView.animate(withDuration: 0.5, animations: {[weak self] in
        guard let strongSelf = self else { return }
        let height = CGFloat(strongSelf.viewModel.options.count * 60) + 100
        strongSelf.blackView.alpha = 0
        strongSelf.tableView.frame.origin.y += height
    })
    }
}
extension ActionSheetLauncher : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier , for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
}
