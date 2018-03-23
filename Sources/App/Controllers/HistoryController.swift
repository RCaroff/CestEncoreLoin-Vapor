//
//  HistoryController.swift
//  App
//
//  Created by Rémi Caroff on 23/03/2018.
//

import Vapor
import HTTP

final class HistoryController: ResourceRepresentable {
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try Destination.all().makeJSON()
    }
    
    func add(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else { throw Abort.badRequest }
        let destination = try Destination(json: json)
        try destination.save()
        return destination
    }
    
    func makeResource() -> Resource<Destination> {
        return Resource(index: index,
                        store: add)
    }

}

extension HistoryController: EmptyInitializable { }
