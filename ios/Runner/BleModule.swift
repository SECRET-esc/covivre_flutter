//
//  BleModule.swift
//  Runner
//
//  Created by Vovic Kucher on 10/28/20.
//

import Foundation
import CoreBluetooth


class BleModule: NSObject, CBPeripheralManagerDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    let name:String = UIDevice.current.name
    var peripheral: CBPeripheralManager!
    var centralManager: CBCentralManager!
    var bluetoothServices:CBMutableService?
    var nameCharacteristic:CBMutableCharacteristic?
    var service: CBMutableService!
    let uuid:CBUUID = CBUUID(string: "10000000-0000-0000-0000-000000000001")
    
    let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
    
    let characteristic = CBMutableCharacteristic.init(
        type: CBUUID(string: "10000000-0000-0000-0000-000000000001"),
        properties: [.read, .write, .notify],
        value: nil,
        permissions: [CBAttributePermissions.readable, CBAttributePermissions.writeable])
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
                    
                case .poweredOff:
                    print("CoreBluetooth BLE hardware is powered off")
                    break
                case .poweredOn:
                    print("CoreBluetooth BLE hardware is powered on and ready")
                    StartInspect()
                    break
                case .resetting:
                    print("CoreBluetooth BLE hardware is resetting")
                    break
                case .unauthorized:
                    print("CoreBluetooth BLE state is unauthorized")
                    break
                case .unknown:
                    print("CoreBluetooth BLE state is unknown")
                    break
                case .unsupported:
                    print("CoreBluetooth BLE hardware is unsupported on this platform")
                    break
                    
                default:
                    break
                }
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            print("default")
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral:
                            CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        print("Device name is: ", peripheral.name ?? "none")
    }
             
    

//[self.uuid]
    func StartInspect() {
        dispatchQueue.async{
            self.centralManager.scanForPeripherals(withServices: nil , options: nil)
            self.startAdvertising()
        }
        print("was clicked")
    }
    
    override init() {
        super.init()
        DispatchQueue.main.async {
            self.centralManager = CBCentralManager(delegate: self, queue: nil)
            self.peripheral = CBPeripheralManager(delegate: self, queue: nil)
        }
    }
    
    func startAdvertising() {
    peripheral.startAdvertising([CBAdvertisementDataLocalNameKey : name, CBAdvertisementDataServiceUUIDsKey :     [uuid]])
    
    }


}
