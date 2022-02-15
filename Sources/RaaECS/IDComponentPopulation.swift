//
//  IDComponentPopulation.swift
//  
//
//  Created by the Dragon on 13.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//

internal var unOptimizesMaxID:IDComponentPopulation.EntityID = IDComponentPopulation.EntityID.max

public class IDComponentPopulation {
	public typealias EntityID = UInt32
	public private(set) var components: [IDComponent] = [] {
		didSet {
			isChanged = true
		}
	}
	public fileprivate(set) var isChanged: Bool = false
	func resetIsChanged() {isChanged = false}
	private var currentLastID: EntityID {
		get {
			components.last?.id ?? 0
		}
	}
	
	
	fileprivate func createNewEntityID() -> EntityID? {
		if currentLastID < unOptimizesMaxID {
			return currentLastID + 1
		}else{
			performOptimization()
			guard currentLastID < EntityID.max else {return nil}
			return currentLastID + 1
		}
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
	public func removeComponents<ComponentType>(withType: ComponentType.Type) {
		components.removeAll() { component in
			return ( component as? ComponentType ) != nil
		}
	}
	
	private func performOptimization() {
		//print("performOptimization!!!!!!!!!!!!!!!!!!!!!!!!!")
		cleanComponentsWithIncorrectID()
		sort()
		runOptimizationAfterSorting()
	}
	private func cleanComponentsWithIncorrectID() {
		components.removeAll() { component in
			return 0 == ( component.id ?? 0 )
		}
	}
	private func sort() {
		components.sort() {prev,next in
			guard let prevID = prev.id else {return true}
			guard let nextID = next.id else {return false}
			return prevID < nextID
		}
	}
	private func runOptimizationAfterSorting() {
		var currentOptimumID:EntityID = 1
		var currentActualID:EntityID = components.first?.id ?? 0
		guard currentActualID > 0 else {return}
		for component in components {
			if component.id == currentActualID {
				component.id = currentOptimumID
			}else{
				currentOptimumID += 1
				currentActualID = component.id ?? 0
				component.id = currentOptimumID
			}
		}
	}
	
	
	public init() {}
}
//	//	//	//	//	//	//	//
//	//	//	//	//	//	//	//

extension IDComponentPopulation {
	private func addComponent( _ newComponent: IDComponent, toEntityID entityID: EntityID ) {
		guard entityID != 0 else {return}
		for component in components {
			if component.id == entityID {
				if type(of: newComponent) == type(of: component) {
					return
				}
			}
		}
		newComponent.id = entityID
		components.append(newComponent)
	}
}


public extension IDComponentPopulation {
	
	@resultBuilder
	struct Builder {
		public static func buildExpression(_ component: IDComponent) -> [IDComponent] {
			return [component]
		}
		public static func buildExpression(_ component: [IDComponent]) -> [IDComponent] {
			return component
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
	
	func createEntity( @IDComponentPopulation.Builder _ call: ()->[IDComponent] ) {
		let componentList = call()
		guard !componentList.isEmpty else {return}
		guard let entityID = createNewEntityID() else {return}
		for component in componentList {
			addComponent(component, toEntityID: entityID)
		}
	}
}


public extension IDComponentPopulation {
	
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
	internal fileprivate(set) var id: EntityID? {
		didSet {
			onChangeID( from: oldValue, to: id)
		}
	}
	open var isValidID: Bool {
		get {
			(id ?? 0) > 0
		}
	}
	internal func onChangeID( from oldID: EntityID?, to newID: EntityID? ) {}
	
	public init() {
	}
}


