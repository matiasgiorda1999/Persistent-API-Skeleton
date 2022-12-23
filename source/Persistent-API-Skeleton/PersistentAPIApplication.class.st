Class {
	#name : #PersistentAPIApplication,
	#superclass : #ConsulAwareStargateApplication,
	#instVars : [
		'rootSystem'
	],
	#category : #'Persistent-API-Skeleton'
}

{ #category : #accessing }
PersistentAPIApplication class >> configurationParameters [

	^ super configurationParameters , self saganConfigurationParameters
]

{ #category : #testing }
PersistentAPIApplication class >> isAbstract [

	^ self = PersistentAPIApplication
]

{ #category : #accessing }
PersistentAPIApplication class >> saganConfigurationParameters [

	^ self subclassResponsibility
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryHealthCheckIntervalConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Healthcheck interval ms'
		  describedBy: 'Milliseconds to wait between service discovery health check invocations'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 10000
		  convertingWith: #asNumber
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Time Slot between retries in ms'
		  describedBy: 'Milliseconds to wait before retrying a call against Consul'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 100
		  convertingWith: #asNumber
]

{ #category : #private }
PersistentAPIApplication class >> serviceDiscoveryTimeoutConfigurationParameter [

	^ OptionalConfigurationParameter
		  named: 'Service Discovery Timeout ms'
		  describedBy:
		  'Milliseconds to wait before Consul will consider the service as dead when not responding'
		  inside: self sectionsForStargateConfiguration
		  defaultingTo: 60000
		  convertingWith: #asNumber
]

{ #category : #accessing }
PersistentAPIApplication class >> stargateConfigurationParameters [

	^ super stargateConfigurationParameters , { 
		  self serviceDiscoveryHealthCheckIntervalConfigurationParameter.
		  self serviceDiscoveryTimeoutConfigurationParameter.
		  self serviceDiscoveryTimeSlotBetweenRetriesConfigurationParameter }
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> basicStartWithin: context [

	self installAndStartRootSystem.
	self handleOptionsIn: context.
	super basicStartWithin: context
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> basicStop [ 

	super basicStop.
	LaunchpadLogRecord emitInfo: 'Stopping system'.
	rootSystem ifNotNil: #shutDown
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> handleOptionsIn: context [

	"I'm a template method. Subclasses can re-implement me to handle options."
]

{ #category : #'private - activation/deactivation' }
PersistentAPIApplication >> installAndStartRootSystem [

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
	rootSystem startUp
]

{ #category : #'private - accessing' }
PersistentAPIApplication >> installation [

	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
PersistentAPIApplication >> saganConfiguration [

	^ self configuration sagan
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckInterval [

	^ self stargateConfiguration serviceDiscoveryHealthcheckIntervalMs milliSeconds
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryHealthCheckTimeout [

	^ self stargateConfiguration serviceDiscoveryTimeoutMs milliSeconds
]

{ #category : #'private - building' }
PersistentAPIApplication >> serviceDiscoveryTimeSlotBetweenRetries [

	^ self stargateConfiguration serviceDiscoveryTimeSlotBetweenRetriesInMs milliSeconds
]
