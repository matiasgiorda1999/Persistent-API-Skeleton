Class {
	#name : #NeoJSONWriterExtensionsTest,
	#superclass : #TestCase,
	#category : #'API-Skeleton-Tests'
}

{ #category : #tests }
NeoJSONWriterExtensionsTest >> testWriteRemoteReference [

	| object json |

	object := RemoteReference
		locatedAt: 'https://api.example.com/resource/00000000-0000-0000-0000-000000000000' asUrl.
	json := String
		streamContents: [ :stream | 
			( NeoJSONWriter on: stream )
				prettyPrint: true;
				mapRemoteReference;
				nextPut: object
			].

	self assert: json equals: '"https://api.example.com/resource/00000000-0000-0000-0000-000000000000"'
]
