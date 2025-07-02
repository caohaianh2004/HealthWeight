//
//  DatabasePeople.swift
//  Health_Weight
//
//  Created by Boss on 10/06/2025.
//

import Foundation
import FMDB

class DatabasePeople: ObservableObject {
    static let shared = DatabasePeople()
    var databaseQueue: FMDatabaseQueue?
    
     init() {
        let urlfile = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("data.db")
        
        copyDatabaseIfNeeded(fileName: "data.db")
        databaseQueue = FMDatabaseQueue(path: urlfile.path)
        databaseQueue?.inDatabase { db in
        let query = """
        CREATE TABLE IF NOT EXISTS people (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           name TEXT,
           image TEXT,
           age INTEGER,
           weightKg REAL,
           weightLb REAL,
           heightCm REAL,
           heightFt REAL,
           heightln REAL,
           targetWeightKg REAL,
           targetWeightLb REAL,
           isMale INTEGER,
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
    
    func deletepeople(id: Int) {
    let query = "DELETE FROM people WHERE id = ?"
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [id])
                print("✅ Xoá dữ liệu thành công")
            } catch {
                print("🚨 Lỗi khi xoá dữ liệu: \(error.localizedDescription)")
            }
        }
    }
    
    func getPerson() -> [Person] {
        var person: [Person] = []
        let query = "SELECT * FROM people ORDER BY id DESC LIMIT 1"
        
        databaseQueue?.inDatabase { db in
            do {
                let result = try db.executeQuery(query, values: nil)
                if result.next() {
                    let people = Person(
                        image: result.string(forColumn: "image") ?? "",
                        heightCm: Double(result.double(forColumn: "heightCm")),
                        weightKg: Double(result.double(forColumn: "weightKg")),
                        age: Int(result.int(forColumn: "age")),
                        targetWeightLb: Double(result.double(forColumn: "targetWeightLb")),
                        heightFt: Double(result.double(forColumn: "heightFt")),
                        heightln: Double(result.double(forColumn: "heightln")),
                        weightLb: Double(result.double(forColumn: "weightLb"))
                    )
                    person.append(people)
                }
            } catch {
                print("🚨 Lỗi khi lấy dữ liệu: \(error.localizedDescription)")
            }
        }
        return person
    }
    
    func addPerson(_ person: Person) {
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate("INSERT INTO people (image, heightCm, weightKg, age, targetWeightLb, heightFt, heightln, weightLb) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                values: [person.image, person.heightCm, person.weightKg, person.age, person.targetWeightLb, person.heightFt, person.heightln, person.weightLb])
                print("✅ Thêm thành công dữ liệu vào Database")
            } catch {
                print("🚨 lỗi khi thêm dữ liệu vào Database: \(error.localizedDescription)")
            }
        }
    }
    
    func updateWeight(for id: Int, newWeight: Double) {
        let query = "UPDATE people SET weightKg = ? WHERE id = ?"
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [newWeight, id])
                print("✅ Cập nhật cân nặng thành công")
            } catch {
                print("🚨 Lỗi cập nhật cân nặng: \(error.localizedDescription)")
            }
        }
    }
    
}
