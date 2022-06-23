//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by Taehoon Kim on 2022/06/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MainViewModel = MainViewModel()
    private var tableView: UITableView = UITableView()
    
    private let container = UIView()
    
    private var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitle("입력해보자는거임", for: .normal)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        bind()
        setupUI()
    }
    
    private func fetch() {
        viewModel.inputs.fetchList(context: self)
    }
    
    private func bind() {
        
        tableView.register(WishListCell.self, forCellReuseIdentifier: "WishListCell")
        
        viewModel.outputs.payList.bind(to: tableView.rx.items(cellIdentifier: "WishListCell", cellType: WishListCell.self)) { index,model,cell in
            cell.setupData(model.name, startDate: model.startDate)
            cell.setDateBind(viewModel: self.viewModel, selectedPayList: model)
        }.disposed(by: disposeBag)
        
    }
    
    private func setupUI() {
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        container.backgroundColor = .red
        
        container.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }

}

