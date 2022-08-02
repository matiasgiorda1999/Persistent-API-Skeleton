"
A RemoteReferenceTest is a test class for testing the behavior of RemoteReference
"
Class {
	#name : #RemoteReferenceTest,
	#superclass : #TestCase,
	#category : #'API-Skeleton-Tests'
}

{ #category : #tests }
RemoteReferenceTest >> testAccessing [

	self
		assert: ( RemoteReference locatedAt: 'https://google.com' asUrl ) selfLocation
		equals: 'https://google.com/'
]

{ #category : #tests }
RemoteReferenceTest >> testComparing [

	self
		assert: ( RemoteReference locatedAt: 'https://google.com' asUrl )
			equals: ( RemoteReference locatedAt: 'https://google.com/' asUrl );
		assert: ( RemoteReference locatedAt: 'https://google.com' asUrl ) hash
			equals: ( RemoteReference locatedAt: 'https://google.com/' asUrl ) hash.

	self
		deny: ( RemoteReference locatedAt: 'http://google.com' asUrl )
		equals: ( RemoteReference locatedAt: 'https://google.com' asUrl )
]
