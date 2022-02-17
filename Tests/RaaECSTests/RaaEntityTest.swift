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
		ent.addComponent(Int(3))
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
		ent.addComponent(Int(5))
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
		ent.addComponent(String(5))
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
	}
	
	func testRemoving() throws {
		let ent = RaaEntity()
		ent.addComponent(Int(3))
		ent.addComponent(String(5))
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
		ent.removeComponent(withType: Double.self)
		XCTAssert(ent.components.count == 2, "actual count: \(ent.components.count)")
		ent.removeComponent(withType: Int.self)
		XCTAssert(ent.components.count == 1, "actual count: \(ent.components.count)")
	}
	func testFinding() throws {
		let ent = RaaEntity()
		ent.addComponent(Int(3))
		ent.addComponent(String("someText"))
		ent.addComponent(Double(3.3))
		XCTAssert(ent.components.count == 3, "actual count: \(ent.components.count)")
		XCTAssertNotNil(ent.findComponent(withType: String.self))
		XCTAssertNil(ent.findComponent(withType: UInt.self))
		XCTAssertNotNil(ent.findComponent(withType: String.self))
		XCTAssert(ent.findComponent(withType: String.self)! == "someText")
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
