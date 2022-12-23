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

{ #category : #private }
CreateEmptyRDBMSApplication class >> defaultMaxActiveSessionsCount [

	^ 5
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> defaultMaxConnectionAttemps [

	^ 3
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> defaultMaxIdleSessionsCount [

	^ 5
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> defaultMinIdleSessionsCount [

	^ 2
]

{ #category : #private }
CreateEmptyRDBMSApplication class >> defaultTimeSlotBetweenConnectionRetries [

	^ Duration milliSeconds: 3000
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

{ #category : #private }
CreateEmptyRDBMSApplication class >> saganSessionPoolingConfigurationParameters [

	^ Array
		  with: (OptionalConfigurationParameter
				   named: 'Min Idle Sessions Count'
				   describedBy:
				   'Minimum number of idle sessions to keep alive in the pool'
				   inside: self sectionsForSaganConfiguration
				   defaultingTo: self defaultMinIdleSessionsCount
				   convertingWith: #asNumber)
		  with: (OptionalConfigurationParameter
				   named: 'Max Idle Sessions Count'
				   describedBy:
				   'Maximum number of idle sessions to keep alive in the pool'
				   inside: self sectionsForSaganConfiguration
				   defaultingTo: self defaultMaxIdleSessionsCount
				   convertingWith: #asNumber)
		  with: (OptionalConfigurationParameter
				   named: 'Max Active Sessions Count'
				   describedBy: 'Maximum number of sessions alive'
				   inside: self sectionsForSaganConfiguration
				   defaultingTo: self defaultMaxActiveSessionsCount
				   convertingWith: #asNumber)
		  with: (OptionalConfigurationParameter
				   named: 'Maximum Connection Attemps'
				   describedBy: 'Number of retries login database attempts '
				   inside: self sectionsForSaganConfiguration
				   defaultingTo: self defaultMaxConnectionAttemps
				   convertingWith: #asNumber)
		  with: (OptionalConfigurationParameter
				   named: 'Time Slot Between Connection Retries In ms'
				   describedBy:
				   'Timeframe in milliseconds to wait before retrying a login to database '
				   inside: self sectionsForSaganConfiguration
				   defaultingTo: self defaultTimeSlotBetweenConnectionRetries
				   convertingWith: [ :parameter | Duration milliSeconds: parameter  asNumber ])
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
	Retry
		value: [ 
		rootSystem := self installation install: self class version ]
		configuredBy: [ :retry | 
			retry
				upTo: 5;
				backoffExponentiallyWithTimeSlot: 100 milliSeconds;
				on: DatabaseLoginFailed evaluating: [ :tryCount :loginFailure | 
					LaunchpadLogRecord emitInfo:
							'Retry installation. Attempt number ' , tryCount asString ] ].
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
