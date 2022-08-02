Class {
	#name : #APISkeletonZnUrlExtensionsTest,
	#superclass : #TestCase,
	#category : #'API-Skeleton-Tests'
}

{ #category : #tests }
APISkeletonZnUrlExtensionsTest >> testNotEmpty [

	self
		assert: 'http://google.com' asUrl notEmpty;
		deny: '' asUrl notEmpty
]
