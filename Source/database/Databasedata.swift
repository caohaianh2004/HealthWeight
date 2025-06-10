//
//  Databasedata.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import Foundation
import FMDB

struct Databasedata {
    static let shared = Databasedata()
    var databasequeue: FMDatabaseQueue?
    
    private init() {
        let urlfile = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("data.db")
        
        copyDatabaseIfNeeded(fileName: "data.db")
        databasequeue = FMDatabaseQueue(path: urlfile.path)
        
        databasequeue?.inDatabase { db in
            let createTable = """
           CREATE TABLE IF NOT EXISTS data (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           time TEXT,
           weight REAL,
           weight_lb REAL,
        )
        """
            do {
                try db.executeUpdate(createTable, values: nil)
                print("✅ Mở Database thành công")
            } catch {
                print("🚨 Lỗi mở tạo bảng: \(error.localizedDescription)")
            }
        }
    }
    
    func getPath(fileName: String) -> String {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return fileURL.path
        }
    
    func copyDatabaseIfNeeded(fileName: String) {
                let dbPath = getPath(fileName: fileName)
                let fileManager = FileManager.default
                
                if !fileManager.fileExists(atPath: dbPath) {
                    guard let bundlePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
                        print("🚨 Không tìm thấy database trong bundle!")
                        return
                    }
                    do {
                        try fileManager.copyItem(atPath: bundlePath, toPath: dbPath)
                        print("Đã sao chép database đến: \(dbPath)")
                    } catch {
                        print("🚨 Lỗi khi sao chép database: \(error)")
                    }
                } else {
                    print("Database đã tồn tại tại: \(dbPath)")
                }
            }
    
    func getdata() -> [DataModel] {
        var datas: [DataModel] = []
        let query = "SELETE * FROM data"
        
        databasequeue?.inDatabase { db in
            do {
                let results = try db.executeQuery(query, values: nil)
                while results.next() {
                    let data = DataModel(
                        id: Int(results.int(forColumn: "id")),
                        time: results.string(forColumn: "time") ?? "",
                        weight: Double(results.double(forColumn: "weight")),
                        weight_lb: Double(results.double(forColumn: "weight_lb"))
                    )
                    datas.append(data)
                }
            } catch {
                print("🚨 Lỗi lấy dữ liệu Database: \(error.localizedDescription)")
            }
        }
        return datas
    }
    
    func insertData(dataMode: DataModel) {
        let query = """
        INSERT INTO data(time, weight weight_lb)
        VALUES(?,?,?,?)
     """
        databasequeue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [
                    dataMode.time,
                    dataMode.weight,
                    dataMode.weight_lb
                ])
                print("✅ Thêm dữ liệu thành công")
            } catch {
                print("🚨 Lỗi khi thêm dữ liệu: \(error.localizedDescription)")
            }
        }
    }
    
//    func updataData(dataMode: DataModel) {
//        let query = """
//        UPDATE data SET
//        time = ?
//        weight = ?
//        weight_lb = ?
//     WHERE id = ?
//     """
//        databasequeue?.inDatabase { db in
//            do {
//                try db.executeUpdate(query, values: [
//                    dataMode.time,
//                    dataMode.weight,
//                    dataMode.weight_lb,
//                    dataMode.id
//                ])
//                print("✅ Update dữ liệu thành công")
//            } catch {
//                print("Lỗi update dữ liệu: \(error.localizedDescription)")
//            }
//        }
//    }
}
