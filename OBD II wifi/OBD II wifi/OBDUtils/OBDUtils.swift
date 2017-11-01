//
//  OBDUtils.swift
//  OBD II wifi
//
//  Created by Lucas Bicca on 07/10/17.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

import Foundation
import OBD2Connect
class OBDUtils {
    
    var connection: OBDConnection
    
    init(host: String, port: UInt32, completionQueue: DispatchQueue = DispatchQueue.main, timeout: TimeInterval = 0.100) {
        connection = OBDConnection(host: host, port: port, completionQueue: completionQueue, requestTimeout: timeout)
    }
    
    func printLogWhenStateChange() {
        connection.onStateChanged = { state in
            print(state)
        }
    }
    
    func openConnection() {
        connection.open()
    }
    
    func closeConnection() {
        connection.close()
    }
    
    func startRead(deadline: Int, dataString: String) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {                    
                    data in print(data)
                })
                
                data.onFailure(block: {
                    error in print(String(describing: error))
                })
                })
            })
    }
    
    func startRead(deadline: Int, dataString: String, completion: @escaping (_ result: String) -> Void) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {
                    data in
                    print("send onSuccess: \(data)")
                    completion(data)
                })
                
                data.onFailure(block: {
                    error in completion(String(describing: error))
                })
            })
        })
    }
    
    func startRead(deadline: Int, dataString: String, label: UILabel!, completion: @escaping (_ result: String) -> Void) {
        let commandString: String = "\(dataString)\r"
        let dataToSend: Data = commandString.data(using: .ascii)!
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(deadline), qos: .default, flags: .assignCurrentContext, execute: {
            self.connection.send(data: dataToSend, completion: { data in
                data.onSuccess(block: {
                    data in
                    print("send onSuccess: \(data)")
                    label.text = ResultUtil.rawResult(result: data)
                    completion(data)
                })
                
                data.onFailure(block: {
                    error in completion(String(describing: error))
                })
            })
        })
    }
    
    func prepareToRead(obdCommand: OBDCommandEnum, completion: @escaping (_ result: Bool) -> Void) {
        startRead(deadline: 4, dataString: obdCommand.rawValue) {
            (result: String) in
            print("prepareToRead: \(result)")
            completion(true)
        }
    }
    
    class func replaceOBDCommandResult(result: String, obdCommand: OBDCommandEnum) -> String! {
        switch obdCommand {
        case .IDENTITY, .PROTOCOL_0, .DISPLAY_ACTIVITY_MONITOR_COUNT,
             .MONITOR_ALL, .READ_INPUT_VOLTAGE, .RESET:
            return replaceATCommand(result: result, obdCommand: obdCommand)
        case .ENGINE_COOLANT_TEMPERATURE:
            return EngineCoolantTemperatureUtil.calculeTemperature(result: result)
        case .ENGINE_RPM:
            return EngineRPMUtil.calculateRPM(result: result)
        case .INTAKE_AIR_TEMPERATURE:
            return IntakeAirTemperatureUtil.calculeTemperature(result: result)
        case .VEHICLE_SPEED:
            return VehicleSpeedUtil.formatSpeed(result: result)
        case .FUEL_LEVEL_INPUT:
            return FuelLevelInputUtil.formatLevel(result: result)
        case .FUEL_PRESSURE:
            return FuelPressureUtil.formatPressure(result: result)
        case .RUN_TIME_SINCE_ENGINE_START, .AMBIENT_AIR_TEMPERATURE, .MAF_AIR_FLOW_RATE:
            return replace41Command(result: result, obdCommand: obdCommand)
        default:
            return result
        }
    }
    
    class func replaceATCommand(result: String, obdCommand: OBDCommandEnum) -> String! {
        if (!ResultUtil.isReturnATCommand(result: result, obdCommand: obdCommand)) {
            return nil
        }
        let resultArray = result.components(separatedBy: "\(obdCommand.rawValue)\r")
        return resultArray[1]
    }
    
    class func replace41Command(result: String, obdCommand: OBDCommandEnum) -> String! {
        if (!ResultUtil.isReturn41Command(result: result, obdCommand: obdCommand)) {
            return nil
        }
        let resultArray = result.components(separatedBy: "\(obdCommand.rawValue)\r")
        return resultArray[1]
    }
}
