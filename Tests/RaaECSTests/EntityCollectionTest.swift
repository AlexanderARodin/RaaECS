//
//  EntityCollectionTest.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

import XCTest
import CoreGraphics

@testable import RaaECS
//	//	//	//	//	//	//	/


final class EntityCollectionTest: XCTestCase {
	var population = EntityCollection()
	
	func testAdding() throws {
		population = EntityCollection()
		XCTAssert(population.entities.isEmpty)
		population.createEntity() {
			//
		}
		XCTAssert(population.entities.isEmpty)
		population.createEntity() {
			Nameable("theFirst")
		}
		XCTAssert(population.entities.count == 1, "actual count: \(population.entities.count)")
		population.createEntity() {
			Nameable("theSecond")
			Localable()
		}
		XCTAssert(population.entities.count == 2, "actual count: \(population.entities.count)")
		let subList1 = population.getEntityWithComponent(ofType: Nameable.self)
		XCTAssert(subList1.count == 2, "actual count: \(subList1.count)")
		XCTAssert(subList1[0].component.name == "theFirst", "actual count: \(subList1[0].component.name)")
		XCTAssert(subList1[1].component.name == "theSecond", "actual count: \(subList1[1].component.name)")
		let subList2 = population.getEntityWithComponent(ofType: Localable.self)
		XCTAssert(subList2.count == 1, "actual count: \(subList2.count)")
	}
	
	func testRemoving() throws {
		population = EntityCollection()
		XCTAssert(population.entities.isEmpty)
		population.createEntity() {
			Nameable("theFirst")
		}
		population.createEntity() {
			Nameable("theSecond")
			Localable()
		}
		population.createEntity() {
			Nameable("theFirst")
		}
		population.createEntity() {
			Nameable("theFirst")
		}
		population.createEntity() {
			Nameable("theSecond")
			Localable()
		}
		XCTAssert(population.entities.count == 5, "actual count: \(population.entities.count)")
		population.removeAllEntities() {entity in
			entity.findComponent(withType: Localable.self) != nil
		}
		XCTAssert(population.entities.count == 3, "actual count: \(population.entities.count)")
		population.removeAllEntities()
		XCTAssert(population.entities.count == 0, "actual count: \(population.entities.count)")
	}
	
	
}


extension EntityCollectionTest {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
		population = EntityCollection()
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
}


class Localable: ComponentProtocol {
	var position: CGPoint = .zero
}

class Nameable: ComponentProtocol {
	var name:String
	init(_ name:String) { self.name = name }
}

