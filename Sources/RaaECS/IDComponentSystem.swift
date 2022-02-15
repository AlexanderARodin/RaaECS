//
//  IDComponentSystem.swift
//  
//
//  Created by the Dragon on 15.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//

public struct Weak<Type: AnyObject> {
	public private(set) weak var ref:Type?
	public init(_ item: Type?) {
		self.ref = item
	}
}

public class IDComponentSystem<ComponentType: IDComponent> {
	public typealias WeakType = Weak<ComponentType>
	public private(set) var systemComponents:[WeakType] = []
	//
	public func reBuildComponentList( from components: [IDComponent] ) {
		systemComponents = []
		for component in components {
			if component.isValidID {
				if let component = component as? ComponentType {
					systemComponents.append(Weak(component))
				}
			}
		}
	}
	
	public init() {}
}

public extension IDComponentSystem {
	var count: Int {systemComponents.count}
	subscript( _ index: Int ) -> ComponentType? {systemComponents[index].ref}
	
	func findComponents( sameEntityIDWith another: IDComponent? ) -> [WeakType] {
		guard let another = another else {
			return []
		}
		var list:[WeakType] = []
		for weakComponent in systemComponents {
			if another.isTheSameIDWith(weakComponent.ref) {
				list.append(weakComponent)
			}
		}
		return list
	}
}
