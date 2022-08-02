Class {
	#name : #NeoJSONReaderExtensionsTest,
	#superclass : #TestCase,
	#category : #'API-Skeleton-Tests'
}

{ #category : #private }
NeoJSONReaderExtensionsTest >> readAssociationFrom: string [

	| reader |

	reader := NeoJSONReader on: string readStream.
	reader
		for: Association
		strictDo: [ :mapping | 
			mapping
				mapInstVar: #key;
				mapInstVar: #value
			].

	^ reader nextAs: Association
]

{ #category : #private }
NeoJSONReaderExtensionsTest >> readRemoteReferenceFrom: aJSONString [

	| reader |

	reader := NeoJSONReader on: aJSONString readStream.
	reader
		mapRemoteReference;
		for: Association
			do: [ :mapping | 
			mapping mapProperty: #rel setter: [ :association :key | association key: key ].
			( mapping
				mapProperty: #href
				setter: [ :association :selfLocation | association value: selfLocation ] )
				valueSchema: RemoteReference
			].

	^ reader nextAs: Association
]

{ #category : #'tests - remote reference' }
NeoJSONReaderExtensionsTest >> testCantParseRemoteReferenceFromEmptyURL [

	self
		should: [ self readRemoteReferenceFrom: '{"rel":"self","href":""}' ]
		raise: NeoJSONParseError
		withMessageText: 'An empty location is not a valid URI'
]

{ #category : #'tests - remote reference' }
NeoJSONReaderExtensionsTest >> testCantParseRemoteReferenceFromInvalidURL [

	self
		should: [ self readRemoteReferenceFrom: '{"rel":"self","href":"http://foo:8080/foo?%%bar=1"}' ]
			raise: NeoJSONParseError
			withMessageText: 'Invalid URI';
		should: [ self readRemoteReferenceFrom: '{"rel":"self","href":"http://foo:bad/resource"}' ]
			raise: NeoJSONParseError
			withMessageText: 'Invalid URI'
]

{ #category : #'tests - remote reference' }
NeoJSONReaderExtensionsTest >> testCantParseRemoteReferenceFromNonStringObject [

	self
		should: [ self readRemoteReferenceFrom: '{"rel":"self","href":{}}' ]
		raise: NeoJSONParseError
		withMessageText: '" expected'
]

{ #category : #'tests - strict mode' }
NeoJSONReaderExtensionsTest >> testFailIfKeyAndValuePropertiesAreMissing [

	self
		should: [ self readAssociationFrom: '{}' ]
		raise: NeoJSONParseError
		withMessageText: 'Missing required keys (#key, #value)'
]

{ #category : #'tests - strict mode' }
NeoJSONReaderExtensionsTest >> testFailIfKeyPropertyIsMissing [

	self
		should: [ self readAssociationFrom: '{"value":1}' ]
		raise: NeoJSONParseError
		withMessageText: 'Missing required keys (#key)'
]

{ #category : #'tests - strict mode' }
NeoJSONReaderExtensionsTest >> testFailIfValuePropertyIsMissing [

	self
		should: [ self readAssociationFrom: '{"key":"one"}' ]
		raise: NeoJSONParseError
		withMessageText: 'Missing required keys (#value)'
]

{ #category : #'tests - remote reference' }
NeoJSONReaderExtensionsTest >> testParseRemoteReference [

	| object |

	object := self
		readRemoteReferenceFrom: '{"rel":"self","href":"https://api.example.com/resource/00000000-0000-0000-0000-000000000000"}'.

	self
		assert: object key equals: 'self';
		assert: object value selfLocation
			equals: 'https://api.example.com/resource/00000000-0000-0000-0000-000000000000'
]

{ #category : #'tests - strict mode' }
NeoJSONReaderExtensionsTest >> testParsingValidObject [

	| object |

	object := self readAssociationFrom: '{"key":"one","value":1}'.
	self
		assert: object key equals: 'one';
		assert: object value equals: 1
]

{ #category : #'tests - strict mode' }
NeoJSONReaderExtensionsTest >> testParsingValidObjectWithExtraFields [

	| object |

	object := self readAssociationFrom: '{"key":"one","value":1,"garbage":8}'.
	self
		assert: object key equals: 'one';
		assert: object value equals: 1
]
