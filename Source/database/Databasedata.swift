//
//  DatabaseData.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import Foundation
import FMDB

class DatabaseData: ObservableObject {
    static let shared = DatabaseData()
    var databaseQueue: FMDatabaseQueue?
    
    init() {
        let urlFile = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("data.db")
        
        copyDatabaseIfNeeded(fileName: "data.db")
        databaseQueue = FMDatabaseQueue(path: urlFile.path)
        databaseQueue?.inDatabase { db in
            let query = """
            CREATE TABLE IF NOT EXISTS data (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                time TEXT,
                weight REAL,
                weight_lb REAL
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
        return documentsURL.appendingPathComponent(fileName).path
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
                print("📁 Đã sao chép database đến: \(dbPath)")
            } catch {
                print("🚨 Lỗi khi sao chép database: \(error)")
            }
        } else {
            print("📁 Database đã tồn tại tại: \(dbPath)")
        }
    }

    func getRecent7Days() -> [HistoryObject] {
        var result: [HistoryObject] = []
        let query = "SELECT * FROM data ORDER BY time DESC LIMIT 8"
        
        databaseQueue?.inDatabase { db in
            do {
                let rs = try db.executeQuery(query, values: nil)
                while rs.next() {
                    let history = HistoryObject(
                        id: Int(rs.int(forColumn: "id")),
                        time: rs.string(forColumn: "time") ?? "",
                        weightKg: Float(rs.double(forColumn: "weight")),
                        weightLb: Float(rs.double(forColumn: "weight_Lb"))
                    )
                    result.append(history)
                }
                rs.close()
            } catch {
                print("🚨 Lỗi lấy dữ liệu 7 ngày: \(error.localizedDescription)")
            }
        }
        return result
    }

    func getHistory(forDays day: Int) -> [HistoryObject] {
        var result: [HistoryObject] = []
        var query = ""

        switch day {
        case 14:
            query = "SELECT * FROM data WHERE date(time) > date('now', '-14 day') ORDER BY time ASC"
        case 30:
            query = "SELECT * FROM data WHERE date(time) > date('now', '-1 month') ORDER BY time ASC"
        case 90:
            query = "SELECT * FROM data WHERE date(time) > date('now', '-3 month') ORDER BY time ASC"
        case 180:
            query = "SELECT * FROM data WHERE date(time) > date('now', '-6 month') ORDER BY time ASC"
        case 360:
            query = "SELECT * FROM data WHERE date(time) > date('now', '-1 year') ORDER BY time ASC"
        default:
            query = "SELECT * FROM data ORDER BY time ASC"
        }

        databaseQueue?.inDatabase { db in
            do {
                let rs = try db.executeQuery(query, values: nil)
                while rs.next() {
                    let history = HistoryObject(
                        id: Int(rs.int(forColumn: "id")),
                        time: rs.string(forColumn: "time") ?? "",
                        weightKg: Float(rs.double(forColumn: "weight")),
                        weightLb: Float(rs.double(forColumn: "weight_lb"))
                    )
                    result.append(history)
                }
                rs.close()
            } catch {
                print("🚨 Lỗi lấy lịch sử theo ngày: \(error.localizedDescription)")
            }
        }

        return result
    }

    func getLatestWeightEntry() -> HistoryObject? {
        var result: HistoryObject? = nil
        let query = "SELECT id, time, weight, weight_lb FROM data ORDER BY date(time) DESC LIMIT 1"

        databaseQueue?.inDatabase { db in
            do {
                let rs = try db.executeQuery(query, values: nil)
                if rs.next() {
                    let id = Int(rs.int(forColumn: "id"))
                    let time = rs.string(forColumn: "time") ?? ""
                    let weightKg = rs.double(forColumn: "weight")
                    let weightLb = rs.double(forColumn: "weight_lb")
                    result = HistoryObject( id: id, time: time, weightKg: Float(weightKg), weightLb: Float(weightLb))
                }
                rs.close()
            } catch {
                print("🚨 Lỗi lấy dữ liệu mới nhất: \(error.localizedDescription)")
            }
        }

        return result
    }

    func syncLatestWeightToHistory() {
        guard let person = DatabasePeople.shared.getPerson().first else {
            print("🚨 Không có dữ liệu người dùng để sync")
            return
        }

        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowString = formatter.string(from: now)

        let weightKg = person.weightKg
        let weightLb = person.weightLb

        let insertQuery = "INSERT INTO data (time, weight, weight_lb) VALUES (?, ?, ?)"

        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(insertQuery, values: [nowString, weightKg, weightLb])
                print("✅ Đã thêm bản ghi mới: \(weightKg) kg - \(nowString)")
            } catch {
                print("🚨 Lỗi thêm lịch sử: \(error.localizedDescription)")
            }
        }
        deleteEntriesOlderThan7Days()
    }


    func deleteEntriesOlderThan7Days() {
        let query = "DELETE FROM data WHERE date(time) < date('now', '-7 day')"
        
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: nil)
            } catch {
                print("🚨 Lỗi khi xoá bản ghi cũ: \(error.localizedDescription)")
            }
        }
    }
    
    func addWeight(time: String, weightKg: Double, weightLb: Double) {
        let query = "INSERT OR REPLACE INTO data (time, weight, weight_lb) VALUES (?, ?, ?)"
        
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [time, weightKg, weightLb])
                print("✅ Đã thêm cân nặng vào lịch sử")
            } catch {
                print("🚨 Lỗi thêm cân nặng: \(error.localizedDescription)")
            }
        }
    }

    func updateWeight(id: Int, newWeightKg: Float, newWeightLb: Float) {
        let query = "UPDATE data SET weight = ?, weight_lb = ? WHERE id = ?"
        databaseQueue?.inDatabase { db in
            do {
                try db.executeUpdate(query, values: [newWeightKg, newWeightLb, id])
                print("✅ Cập nhật thành công id: \(id)")
            } catch {
                print("🚨 Lỗi cập nhật cân nặng: \(error.localizedDescription)")
            }
        }
    }

}
