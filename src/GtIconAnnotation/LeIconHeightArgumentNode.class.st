Class {
	#name : #LeIconHeightArgumentNode,
	#superclass : #LeIconArgumentNode,
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconHeightArgumentNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitHeightArgument: self
]
