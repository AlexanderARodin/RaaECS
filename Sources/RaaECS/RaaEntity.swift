//
//  RaaEntity.swift
//
//
//  Created by the Dragon on 11.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


//extension RaaEntity: DBGInfo {
//}


public class RaaEntity {
	public private(set) var components:[BaseRaaComponent] = [] {
		didSet {
			notifyComponents()
		}
	}
	
	private func notifyComponents() {
		for component in components {
			component.onComponentListChanged()
		}
	}
	
	init() {
		//raaInitInfo()
	}
	deinit {
		removeAllComponents()
		//raaDEINITInfo()
	}
}


extension RaaEntity {
	func addComponent(_ newComponent: BaseRaaComponent ) {
		guard newComponent.entity === self else {return}
		func compareObjectTypes(_ a:Any, _ b:Any)->Bool {type(of: a) == type(of: b)}
		if !components.contains(where: {component in compareObjectTypes(component, newComponent) }) {
			components.append(newComponent)
		}
	}
	func removeComponent<ComponentType>( withType: ComponentType.Type ) {
		components.removeAll() {component in
			if component is ComponentType {
				return true
			}else{
				return false
			}
		}
	}
	func removeAllComponents() {
		components.removeAll() {component in
			return true
		}
	}
}

public extension RaaEntity {
	func findComponent<ComponentType>( withType: ComponentType.Type ) -> BaseRaaComponent? {
		for component in components {
			if component is ComponentType {
				return component
			}
		}
		return nil
	}
}


