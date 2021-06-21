//
//  MGShakeViewController.swift
//  MGSwiftShaker
//
//  Created by hello on 2021/6/17.
//

import UIKit

class MGShakeViewController: UIViewController {
    private var mainTableView = UITableView()
    private var dataSource: Array<MGShakeModelProtocol> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        dataSource = MGShaker.shared?.dataSource?.mgShake() ?? []
        
        if let cellType: MGShakeCell.Type = MGShaker.shared?.dataSource?.mgShake() {
            mainTableView.dataSource = self
            mainTableView.estimatedRowHeight = 64
            mainTableView.frame = self.view.bounds
            mainTableView.register(cellType, forCellReuseIdentifier: cellType.identifier)
            
            self.view.addSubview(mainTableView)
        }
    }
    
}

extension MGShakeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionData = dataSource[section]
        return sectionData.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionData = dataSource[section]
        return sectionData.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType: MGShakeCell.Type = MGShaker.shared?.dataSource?.mgShake(),
              let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? MGShakeCell else {
            return UITableViewCell()
        }

        let sectionData = dataSource[indexPath.section]
        if let model = sectionData.dataArray?[indexPath.row] {
            MGShaker.shared?.dataSource?.bindingData(cell: cell, data: model)
        }
        return cell
    }
    
}

extension MGShakeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionData = dataSource[indexPath.section]
        if let model = sectionData.dataArray?[indexPath.row] {
            MGShaker.shared?.dataSource?.mgShake(selected: model)
        }
    }
}
