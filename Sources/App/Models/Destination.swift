//
//  Destination.swift
//  CestEncoreLoin-VaporPackageDescription
//
//  Created by Rémi Caroff on 22/03/2018.
//

import Vapor
import FluentProvider
import HTTP

final class Destination: Model {
    var address: String
    var createdAt: Date
    let storage = Storage()
    
    init(row: Row) throws {
        address = try row.get("address")
        createdAt = try row.get("createdAt")
    }
    
    init(address: String) {
        self.address = address
        self.createdAt = Date()
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("address", address)
        try row.set("createdAt", createdAt)
        
        return row
    }
}

extension Destination: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { destinations in
            destinations.id()
            destinations.string("address")
            destinations.date("createdAt")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Destination: JSONConvertible {
    convenience init(json: JSON) throws {
        self.init(
            address: try json.get("address")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("address", address)
        try json.set("createdAt", createdAt)
        return json
    }
}

extension Destination: ResponseRepresentable { }
