//
//  DeadlineQuery.swift
//  Deadlines
//
//  Created by Jack Devey on 10/07/2023.
//

import Foundation
import AppIntents
import CoreData

func fetchAllItems() -> [Item] {
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()

    do {
        let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return items
    } catch {
        print("Error fetching items: \(error)")
        return []
    }
}

func fetchItems(withName name: String) -> [Item] {
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    let predicate = NSPredicate(format: "name == %@", name)
    fetchRequest.predicate = predicate

    do {
        let items = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        return items
    } catch {
        print("Error fetching items: \(error)")
        return []
    }
}

struct ItemEntity: AppEntity, Identifiable {
    var id: UUID
    var name: String
    var icon: String
        
    var displayRepresentation: DisplayRepresentation { DisplayRepresentation(title: "\(name)", image: DisplayRepresentation.Image(systemName: icon)) }

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Deadline"

    static var defaultQuery = ItemQuery()
    
}

struct ItemQuery: EntityQuery, EntityStringQuery {
    func entities(for identifiers: [UUID]) async throws -> [ItemEntity] {
        fetchAllItems().compactMap { item in
            if let id = item.id, let name = item.name {
                return ItemEntity(id: id, name: name, icon: item.getIconName())
            }
            return nil
        }
    }
    
    func suggestedEntities() async throws -> [ItemEntity] {
        fetchAllItems().compactMap { item in
            if let id = item.id, let name = item.name {
                return ItemEntity(id: id, name: name, icon: item.getIconName())
            }
            return nil
        }
    }
    
    func entities(matching string: String) async throws -> [ItemEntity] {
        fetchItems(withName: string).compactMap { item in
            if let id = item.id, let name = item.name {
                return ItemEntity(id: id, name: name, icon: item.getIconName())
            }
            return nil
        }
    }
}
