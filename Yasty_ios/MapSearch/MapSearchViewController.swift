//
//  File.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import UIKit

class MapSearchViewController: UIViewController {
    var dataManager = MapSearchDataManager()
    let searchTextField = UITextField()
    let paddingView = UIView()
    let searchResultTableView = UITableView()
    var searchList: [TempKeywordResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        searchTextField.becomeFirstResponder()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .white
        }
        paddingView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        }
        searchTextField.do {
            $0.backgroundColor = .white
            $0.textColor = .black
            //라운드
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            //테두리 (음영처리는 추가적으로)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.placeholder = "맛집 키워드 검색 예) 냉면.."
            //레프트 뷰
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.returnKeyType = .search
            $0.delegate = self
        }
        searchResultTableView.do {
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func layout() {
        [ searchTextField, searchResultTableView ].forEach { view.addSubview($0) }
        
        searchTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            //위
            //세이프에이리어 개념
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            //왼쪽
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            //오른쪽
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            //높이
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        searchResultTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
}

extension MapSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //검색버튼이 눌렸을 때
        guard let text = textField.text else { return false }
        //text = "냉면"
        dataManager.postKakaoKeywordAPI(keyword: text){
            self.searchList = $0
            self.searchResultTableView.reloadData()
        }
        return true
    }
}

extension MapSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(searchList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchList[indexPath.row].name
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextField.endEditing(true)
    }
}
