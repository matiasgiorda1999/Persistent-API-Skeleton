Extension { #name : #NeoJSONReader }

{ #category : #'*API-Skeleton' }
NeoJSONReader >> for: schemaName strictDo: block [

	| mapping |

	mapping := self strictMappingFor: schemaName.
	block value: mapping.
	^ mapping
]

{ #category : #'*API-Skeleton' }
NeoJSONReader >> mapRemoteReference [

	self
		for: RemoteReference
		customDo: [ :mapping | 
			mapping
				decoder: [ :location | 
					AssertionCheckerBuilder new
						raising: NeoJSONParseError;
						checking: [ :asserter | 
							asserter
								enforce: [ location isString ]
								because: '" expected'
								onSuccess:
									[ :successAsserter | successAsserter enforce: [ location notEmpty ] because: 'An empty location is not a valid URI' ]
							];
						buildAndCheck.
					RemoteReference
						locatedAt:
							( [ location asUrl ]
								on: ZnCharacterEncodingError , ZnPortNotANumber
								do: [ :error | self error: 'Invalid URI' ] )
					]
			]
]

{ #category : #'*API-Skeleton' }
NeoJSONReader >> strictMappingFor: smalltalkClass [

	^ self mappings
		at: smalltalkClass
		ifAbsentPut: [ NeoJSONStrictObjectMapping new
				subjectClass: smalltalkClass;
				yourself
			]
]
