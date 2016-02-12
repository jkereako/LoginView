//
//  KeychainTests.swift
//  KeychainTests
//
//  Created by Jason Rendel on 9/23/14.
//  Copyright (c) 2014 Jason Rendel. All rights reserved.
//
//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import XCTest
@testable import LoginView

class KeychainTestSubject: NSObject, NSCoding {
  var objectName = "Name"
  var objectRating = 0

  override init() { }

  required init?(coder decoder: NSCoder) {
    if let name = decoder.decodeObjectForKey("objectName") as? String {
      self.objectName = name
    }

    self.objectRating = decoder.decodeIntegerForKey("objectRating")
  }

  func encodeWithCoder(encoder: NSCoder) {
    encoder.encodeObject(self.objectName, forKey: "objectName")
    encoder.encodeInteger(self.objectRating, forKey: "objectRating")
  }
}

class KeychainTests: XCTestCase {

  let testKey = "myTestKey"
  let testString = "This is a test"

  let testKey2 = "testKey2"
  let testString2 = "Test 2 String"

  let defaultServiceName = Keychain.serviceName
  let testServiceName = "myTestService"

  let defaultAccessGroup = Keychain.accessGroup
  let testAccessGroup = "myTestAccessGroup"

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {

    // clean up keychain
    Keychain.removeObjectForKey(testKey)
    Keychain.removeObjectForKey(testKey2)

    // reset keychain service name to default
    Keychain.serviceName = defaultServiceName

    // reset keychain access group to default
    Keychain.accessGroup = defaultAccessGroup

    super.tearDown()
  }

  func testDefaultServiceName() {
    let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
    if let bundleIdentifierString = bundleIdentifier {
      XCTAssertEqual(Keychain.serviceName, bundleIdentifierString, "Service Name should be equal to the bundle identifier when it is accessible")
    } else {
      XCTAssertEqual(Keychain.serviceName, "SwiftKeychain", "Service Name should be equal to SwiftKeychain when the bundle identifier is not accessible")
    }
  }

  func testSettingServiceName() {
    Keychain.serviceName = testServiceName;

    XCTAssertEqual(Keychain.serviceName, testServiceName, "Service Name should have been set to our custom service name")
  }

  func testDefaultAccessGroup() {
    XCTAssertTrue(Keychain.accessGroup.isEmpty, "Access Group should be empty when nothing is set")
  }

  func testSettingAccessGroup() {
    Keychain.accessGroup = testAccessGroup

    XCTAssertEqual(Keychain.accessGroup, testAccessGroup, "Access Group should have been set to our custom access group")
  }

  func testHasValueForKey() {
    XCTAssertFalse(Keychain.hasValueForKey(testKey), "Keychain should not have a value for the test key")

    Keychain.setString(testString, forKey: testKey)

    XCTAssertTrue(Keychain.hasValueForKey(testKey), "Keychain should have a value for the test key after it is set")
  }

  func testRemoveObjectFromKeychain() {
    Keychain.setString(testString, forKey: testKey)

    XCTAssertTrue(Keychain.hasValueForKey(testKey), "Keychain should have a value for the test key after it is set")

    Keychain.removeObjectForKey(testKey)

    XCTAssertFalse(Keychain.hasValueForKey(testKey), "Keychain should not have a value for the test key after it is removed")
  }

  func testStringSave() {
    let stringSaved = Keychain.setString(testString, forKey: testKey)

    XCTAssertTrue(stringSaved, "String did not save to Keychain")

    // clean up keychain
    Keychain.removeObjectForKey(testKey)
  }

  func testStringRetrieval() {
    Keychain.setString(testString, forKey: testKey)

    if let retrievedString = Keychain.stringForKey(testKey) {
      XCTAssertEqual(retrievedString, testString, "String retrieved for key should equal string saved for key")
    } else {
      XCTFail("String for Key not found")
    }
  }

  func testStringRetrievalWhenValueDoesNotExist() {
    let retrievedString = Keychain.stringForKey(testKey)
    XCTAssertNil(retrievedString, "String for Key should not exist")
  }

  func testMultipleStringSave() {
    Keychain.serviceName = "com.yaddayadda.whatever"

    if !Keychain.setString(testString, forKey: testKey) {
      XCTFail("String for testKey did not save")
    }

    if !Keychain.setString(testString2, forKey: testKey2) {
      XCTFail("String for testKey2 did not save")
    }

    if let string1Retrieved = Keychain.stringForKey(testKey) {
      XCTAssertEqual(string1Retrieved, testString, "String retrieved for testKey should match string saved to testKey")
    } else {
      XCTFail("String for testKey could not be retrieved")
    }

    if let string2Retrieved = Keychain.stringForKey(testKey2) {
      XCTAssertEqual(string2Retrieved, testString2, "String retrieved for testKey2 should match string saved to testKey2")
    } else {
      XCTFail("String for testKey2 could not be retrieved")
    }
  }

  func testMultipleStringsSavedToSameKey() {
    Keychain.serviceName = "com.yaddayadda.whatever"

    if !Keychain.setString(testString, forKey: testKey) {
      XCTFail("String for testKey did not save")
    }

    if let string1Retrieved = Keychain.stringForKey(testKey) {
      XCTAssertEqual(string1Retrieved, testString, "String retrieved for testKey after first save should match first string saved testKey")
    } else {
      XCTFail("String for testKey could not be retrieved")
    }

    if !Keychain.setString(testString2, forKey: testKey) {
      XCTFail("String for testKey did not update")
    }

    if let string2Retrieved = Keychain.stringForKey(testKey) {
      XCTAssertEqual(string2Retrieved, testString2, "String retrieved for testKey after update should match secind string saved to testKey")
    } else {
      XCTFail("String for testKey could not be retrieved after update")
    }
  }

  func testNSCodingObjectSave() {
    let myTestObject = KeychainTestSubject()
    let objectSaved = Keychain.setObject(myTestObject, forKey: testKey)

    XCTAssertTrue(objectSaved, "Object that implements NSCoding should save to Keychain")
  }

  func testNSCodingObjectRetrieval() {
    let testInt: Int = 9
    let myTestObject = KeychainTestSubject()
    myTestObject.objectName = testString
    myTestObject.objectRating = testInt

    Keychain.setObject(myTestObject, forKey: testKey)

    if let retrievedObject = Keychain.objectForKey(testKey) as? KeychainTestSubject{
      XCTAssertEqual(retrievedObject.objectName, testString, "NSCoding compliant object retrieved for key should have objectName property equal to what it was stored with")
      XCTAssertEqual(retrievedObject.objectRating, testInt, "NSCoding compliant object retrieved for key should have objectRating property equal to what it was stored with")
    } else {
      XCTFail("Object for Key not found")
    }
  }

  func testNSCodingObjectRetrievalWhenValueDoesNotExist() {
    let retrievedObject = Keychain.objectForKey(testKey) as? KeychainTestSubject
    XCTAssertNil(retrievedObject, "Object for Key should not exist")
  }

  func testNSDataSave() {
    let testData = testString.dataUsingEncoding(NSUTF8StringEncoding)

    if let data = testData {
      let dataSaved = Keychain.setData(data, forKey: testKey)

      XCTAssertTrue(dataSaved, "Data did not save to Keychain")
    } else {
      XCTFail("Failed to create NSData")
    }
  }

  func testNSDataRetrieval() {
    guard let testData = testString.dataUsingEncoding(NSUTF8StringEncoding) else {
      XCTFail("Failed to create NSData")
      return
    }

    Keychain.setData(testData, forKey: testKey)

    guard let retrievedData = Keychain.dataForKey(testKey) else {
      XCTFail("Data for Key not found")
      return
    }

    if Keychain.dataRefForKey(testKey) == nil {
      XCTFail("Data references for Key not found")
    }

    if let retrievedString = NSString(data: retrievedData, encoding: NSUTF8StringEncoding) {
      XCTAssertEqual(retrievedString, testString, "String retrieved from data for key should equal string saved as data for key")
    } else {
      XCTFail("Output Data for key does not match input. ")
    }
  }

  func testNSDataRetrievalWhenValueDoesNotExist() {
    let retrievedData = Keychain.dataForKey(testKey)
    XCTAssertNil(retrievedData, "Data for Key should not exist")

    let retrievedDataRef = Keychain.dataRefForKey(testKey)
    XCTAssertNil(retrievedDataRef, "Data ref for Key should not exist")
  }
}