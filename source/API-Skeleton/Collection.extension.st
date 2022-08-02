Extension { #name : #Collection }

{ #category : #'*API-Skeleton' }
Collection >> asNeoJSON [

	"This method is intended to work on dictionaries or collections of associations"

	^ self as: NeoJSONObject
]
