Class {
	#name : #CreateEmptyRDBMSApplicationTest,
	#superclass : #TestCase,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #testing }
CreateEmptyRDBMSApplicationTest class >> isAbstract [

	^ self = CreateEmptyRDBMSApplicationTest
]

{ #category : #tests }
CreateEmptyRDBMSApplicationTest >> testCommandName [

	self assert: CreateEmptyRDBMSApplication commandName equals: 'create-empty-rdbms'
]

{ #category : #tests }
CreateEmptyRDBMSApplicationTest >> testDescription [

	self
		assert: CreateEmptyRDBMSApplication description
		equals: 'Creates the database structure'
]

{ #category : #tests }
CreateEmptyRDBMSApplicationTest >> testSectionsForSaganConfiguration [

	self assert: CreateEmptyRDBMSApplication sectionsForSaganConfiguration equals: #( 'Sagan' )
]
