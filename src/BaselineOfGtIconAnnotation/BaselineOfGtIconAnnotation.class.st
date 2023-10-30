Class {
	#name : #BaselineOfGtIconAnnotation,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtIconAnnotation
}

{ #category : #baseline }
BaselineOfGtIconAnnotation >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtIconAnnotation'
		]
]
