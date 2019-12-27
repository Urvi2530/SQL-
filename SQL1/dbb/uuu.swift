//
//  uuu.swift
//  SQL1
//
//  Created by COE-05 on 27/12/19.
//  Copyright © 2019 COE-05. All rights reserved.
//

import UIKit
class DBManager {
    
    private var dbLocation = ""
    
    private var dbObj:OpaquePointer?
    
    init() {
        self.dbLocation = (UIApplication.shared.delegate as! AppDelegate).dbPath
    }
    
    //need to open connection with database
    private func isOpen()->Bool{
        
        if sqlite3_open(self.dbLocation, &dbObj) == SQLITE_OK{
            return true
        }
        return false
    }
    
    func Execute(SQLCommnad Command:String) -> Bool {
        var isDone = true
        
        if isOpen()
        {
            var stmt:OpaquePointer?
            if sqlite3_prepare_v2(self.dbObj, Command, -1, &stmt, nil) == SQLITE_OK{
                
                sqlite3_step(stmt)
                sqlite3_finalize(stmt)
                
                sqlite3_close(self.dbObj)
                
            }
        }
        else{
            isDone = false
        }
        
        
        return isDone
    }
    func Execute(SQLQuery Query:String) -> [[String:Any]] {
        
        var readData = [[String:Any]]()
        
        isOpen()
        
        var stmt:OpaquePointer?
        if sqlite3_prepare_v2(self.dbObj, Query, -1, &stmt, nil) == SQLITE_OK{
            
            while sqlite3_step(stmt) == SQLITE_ROW{
                
                var item = [String:Any]()
                
                let colCount = sqlite3_column_count(stmt)
                
                for i in 0..<colCount{
                    
                    
                    let colName = String.init(cString:  sqlite3_column_name(stmt, i))
                    let colText = String.init(cString:sqlite3_column_text(stmt, i))
                    item[colName] = colText
                    
                }
                
                readData.append(item)
                
                
            }
            sqlite3_finalize(stmt)
            
            sqlite3_close(self.dbObj)
            
        }
        
        return readData
        
    }
    
}
