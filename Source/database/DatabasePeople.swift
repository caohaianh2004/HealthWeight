//
//  DatabasePeople.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import Foundation
import FMDB

struct DatabasePeople {
    static let shared = DatabasePeople()
    var databaseQueue: FMDatabaseQueue?
    
    private init() {
        let urlfile = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("data.db")
        
        copyDatabaseIfNeeded(fileName: "data.db")
        databaseQueue = FMDatabaseQueue(path: urlfile.path)
        databaseQueue?.inDatabase { db in
        let query = """
        CREATE TABLE IF NOT EXISTS people (
        id INTEGER PRIMARY KEY AUTOINCREMENT
        name TEXT
        image TEXT
        age INTEGER
        weightKg REAL
        weightLb REAL
        heightCm REAL
        heightFt REAL
        heightln REAL
        targetWeightKg REAL
        targetWeightLb REAL
        isMale INTEGER
        isUSUnit INTEGER
       )
       """
            do {
                try db.executeUpdate(query, values: nil)
                print("✅ Mở Database thành công")
            } catch {
                print("🚨 Lỗi mở bảng: \(error.localizedDescription)")
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
    
    func getPeople() -> [DataPeople] {
        var peoples: [DataPeople] = []
        let query = "SELECT * FROM people"
        
        databaseQueue?.inDatabase { db in
            do {
                let reuslt = try db.executeQuery(query, values: nil)
                while reuslt.next() {
                    let people = DataPeople(
                        name: reuslt.string(forColumn: "name") ?? "",
                        image: reuslt.string(forColumn: "image") ?? "",
                        age: Int(reuslt.int(forColumn: "age")),
                        weightKg: Double(reuslt.double(forColumn: "weightKg")),
                        weightLb: Double(reuslt.double(forColumn: "weightLb")),
                        heightCm: Double(reuslt.double(forColumn: "heightCm")),
                        heightFt: Double(reuslt.double(forColumn: "heightFt")),
                        heightln: Double(reuslt.double(forColumn: "heightln")),
                        targetWeightKg: Double(reuslt.double(forColumn: "targetWeightKg")),
                        targetWeightLb: Double(reuslt.double(forColumn: "targetWeightLb")),
                        isMale: Int(reuslt.int(forColumn: "isMale")),
                        isUSUnit: Int(reuslt.int(forColumn: "isUSUnit")))
                    peoples.append(people)
                }
            } catch {
                print("🚨 Lỗi lấy dữ liệu Database: \(error.localizedDescription)")
            }
        }
        return peoples
    }
    
    func insertPeople(dataPeople: DataPeople) {
     let query = """
      INSERT INTO people (name, image, age, weightKg, weightLb, heightCm, heightFt, heightln, targetWeightKg, targetWeightLb, isMale, isUSUnit)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    """
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [
                    dataPeople.name,
                    dataPeople.image,
                    dataPeople.age,
                    dataPeople.weightKg,
                    dataPeople.weightLb,
                    dataPeople.heightCm,
                    dataPeople.heightFt,
                    dataPeople.heightln,
                    dataPeople.targetWeightKg,
                    dataPeople.targetWeightLb,
                    dataPeople.isMale,
                    dataPeople.isUSUnit
                ])
                print("✅ Thêm dữ liệu thành công")
            } catch {
                print("🚨 Lỗi khi thêm dữ liệu: \(error.localizedDescription)")
            }
        }
    }
}
