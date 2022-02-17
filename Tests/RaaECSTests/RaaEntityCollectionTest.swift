//
//  RaaEntityCollectionTest.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

import XCTest
import CoreGraphics

@testable import RaaECS
//	//	//	//	//	//	//	/


class RaaEntityCollectionTest: XCTestCase {
	var population = RaaEntityCollection()
	
	func testAdding() throws {
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
	
	
}


extension RaaEntityCollectionTest {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
		population = RaaEntityCollection()
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
}


class Localable: RaaComponent {
	var position: CGPoint = .zero
}

class Nameable: RaaComponent {
	var name:String
	init(_ name:String) { self.name = name }
}

