//
//  RaaEntityTest.swift
//  
//
//  Created by the Dragon on 17.02.2022.
//

import XCTest

@testable import RaaECS
//	//	//	//	//	//	//	/


class RaaEntityTest: XCTestCase {
	
	func testAdding() throws {
		let ent = RaaEntity()
		XCTAssert(ent.components.isEmpty)
		ent.addComponent(pseudoClass(3))
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
		ent.addComponent(pseudoClass(5))
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
		ent.addComponent(pseudoClass("6"))
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
	}
	
	func testRemoving() throws {
		let ent = RaaEntity()
		ent.addComponent(pseudoClass(3))
		ent.addComponent(pseudoClass("8"))
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
		ent.removeComponent(withType: Double.self)
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
		ent.removeComponent(withType: pseudoClass<Int>.self)
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
	}
	func testFinding() throws {
		let ent = RaaEntity()
		ent.addComponent(pseudoClass(3))
		ent.addComponent(pseudoClass("someText2"))
		ent.addComponent(pseudoClass(3.3))
		XCTAssert(ent.components.count == 3, "actual count: \(ent.components.count)")
		XCTAssertNil(ent.findComponent(withType: String.self))
		XCTAssertNil(ent.findComponent(withType: UInt.self))
		XCTAssertNotNil(ent.findComponent(withType: pseudoClass<String>.self))
		XCTAssert(ent.findComponent(withType: pseudoClass<String>.self)!.value == "someText2")
	}
	
	func testChanging() throws {
		let ent = RaaEntity()
		ent.addComponent(pseudoClass(3))
		ent.addComponent(pseudoClass("someText2"))
		ent.addComponent(pseudoClass(3.3))
		XCTAssertNotNil(ent.findComponent(withType: pseudoClass<String>.self))
		XCTAssert(ent.findComponent(withType: pseudoClass<String>.self)!.value == "someText2")
		ent.findComponent(withType: pseudoClass<String>.self)!.value = "newText"
		XCTAssert(ent.findComponent(withType: pseudoClass<String>.self)!.value != "someText2")
		XCTAssert(ent.findComponent(withType: pseudoClass<String>.self)!.value == "newText")
	}
	
}


extension RaaEntityTest {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
}

class pseudoClass<T>: RaaComponent {
	var value:T
	init(_ v: T) {
		self.value = v
	}
}

