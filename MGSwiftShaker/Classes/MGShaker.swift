//
//  MGShaker.swift
//  MGSwiftShaker
//
//  Created by hello on 2021/6/15.
//

import UIKit

// MARK: - data protocol
public protocol MGShakeModelProtocol {
    var title: String? { get }
    var dataArray: Array<MGShakeDataModelProtocol>? { get }
}

public protocol MGShakeDataModelProtocol {
    var identify: String? { get }
    var title: String? { get }
    var desc: String? { get }
}


// MARK: - cell
open class MGShakeCell: UITableViewCell {
    static var identifier: String { return "UITableViewCell" }
}

// MARK: - data source protocol
public protocol MGShakeDataSource: NSObjectProtocol {
    /// Get data source
    func mgShake() -> Array<MGShakeModelProtocol>
    /// It is triggered when you click cell
    func mgShake(selected data: MGShakeDataModelProtocol)
    /// Get cell type
    func mgShake() -> MGShakeCell.Type
    /// Binding cell and data model
    func bindingData(cell: MGShakeCell, data: MGShakeDataModelProtocol)
}

public extension MGShakeDataSource {
    func mgShake() -> Array<MGShakeModelProtocol> {
        return []
    }

    func mgShake(selected data: MGShakeDataModelProtocol) {
        print("list item has be clicked!")
    }

    func mgShake() -> MGShakeCell.Type {
        return MGShakeCell.self
    }

    func bindingData(cell: MGShakeCell, data: MGShakeDataModelProtocol) {
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.desc
    }
}

open class MGShaker: NSObject {
    static var shared: MGShaker? = nil
    public static func startShaker(dataSourceClosure: ((MGShaker) -> MGShakeDataSource)) {
        if self.shared == nil {
            self.shared = MGShaker()
        }
        
        if let shaker = self.shared {
            shaker.isSupport = true
            shaker.dataSource = dataSourceClosure(shaker)
        }
    }
    
    var isSupport: Bool = false
    weak var dataSource: MGShakeDataSource?
}

