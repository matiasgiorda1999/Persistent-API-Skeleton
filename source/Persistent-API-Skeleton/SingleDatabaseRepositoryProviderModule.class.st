Class {
	#name : #SingleDatabaseRepositoryProviderModule,
	#superclass : #SystemModule,
	#instVars : [
		'rootSystem',
		'login',
		'configurationAction'
	],
	#category : #'Persistent-API-Skeleton'
}

{ #category : #'instance creation' }
SingleDatabaseRepositoryProviderModule class >> toInstallOn: aCompositeSystem usingSessionPoolWith: aDatabaseLogin configuredBy: aConfigurationAction [

	^ self new
		  initializeToInstallOn: aCompositeSystem
		  usingSessionPoolWith: aDatabaseLogin
		  configuredBy: aConfigurationAction
]

{ #category : #initialization }
SingleDatabaseRepositoryProviderModule >> initializeToInstallOn: aCompositeSystem usingSessionPoolWith: aDatabaseLogin configuredBy: aConfigurationAction [

	rootSystem := aCompositeSystem.
	login := aDatabaseLogin.
	configurationAction := aConfigurationAction
]

{ #category : #private }
SingleDatabaseRepositoryProviderModule >> name [

	^'Single Database Repository Provider'
]

{ #category : #private }
SingleDatabaseRepositoryProviderModule >> registerRepositoryProviderSystemForInstallationIn: systems [

	^ self
		  register: [ 
			  RepositoryProviderSystem new
				  register:
					  ( RDBMSRepositoryProvider usingSessionPoolWith: login configuredBy: configurationAction )
				  as: #mainDB;
				  yourself
			  ]
		  in: systems
]

{ #category : #accessing }
SingleDatabaseRepositoryProviderModule >> rootSystem [

	^ rootSystem
]

{ #category : #private }
SingleDatabaseRepositoryProviderModule >> systemInterfacesToInstall [

	^#(RepositoryProviderSystem)
]
