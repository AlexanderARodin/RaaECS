////
////  microTest.swift
////  
////
////  Created by the Dragon on 13.02.2022.
////
//
//import XCTest
//
////@testable import RaaECS
////	//	//	//	//	//	//	/
//
//
//final class microTest: XCTestCase {
//	func testEntityPopulation() throws {
//		let objA = A()
//		XCTAssert(objA.prop == .state1)
//		objA.prop = .state1
//		XCTAssert(objA.prop == .state1)
//		objA.prop = .state2
//		XCTAssert(objA.prop == .state2)
//		objA.prop = .state1
//		XCTAssert(objA.prop == .state1)
//	}
//}
//
//
//
//
//extension microTest {
//	override func setUpWithError() throws {
//		suppressLogs = false
//		raaLog("")
//		raaLog("---->")
//	}
//	override func tearDownWithError() throws {
//		suppressLogs = false
//		raaLog("###############################")
//		raaLog("")
//	}
//	
//}
//
//
//class A {
//	var prop:TstUpdt = .state1 {
//		didSet {
//			raaLog("\(oldValue) -> \(prop)")
//		}
//	}
//	
//}
//
//enum TstUpdt {
//	case state1
//	case state2
//	case state3
//}
