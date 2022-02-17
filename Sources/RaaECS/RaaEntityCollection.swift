//
//  RaaEntityCollection.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//


public class RaaEntityCollection {
	public typealias Entity = RaaEntity
	public typealias Component = Entity.Component
	public fileprivate(set) var entities: [Entity] = []
	
	public init() {}
}



public extension RaaEntityCollection {
	@resultBuilder
	struct EntityBuilder {
		public static func buildExpression(_ component: Component) -> [Component] {
			return [component]
		}
		public static func buildExpression(_ component: [Component]) -> [Component] {
			return component
		}
		public static func buildBlock(_ components: [Component]...) -> [Component] {
			var result:[Component] = []
			for component in components {
				result.append(contentsOf: component)
			}
			return result
		}
		public static func buildOptional(_ component: [Component]?) -> [Component] {
			return component ?? []
		}
		public static func buildEither(first component: [Component]) -> [Component] {
			return component
		}
		public static func buildEither(second component: [Component]) -> [Component] {
			return component
		}
	}
	
	func createEntity( @RaaEntityCollection.EntityBuilder _ call: ()->[Component] ) {
		let componentList = call()
		guard !componentList.isEmpty else {return}
		let newEntity = RaaEntity()
		for component in componentList {
			newEntity.addComponent(component)
		}
		entities.append(newEntity)
		newEntity.informComponents()
	}
	
	func removeAllEntities( where call: (_ entity: Entity ) -> Bool = {_ in true} ) {
		entities.removeAll() { entity in
			if entity.components.isEmpty {
				return true
			}else{
				return call(entity)
			}
		}
	}
}





public extension RaaEntityCollection {
	
	func getEntityWithComponent<PrimaryType: Component>(ofType: PrimaryType.Type) -> [(entity: RaaEntity, component: PrimaryType)] {
		var subList:[(entity: RaaEntity, component: PrimaryType)] = []
		for entity in entities {
			if let component = entity.findComponent(withType: ofType) {
				subList.append( (entity, component) )
			}
		}
		return subList
	}
	
	func getEntityWithComponents<PrimaryType:Component, SecondaryType:Component>(primaryType: PrimaryType.Type, secondaryType: SecondaryType.Type) -> [(entity: RaaEntity, primary: PrimaryType, secondary: SecondaryType)] {
		var subList:[(entity: RaaEntity, primary: PrimaryType, secondary: SecondaryType)] = []
		for entity in entities {
			if let primary = entity.findComponent(withType: primaryType) {
				if let secondary = entity.findComponent(withType: secondaryType) {
					subList.append( (entity, primary, secondary) )
				}
			}
		}
		return subList
	}
}
