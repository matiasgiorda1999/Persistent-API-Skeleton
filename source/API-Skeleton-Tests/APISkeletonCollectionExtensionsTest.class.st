Class {
	#name : #APISkeletonCollectionExtensionsTest,
	#superclass : #TestCase,
	#category : #'API-Skeleton-Tests'
}

{ #category : #tests }
APISkeletonCollectionExtensionsTest >> testAssociationArrayAsNeoJSON [

	self assert: { 'a' -> 'b' } asNeoJSON a equals: 'b'
]

{ #category : #tests }
APISkeletonCollectionExtensionsTest >> testDictionaryAsNeoJSON [

	self assert: { #key -> 'value' } asDictionary asNeoJSON key equals: 'value'
]
