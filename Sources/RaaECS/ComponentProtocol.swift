//
//  ComponentProtocol.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


public protocol ComponentProtocol: AnyObject {
	func hasChanged( _ entity: EntityCollection.Entity )
}
public extension ComponentProtocol {
	func hasChanged( _ entity: EntityCollection.Entity ) {}
}


