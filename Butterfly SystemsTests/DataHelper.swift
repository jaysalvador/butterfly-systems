//
//  DataHelper.swift
//  Butterfly SystemsTests
//
//  Created by Jay Salvador on 11/5/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import Foundation
import CoreData
import Butterfly_Systems

class DataHelper {

    class func getData(completion: HttpCompletionClosure<[Order]>?) {

        let dataPath = Bundle(for: DataHelper.self).path(forResource: "data", ofType: "json") ?? ""
        
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                
                completion?(.failure(HttpError.coredata))
                
                return
            }
            
            let managedObjectContext = CoreDataStack.persistentContainer.viewContext

            let data = try Data(contentsOf: URL(fileURLWithPath: dataPath))
            
            let decoder = JSONDecoder()

            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext

            decoder.dateDecodingStrategy = .formatted(.dateAndTime)

            let decoded = try decoder.decode([Order].self, from: data)
            
            completion?(.success(decoded))
        }
        catch {

            completion?(.failure(HttpError.decoding(error)))
        }
    }
}
