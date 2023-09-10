//
//  NetworkManager.swift
//  VietApp
//
//  Created by Admin on 6/15/22.
//

import Foundation
import Network
final class NetworkManager {
    static let shared = NetworkManager()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknow
    enum ConnectionType {
        case wifi
        case cellular
        case ethenet
        case unknow

    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitor() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
            print(self?.isConnected ?? "n/a")
            NotificationCenter.default.post(name: .flagsChangedInternet, object: self)

            
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethenet
        }else {
            connectionType = .unknow
    }
    }
    
}
