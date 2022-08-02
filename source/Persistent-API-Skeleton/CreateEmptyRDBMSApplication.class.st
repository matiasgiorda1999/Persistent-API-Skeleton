Class {
	#name : #CreateEmptyRDBMSApplication,
	#superclass : #LaunchpadApplication,
	#classInstVars : [
		'Version'
	],
	#category : #'Persistent-API-Skeleton'
}

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> applicationBaselineName [

	self subclassResponsibility
]

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> commandName [

	^ 'create-empty-rdbms'
]

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> configurationParameters [

	^ self saganConfigurationParameters
]

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> description [

	^ 'Creates the database structure'
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> fileReferenceToDumpStackTrace [

	^ self logsDirectory / ( '<1s>-<2s>.fuel' expandMacrosWith: self commandName
		    with: ( ( ZTimestampFormat fromString: '2001-02-03_16-05-06.07' ) format: ZTimestamp now ) )
]

{ #category : #initialization }
CreateEmptyRDBMSApplication class >> initializeVersion [

	<ignoreForCoverage>
	Version := VersionFromRepositoryResolver new valueFor: self applicationBaselineName
]

{ #category : #testing }
CreateEmptyRDBMSApplication class >> isAbstract [

	^ self = CreateEmptyRDBMSApplication
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> logsDirectory [

	^ FileLocator workingDirectory / 'logs'
]

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> saganConfigurationParameters [

	self subclassResponsibility
]

{ #category : #accessing }
CreateEmptyRDBMSApplication class >> sectionsForSaganConfiguration [

	^ #( 'Sagan' )
]

{ #category : #versions }
CreateEmptyRDBMSApplication class >> version [

	^ Version
]

{ #category : #'private - activation' }
CreateEmptyRDBMSApplication >> basicStartWithin: context [

	| rootSystem |

	LaunchpadLogRecord emitInfo: 'Installing system'.
	rootSystem := self installation install: self class version.
	LaunchpadLogRecord emitInfo: 'Starting up system'.
	rootSystem startUp.
	LaunchpadLogRecord emitInfo: 'Setting up database structure'.
	( rootSystem >> #RepositoryProviderSystem ) prepareForInitialPersistence.
	LaunchpadLogRecord emitInfo: 'Shutting down system'.
	rootSystem shutDown.
	self exitSuccess
]

{ #category : #'private - accessing' }
CreateEmptyRDBMSApplication >> installation [

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
CreateEmptyRDBMSApplication >> saganConfiguration [

	^ self configuration sagan
]

{ #category : #'error handling' }
CreateEmptyRDBMSApplication >> stackTraceDumper [

	^ StackTraceBinarySerializer on: [ :dumpAction | 
		  self class fileReferenceToDumpStackTrace binaryWriteStreamDo: dumpAction ]
]
