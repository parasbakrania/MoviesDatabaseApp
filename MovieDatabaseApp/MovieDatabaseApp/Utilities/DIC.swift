//
//  DIC.swift
//  MovieDatabaseApp
//
//  Created by AdminFS on 28/06/23.
//


/// Dependency Injection Container Class
import Foundation

typealias FactoryClosure = (DIC) -> Any

protocol Configurable {
    associatedtype Configuration
    func configure(configuration: Configuration)
}

protocol DICProtocol {
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<Service>(type: Service.Type) -> Service?
}

class DIC: DICProtocol {
    
    var services = Dictionary<String, FactoryClosure>()
    
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure
    }

    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
}
