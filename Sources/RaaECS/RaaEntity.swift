//
//  RaaEntity.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//


//import Foundation
//	//	//	//	//	//	//	//


public class RaaEntity {
	public typealias Component = RaaComponent
	public private(set) var components:[Component] = []
	
	public init() {}
}


extension RaaEntity {
	
	func informComponents() {
		for component in components {
			component.hasChanged(self)
		}
	}
	
	func addComponentSiletnly(_ newComponent: Component) {
		for component in components {
			if type(of: newComponent) == type(of: component) {
				return
			}
		}
		components.append(newComponent)
	}
	func removeComponentSiletnly<FilterType>( withType: FilterType.Type) {
		components.removeAll() { component in
			component is FilterType
		}
	}
}
	
public extension RaaEntity {
	
	func addComponent(_ newComponent: Component) {
		addComponentSiletnly(newComponent)
		informComponents()
	}
	func removeComponent<FilterType>( withType: FilterType.Type) {
		removeComponentSiletnly(withType: withType)
		informComponents()
	}
	
	func findComponent<FilterType>( withType: FilterType.Type) -> FilterType? {
		for component in components {
			if let component = component as? FilterType {
				return component
			}
		}
		return nil
	}
}
