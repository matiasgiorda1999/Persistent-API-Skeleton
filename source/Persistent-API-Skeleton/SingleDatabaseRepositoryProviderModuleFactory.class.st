Class {
	#name : #SingleDatabaseRepositoryProviderModuleFactory,
	#superclass : #Object,
	#instVars : [
		'databaseConfiguration',
		'configurationAction'
	],
	#category : #'Persistent-API-Skeleton'
}

{ #category : #'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory class >> configuredBy: theDatabaseConfiguration [

	^ self configuredBy: theDatabaseConfiguration withPoolingOptions: [ :options |  ]
]

{ #category : #'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory class >> configuredBy: theDatabaseConfiguration withPoolingOptions: poolingOptionsConfigurationAction [

	^ self new initializeConfiguredBy: theDatabaseConfiguration withPoolingOptions: [ :options | 
		  theDatabaseConfiguration keysAndValuesDo: [ :key :value | options at: key ifAbsentPut: value ].
		  poolingOptionsConfigurationAction value: options
		  ]
]

{ #category : #testing }
SingleDatabaseRepositoryProviderModuleFactory class >> isAbstract [ 

	^self = SingleDatabaseRepositoryProviderModuleFactory
]

{ #category : #private }
SingleDatabaseRepositoryProviderModuleFactory >> databaseLogin [

	self subclassResponsibility
]

{ #category : #initialization }
SingleDatabaseRepositoryProviderModuleFactory >> initializeConfiguredBy: theDatabaseConfiguration
	withPoolingOptions: poolingOptionsConfigurationAction [

	databaseConfiguration := theDatabaseConfiguration.
	configurationAction := poolingOptionsConfigurationAction
]

{ #category : #'instance creation' }
SingleDatabaseRepositoryProviderModuleFactory >> toInstallOn: aCompositeSystem [

	| login |

	login := self databaseLogin.
	^ SingleDatabaseRepositoryProviderModule
		  toInstallOn: aCompositeSystem
		  usingSessionPoolWith: login
		  configuredBy: configurationAction
]
