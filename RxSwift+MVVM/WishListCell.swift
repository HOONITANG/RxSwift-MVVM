//
//  WishListCell.swift
//  RxSwift+MVVM
//
//  Created by Taehoon Kim on 2022/06/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class WishListCell: UITableViewCell {
    
    static let reuseIdentifier = "WishListCell"
    private let disposeBag = DisposeBag()
    let container = UIView()
    let wishItemLabel = UILabel()
    let datePicker = UIDatePicker()
    let startTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    let toolbar = UIToolbar()
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
    func createDatePicker() {
        // toolbar
      
        toolbar.sizeToFit()
        //btn
       
        toolbar.setItems([doneBtn], animated: true)
        
        // assing toolbar
        startTextField.inputAccessoryView = toolbar
        // date Picker settting
        startTextField.inputView = datePicker
        
        // date picker mode
        datePicker.datePickerMode = .date
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(_ data: String, startDate: String) {
        wishItemLabel.text = data
        startTextField.text = startDate
    }
    
    public func setDateBind(viewModel: MainViewModel, selectedPayList: PayList) {
        //viewModel.inputs.selectDateInput(selectedPayList: selectedPayList)
        
        doneBtn.rx.tap.bind {
            
            var payList = selectedPayList
            payList.startDate = "\(self.datePicker.date)"
            
            viewModel.inputs.selectDateInput(selectedPayList: payList)
        }
        .disposed(by: disposeBag)
//        startTextField.rx.text.
//            .skip(1).take(1).subscribe(onNext: {
//
//        }).disposed(by: disposeBag)
        //viewModel.inputs.selectDateInput(selectedPayList: selectedPayList)
    }
    
    @objc func donePressed() {
        print("호출은되냐??")
        startTextField.text = "\(datePicker.date)"
        self.endEditing(true)
    }
    
    
    private func setupAttribute() {
        createDatePicker()
        wishItemLabel.font = .systemFont(ofSize: 15)
        wishItemLabel.textColor = .darkGray
        wishItemLabel.textAlignment = .center
    }
    
    private func setupLayout() {
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.right.bottom.left.equalToSuperview()
        }
        
        container.addSubview(wishItemLabel)
        wishItemLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().offset(16)
        }
        
        container.addSubview(startTextField)
        startTextField.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(wishItemLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().offset(16)
        }
      
    }
    
    
}
