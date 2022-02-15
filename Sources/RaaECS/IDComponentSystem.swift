//
//  IDComponentSystem.swift
//  
//
//  Created by the Dragon on 15.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


public class IDComponentSystem<ComponentType: IDComponent> {
	public typealias pseudoType = (()->ComponentType?)
	public private(set) var systemComponents:[pseudoType] = []
	//
	public func reBuildComponentList( from components: [IDComponent] ) {
		systemComponents = []
		for component in components {
			if component.isValidID {
				if let component = component as? ComponentType {
					systemComponents.append({[weak component] in return component})
				}
			}
		}
	}
	
	var count: Int {systemComponents.count}
	subscript( _ index: Int ) -> ComponentType? {systemComponents[index]()}
	public func findComponents( sameEntityIDWith another: IDComponent ) -> [pseudoType] {
		var list:[pseudoType] = []
		for component in systemComponents {
			if another.isTheSameIDWith(component()) {
				list.append(component)
			}
		}
		return list
	}
	
	public init() {}
}

