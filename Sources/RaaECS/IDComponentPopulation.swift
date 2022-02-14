//
//  IDComponentPopulation.swift
//  
//
//  Created by the Dragon on 13.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//

fileprivate let unOptimizesMaxID = UInt.max / 16

public class IDComponentPopulation {
	public typealias EntityID = UInt
	public private(set) var components: [IDComponent] = []
	
	
	internal func createNewEntityID() -> EntityID? {
		sort()
		let maxID:EntityID = getLastIDAfterSorting()
		guard maxID > unOptimizesMaxID else {
			return maxID + 1
		}
		runOptimizationAfterSorting()
		let optimizedMaxID:EntityID = getLastIDAfterSorting()
		if optimizedMaxID >= EntityID.max {
			return nil
		}
		return optimizedMaxID + 1
	}
	
	public func removeEntityWithComponent(_ aComponent: IDComponent ) {
		let removingEntityID = aComponent.id
		components.removeAll() { component in
			if component.id == removingEntityID {
				component.id = nil
				return true
			}
			return false
		}
	}
	public func removeComponent(_ aComponent: IDComponent ) {
		components.removeAll() { component in
			if component === aComponent {
				component.id = nil
				return true
			}
			return false
		}
	}
	
	
	internal func sort() {
		components.sort() {prev,next in
			guard let prevID = prev.id else {return true}
			guard let nextID = next.id else {return false}
			return prevID < nextID
		}
	}
	private func getLastIDAfterSorting() -> EntityID {
		return components.last?.id ?? 0
	}
	private func runOptimizationAfterSorting() {
		print("runOptimizationAfterSorting")
		//		fatalError()
		var currentID:EntityID = components.first?.id ?? 0
		guard currentID > 0 else {return}
		var currentOptimumID:EntityID = 1
		for component in components {
			if component.id == currentID {
				component.id = currentOptimumID
			}else{
				currentID = component.id ?? 0
				currentOptimumID += 1
				component.id = currentOptimumID
			}
		}
	}
	
	
	public init() {}
}
//	//	//	//	//	//	//	//
//	//	//	//	//	//	//	//

extension IDComponentPopulation {
	func addComponent( _ newComponent: IDComponent ) {
		guard newComponent.id != nil else {return}
		for component in components {
			if newComponent.id == component.id {
				if type(of: newComponent) == type(of: component) {
					return
				}
			}
		}
		components.append(newComponent)
	}
}


public extension IDComponentPopulation {
	
	@resultBuilder
	struct Builder {
		public static func buildExpression(_ component: IDComponent) -> [IDComponent] {
			return [component]
		}
		public static func buildBlock(_ components: [IDComponent]...) -> [IDComponent] {
			var result:[IDComponent] = []
			for component in components {
				result.append(contentsOf: component)
			}
			return result
		}
		public static func buildOptional(_ component: [IDComponent]?) -> [IDComponent] {
			return component ?? []
		}
		public static func buildEither(first component: [IDComponent]) -> [IDComponent] {
			return component
		}
		public static func buildEither(second component: [IDComponent]) -> [IDComponent] {
			return component
		}
	}
	
	func createEntity( @IDComponentPopulation.Builder _ call: (_ newEntityID:EntityID)->[IDComponent] ) {
		guard let entityID = createNewEntityID() else {return}
		let componentList = call(entityID)
		for component in componentList {
			if component.id == entityID {
				addComponent(component)
			}
		}
	}
	
	func getComponentsFromEntityWith( component aComponent: IDComponent ) -> [IDComponent] {
		var result: [IDComponent] = []
		for component in components {
			if component.id == aComponent.id {
				result.append(component)
			}
		}
		return result
	}
	func getComponentList<ComponentType>(withType: ComponentType.Type) -> [ComponentType] {
		var result: [ComponentType] = []
		for component in components {
			if let component = component as? ComponentType {
				result.append(component)
			}
		}
		return result
	}

}


open class IDComponent {
	public typealias EntityID = IDComponentPopulation.EntityID
	internal fileprivate(set) var id: EntityID?
	
	public init( withID: EntityID ) {
		self.id = withID
	}
}


