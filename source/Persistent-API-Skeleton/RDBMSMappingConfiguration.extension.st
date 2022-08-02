Extension { #name : #RDBMSMappingConfiguration }

{ #category : #'*Persistent-API-Skeleton' }
RDBMSMappingConfiguration >> mappingForOptional: anAttributeName to: aFieldName on: aTableName [

	| dbToStConversion stToDbConversion |

	dbToStConversion := [ :valueOrNil | 
	                    valueOrNil ifNil: [ Optional unused ]
		                    ifNotNil: [ :value | Optional containing: value ] ].
	stToDbConversion := [ :optional | optional withContentDo: [ :value | value ] ifUnused: [ nil ] ].

	^ AdHocMappingDefinition forAttributeNamed: anAttributeName
		  sending: #value:
		  to: [ :value | value ]
		  toMapAssociations: { ( AdHocMappingFieldAndValueAssociation relating: #yourself
				    to: aFieldName
				    on: aTableName
				    convertingFromDatabaseToSmalltalkUsing: dbToStConversion
				    fromSmalltalkToDatabaseUsing: stToDbConversion ) }
]

{ #category : #'*Persistent-API-Skeleton' }
RDBMSMappingConfiguration >> remoteReferenceConversionDefinition [

	^ PluggableMappingConversionDefinition named: 'Remote Reference'
		  convertingFromDatabaseToSmalltalkUsing: [ :string | RemoteReference locatedAt: string asUrl ]
		  fromSmalltalkToDatabaseUsing: [ :reference | reference selfLocation asString ]
]

{ #category : #'*Persistent-API-Skeleton' }
RDBMSMappingConfiguration >> uuidConversionDefinition [

	^ PluggableMappingConversionDefinition named: 'UUID'
		  convertingFromDatabaseToSmalltalkUsing: [ :string | UUID fromString: string ]
		  fromSmalltalkToDatabaseUsing: [ :uuid | uuid printString ]
]
