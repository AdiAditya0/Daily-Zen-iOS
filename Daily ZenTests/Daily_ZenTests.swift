import XCTest
import CoreData
@testable import Daily_Zen

final class Daily_ZenTests: XCTestCase {

    var persistentContainer: NSPersistentContainer!

        override func setUp() {
            super.setUp()
            
            let container = NSPersistentContainer(name: "Daily_Zen")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error {
                    fatalError("Failed to load Core Data stack: \(error)")
                }
            })
            
            persistentContainer = container
        }

        override func tearDown() {
            persistentContainer = nil
            super.tearDown()
        }
        
        func testManagedObjectCreation() {
            let context = persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "DailyZenDetailMo", in: context)!
            let object = NSManagedObject(entity: entity, insertInto: context)
            
            object.setValue("User1", forKey: "author")
            
            do {
                try context.save()
            } catch {
                XCTFail("Failed to save context: \(error)")
            }
            
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DailyZenDetailMo")
            do {
                let fetchedObjects = try context.fetch(fetchRequest) as! [NSManagedObject]
                XCTAssertEqual(fetchedObjects.count, 1)
                XCTAssertEqual(fetchedObjects[0].value(forKey: "author") as? String, "User1")
            } catch {
                XCTFail("Failed to fetch objects: \(error)")
            }
        }
}
