"
A RDBMSMappingConfigurationTest is a test class for testing the behavior of RDBMSMappingConfiguration
"
Class {
	#name : #RDBMSMappingConfigurationTest,
	#superclass : #TestCase,
	#category : #'Persistent-API-Skeleton-Tests'
}

{ #category : #tests }
RDBMSMappingConfigurationTest >> testRemoteReferenceMapping [

	| definition |

	definition := RDBMSMappingConfiguration new remoteReferenceConversionDefinition.

	DatabasePlatform
		allSubclassesDo: [ :platformClass | 
			| converter field |

			field := DatabaseField named: 'self_location' type: ( platformClass new varChar: 256 ).
			converter := ( definition
				defineFor: ( DirectMapping from: #selfLocation to: field )
				using: ConfigurableDescriptorSystem new ) converter.

			self
				assert:
					( converter
						convert: ( RemoteReference locatedAt: 'http://api.example.com' asUrl )
						toDatabaseRepresentationAs: field type )
					equals: 'http://api.example.com/';
				assert: ( converter convert: 'http://api.example.com' fromDatabaseRepresentationAs: field type )
					equals: ( RemoteReference locatedAt: 'http://api.example.com' asUrl )
			]
]

{ #category : #tests }
RDBMSMappingConfigurationTest >> testUUIDMapping [

	| definition |

	definition := RDBMSMappingConfiguration new uuidConversionDefinition.

	DatabasePlatform
		allSubclassesDo: [ :platformClass | 
			| converter field |

			field := DatabaseField named: 'uuid' type: ( platformClass new varChar: 36 ).
			converter := ( definition
				defineFor: ( DirectMapping from: #uuid to: field )
				using: ConfigurableDescriptorSystem new ) converter.

			self
				assert: ( converter convert: UUID nilUUID toDatabaseRepresentationAs: field type )
					equals: '00000000-0000-0000-0000-000000000000';
				assert:
					( converter convert: '00000000-0000-0000-0000-000000000000' fromDatabaseRepresentationAs: field type )
					equals: UUID nilUUID
			]
]
