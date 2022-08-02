Extension { #name : #NeoJSONWriter }

{ #category : #'*API-Skeleton' }
NeoJSONWriter >> mapRemoteReference [

	self
		for: RemoteReference
		customDo: [ :mapping | mapping encoder: [ :remoteReference | remoteReference selfLocation ] ]
]
