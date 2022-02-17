//
//  RaaEntity.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

import CoreData

//import Foundation
//	//	//	//	//	//	//	//


public class RaaEntity {
	public typealias Component = RaaComponent
	public private(set) var components:[Component] = []
	
	public init() {}
}


extension RaaEntity {
	
	internal func informComponents() {
		for component in components {
			component.hasChanged(self)
		}
	}
	
	public func addComponent(_ newComponent: Component) {
		for component in components {
			if type(of: newComponent) == type(of: component) {
				return
			}
		}
		components.append(newComponent)
	}
	public func removeComponent<FilterType>( withType: FilterType.Type) {
		components.removeAll() { component in
			component is FilterType
		}
	}
	public func findComponent<FilterType>( withType: FilterType.Type) -> FilterType? {
		for component in components {
			if let component = component as? FilterType {
				return component
			}
		}
		return nil
	}
}
