Class {
	#name : #RemoteReference,
	#superclass : #Object,
	#instVars : [
		'selfLocation'
	],
	#category : #'API-Skeleton'
}

{ #category : #accessing }
RemoteReference class >> locatedAt: aUrl [

	^ self new initializeLocatedAt: aUrl
]

{ #category : #comparing }
RemoteReference >> = anObject [

	^ self equalityChecker
		compare: #selfLocation;
		checkAgainst: anObject
]

{ #category : #comparing }
RemoteReference >> hash [

	^ self selfLocation hash
]

{ #category : #initialization }
RemoteReference >> initializeLocatedAt: aUrl [

	selfLocation := aUrl asString
]

{ #category : #initialization }
RemoteReference >> selfLocation [

	^ selfLocation
]
