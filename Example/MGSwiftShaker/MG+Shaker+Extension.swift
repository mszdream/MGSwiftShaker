//
//  MG+Shaker+Extension.swift
//  MGSwiftShaker
//
//  Created by hello on 2021/6/18.
//

import UIKit
import MGSwiftShaker

extension MGShaker: MGShakeDataSource {
    public func mgShake() -> Array<MGShakeModelProtocol> {
        let data1 = MGShakeDataModel()
        data1.title = "Router"
        data1.desc = "Page Router"
        let data2 = MGShakeDataModel()
        data2.title = "Log"
        data2.desc = "Show running log"
        let data3 = MGShakeDataModel()
        data3.title = "Other"
        data3.desc = "Show other content"
        
        let section = MGShakeModel()
        section.title = "Test"
        section.dataArray = [data1, data2, data3]
        
        return [section]
    }
    
    public func mgShake(selected data: MGShakeDataModelProtocol) {
        
    }
    
    public func bindingData(cell: MGShakeCell, data: MGShakeDataModelProtocol) {
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.desc
    }
    
}

extension MGShaker {
    class MGShakeDataModel: MGShakeDataModelProtocol {
        var identify: String?
        
        var title: String?
        
        var desc: String?
    }
    
    class MGShakeModel: MGShakeModelProtocol {
        var title: String?
        
        var dataArray: Array<MGShakeDataModelProtocol>?
    }
    
}
