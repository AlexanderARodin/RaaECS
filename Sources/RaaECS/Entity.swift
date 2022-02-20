//
//  Entity.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//


//import Foundation
//	//	//	//	//	//	//	//


public class Entity {
	public typealias Component = ComponentProtocol
	public private(set) var components:[Component] = []
	
	public init() {}
}


extension Entity {
	
	func informComponents() {
		for component in components {
			component.hasChanged(self)
		}
	}
	
	func addComponentSiletnly(_ newComponent: Component) -> Bool {
		for component in components {
			if type(of: newComponent) == type(of: component) {
				return false
			}
		}
		components.append(newComponent)
		return true
	}
	func removeComponentSiletnly<FilterType>( withType: FilterType.Type) -> Bool {
		var flag = false
		components.removeAll() { component in
			if component is FilterType {
				flag = true
				return true
			}else{
				return false
			}
		}
		return flag
	}
}

public extension Entity {
	
	func addComponent(_ newComponent: Component ) {
		if addComponentSiletnly(newComponent) {
			informComponents()
		}
	}
	func removeComponent<FilterType>( withType: FilterType.Type ) {
		if removeComponentSiletnly(withType: withType) {
			informComponents()
		}
	}
	
	func findComponent<FilterType>( withType: FilterType.Type ) -> FilterType? {
		for component in components {
			if let component = component as? FilterType {
				return component
			}
		}
		return nil
	}
}
